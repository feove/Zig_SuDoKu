const c = @import("constant.zig");

var current_life: usize = 2;

pub var backendLifeBar: [3]bool = .{ true, true, true };

pub fn GameInit() void {
    backendLifeBar = .{ true, true, true };

    current_life = 2;

    if (c.gm.current_texture == 4) {
        backendLifeBar[2] = false;
        backendLifeBar[1] = false;
        current_life = 0;
    }

    if (c.gm.current_texture == 3) {
        backendLifeBar[2] = false;
        current_life = 1;
    }
}

pub fn loseLife() void {
    if (current_life == 0) {
        backendLifeBar[0] = false;

        c.w.layer = c.w.Layer.EndGameView;

        TopGridinterface();
        c.g.drawFrontEndGrid();
        //c.go.paintInRedWrongCells();

        c.sn.soundControl.play(c.sn.game_over_sound);
        return;
    }

    backendLifeBar[current_life] = false;
    current_life -= 1;
}

pub fn endPressed() void {
    if (c.rl.isKeyPressed(c.rl.KeyboardKey.b)) {
        c.w.layer = c.w.Layer.EndGameView;
    }
}

pub fn resetPressed() !void {
    if (c.rl.isKeyPressed(c.rl.KeyboardKey.r)) {
        try c.g.gridReset();
    }
}

pub fn settingsOrResetButtons() !void {
    c.s.reset_button.draw();
    c.s.reset_button.color = c.rl.Color.white;
    c.s.reset_button.scale = 0.15;
    if (c.s.reset_button.isHover()) {
        c.s.reset_button.color = c.rl.Color.gray;
        c.s.reset_button.scale = 0.156;
    }

    if (c.s.reset_button.isClicked()) {
        try c.g.gridReset();
    }

    const settings_x: f32 = 430;
    const settings_y: f32 = 30;
    const setting_width: f32 = @as(f32, @floatFromInt(c.tr.settings_button.width)) * 0.4;
    const setting_height: f32 = @as(f32, @floatFromInt(c.tr.settings_button.height)) * 0.4;

    const mouse_pos = c.rl.getMousePosition();

    const is_mouse_over_settings = mouse_pos.x >= settings_x + 200 and mouse_pos.x <= (settings_x + setting_width + 120) and
        mouse_pos.y >= settings_y and mouse_pos.y <= (settings_y + setting_height - 80);

    var setting_color: c.rl.Color = c.rl.Color.white;
    var setting_scale: f32 = 0.15;

    if (is_mouse_over_settings) {
        setting_color = c.rl.Color.gray;
        setting_scale = 0.156;
        if (c.rl.isMouseButtonPressed(c.rl.MouseButton.left)) {
            c.w.layer = c.w.Layer.SettingView;
            c.sn.soundControl.play(c.sn.arrow_sound);
        }
    }

    c.rl.drawTextureEx(c.tr.settings_button, c.rl.Vector2.init(settings_x + 210, settings_y), 0, setting_scale, setting_color);
}

pub fn pencilButton() void {
    const x = c.g.currentCellBackEnd.x;
    const y = c.g.currentCellBackEnd.y;

    if (c.g.BackendgridLocation.?.*[y][x] == 0 and !isExceptionCell(x, y)) {
        //c.s.pencil_button.x = @as(f32, @floatFromInt(c.g.FrontendgridLocation.?.*[c.g.currentCellBackEnd.x][c.g.currentCellBackEnd.y].x));
        //c.s.pencil_button.y = @as(f32, @floatFromInt(c.g.FrontendgridLocation.?.*[c.g.currentCellBackEnd.x][c.g.currentCellBackEnd.y].y)) - 5;

        if (!c.s.pencil_button.isHover()) {
            c.s.pencil_button.color = c.rl.Color.white;
            c.s.pencil_button.scale = 0.7;
        } else {
            c.s.pencil_button.scale = 0.75;
        }

        c.s.pencil_button.draw();

        if (c.s.pencil_button.isClicked()) {
            c.w.layer = c.w.Layer.DraftSheetView;
            c.sn.soundControl.play(c.sn.arrow_sound);
        }
    }
}

fn isExceptionCell(x: u8, y: u8) bool {
    const same_x: bool = x == c.go.cellExceptions.?.*[0].i_backend or x == c.go.cellExceptions.?.*[1].i_backend;
    const same_y: bool = y == c.go.cellExceptions.?.*[0].j_backend or y == c.go.cellExceptions.?.*[1].j_backend;

    return same_x and same_y;
}

pub fn TopGridinterface() void {
    var heart_x: f32 = 420;
    const heart_y: f32 = 40;

    for (0..3) |i| {
        if (backendLifeBar[i]) {
            c.rl.drawTextureEx(c.tr.full_heart, c.rl.Vector2.init(heart_x, heart_y), 0, 0.4, c.rl.Color.white);
        } else {
            c.rl.drawTextureEx(c.tr.empty_heart, c.rl.Vector2.init(heart_x, heart_y), 0, 0.4, c.rl.Color.white);
        }
        heart_x -= 40;
    }

    const text: [:0]const u8 = switch (c.gm.current_texture) {
        1 => "Level : Easy",
        2 => "Level : Normal",
        3 => "Level : Hard",
        4 => "Level : Extrem",
        else => "Level : Random",
    };

    //difficulty
    c.t.newText(c.t.ProtoNerdFont_Bold_30, text, 70, 40, 30, 0, c.rl.Color.black);
}

pub fn isVictory() void {
    for (0..9) |i| {
        for (0..9) |j| {
            if (c.gs.copy_for_backend_and_frontend.?.*[i][j] == 0) {
                return;
            }
        }
    }
    c.w.layer = c.w.Layer.VictoryView;
}
