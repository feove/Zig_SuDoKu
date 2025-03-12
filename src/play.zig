const c = @import("constant.zig");

pub var start_life_number: u8 = 3;

var current_life: usize = start_life_number - 1;

pub var backendLifeBar: [3]bool = .{ true, true, true };

pub fn GameInit() void {
    if (c.gm.current_texture == 4) {
        backendLifeBar[2] = false;
        backendLifeBar[1] = false;
        start_life_number = 1;
    }

    if (c.gm.current_texture == 3) {
        backendLifeBar[1] = false;
        start_life_number = 2;
    }
}

pub fn loseLife() void {
    backendLifeBar[current_life] = false;

    if (current_life != 0) {
        current_life -= 1;
    } else {
        c.w.layer = c.w.Layer.EndGameView;
        c.w.previous_layer = c.w.Layer.PlayView;
    }
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
        }
    }

    c.rl.drawTextureEx(c.tr.settings_button, c.rl.Vector2.init(settings_x + 210, settings_y), 0, setting_scale, setting_color);
}

pub fn TopGridinterface() void {
    var heart_x: f32 = 500;
    const heart_y: f32 = 40;

    for (0..start_life_number) |i| {
        if (backendLifeBar[i]) {
            c.rl.drawTextureEx(c.tr.full_heart, c.rl.Vector2.init(heart_x, heart_y), 0, 0.4, c.rl.Color.white);
        } else {
            c.rl.drawTextureEx(c.tr.empty_heart, c.rl.Vector2.init(heart_x, heart_y), 0, 0.4, c.rl.Color.white);
        }
        heart_x -= 40;
    }

    const text: [:0]const u8 = switch (c.gm.current_texture) {
        1 => "Difficulty : Easy",
        2 => "Difficulty : Normal",
        3 => "Difficulty : Hard",
        4 => "Difficulty : Extrem",
        else => "Difficulty : Random",
    };

    //difficulty
    c.t.newText(c.t.ProtoNerdFont_Bold_30, text, 70, 45, 30, 0, c.rl.Color.black);
}
