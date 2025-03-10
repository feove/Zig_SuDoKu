const c = @import("constant.zig");

pub fn playPressed() void {
    if (c.rl.isKeyPressed(c.rl.KeyboardKey.s)) {
        c.w.layer = c.w.Layer.PlayView;
    }
}

pub fn settingsPressed() void {
    if (c.rl.isKeyPressed(c.rl.KeyboardKey.n)) {
        c.w.layer = c.w.Layer.SettingView;
    }
}

pub fn startButtonPressed() void {
    const button_x: f32 = 255;
    const button_y: f32 = 300;
    const button_width: f32 = @as(f32, @floatFromInt(c.tr.start_button_texture.width)) * 0.4;
    const button_height: f32 = @as(f32, @floatFromInt(c.tr.start_button_texture.height)) * 0.4;

    var button_color: c.rl.Color = c.rl.Color.white;

    const mouse_pos = c.rl.getMousePosition();

    const is_mouse_over = mouse_pos.x >= button_x and mouse_pos.x <= (button_x + button_width) and
        mouse_pos.y >= button_y and mouse_pos.y <= (button_y + button_height);

    if (is_mouse_over) {
        button_color = c.rl.Color.gray;

        if (c.rl.isMouseButtonPressed(c.rl.MouseButton.left)) {
            c.w.layer = c.w.Layer.PlayView;
        }
    }

    c.rl.drawTextureEx(c.tr.start_button_texture, c.rl.Vector2.init(button_x, button_y), 0, 0.4, button_color);
}

pub fn dropDownButtonPressed() void {
    const button_x: f32 = 255;
    var button_y: f32 = 430;
    const button_width: f32 = @as(f32, @floatFromInt(c.tr.start_button_texture.width)) * 0.4;
    const button_height: f32 = @as(f32, @floatFromInt(c.tr.start_button_texture.height)) * 0.4;

    var button_color: c.rl.Color = c.rl.Color.white;

    const mouse_pos = c.rl.getMousePosition();

    const is_mouse_over = mouse_pos.x >= button_x and mouse_pos.x <= (button_x + button_width) and
        mouse_pos.y >= button_y and mouse_pos.y <= (button_y + button_height);

    const textures_level_buttons: [4]c.rl.Texture2D = .{
        c.tr.easy_button,
        c.tr.normal_button,
        c.tr.hard_button,
        c.tr.extreme_button,
    };

    for (0..1) |i| {
        if (is_mouse_over) {
            button_color = c.rl.Color.gray;
        }
        c.rl.drawTextureEx(textures_level_buttons[i], c.rl.Vector2.init(button_x, button_y), 0, 0.9, button_color);
        button_y += 80;
    }
}
