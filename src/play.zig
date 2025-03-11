const c = @import("constant.zig");

const start_life_number: u8 = 3;

var current_life: usize = start_life_number - 1;

pub var backendLifeBar: [start_life_number]bool = .{ true, true, true };

pub fn GameInit() void {
    backendLifeBar[1] = if (c.gm.current_texture == 4) false else true;
    backendLifeBar[2] = if (c.gm.current_texture == 4 or c.gm.current_texture == 3) false else true;
}

fn loseLife() void {
    backendLifeBar[current_life] = false;

    if (current_life != 0) {
        current_life -= 1;
    } else {
        c.w.layer = c.w.Layer.EndGameView;
    }
}

pub fn endPressed() void {
    if (c.rl.isKeyPressed(c.rl.KeyboardKey.b)) {
        c.w.layer = c.w.Layer.EndGameView;
    }
}

pub fn TopGridinterface() void {
    var heart_x: f32 = 550;
    const heart_y: f32 = 40;

    const settings_x: f32 = 430;
    const settings_y: f32 = 20;
    const setting_width: f32 = @as(f32, @floatFromInt(c.tr.settings_button.width)) * 0.4;
    const setting_height: f32 = @as(f32, @floatFromInt(c.tr.settings_button.height)) * 0.4;

    const mouse_pos = c.rl.getMousePosition();

    const is_mouse_over_settings = mouse_pos.x >= settings_x + 200 and mouse_pos.x <= (settings_x + setting_width + 120) and
        mouse_pos.y >= settings_y and mouse_pos.y <= (settings_y + setting_height - 80);

    var setting_color: c.rl.Color = c.rl.Color.white;

    if (is_mouse_over_settings) {
        setting_color = c.rl.Color.gray;
        if (c.rl.isMouseButtonPressed(c.rl.MouseButton.left)) {
            c.w.layer = c.w.Layer.SettingView;
        }
    }

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

    c.rl.drawTextureEx(c.tr.settings_button, c.rl.Vector2.init(settings_x + 210, settings_y), 0, 0.150, setting_color);
}
