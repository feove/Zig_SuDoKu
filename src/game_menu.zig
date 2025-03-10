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

pub fn levelButton() void {
    const button_x: f32 = 265;
    const button_y: f32 = 400;

    const bright_white = c.rl.Color{
        .r = 255,
        .g = 255,
        .b = 255,
        .a = 255,
    };

    c.rl.drawTextureEx(c.tr.levels_button, c.rl.Vector2.init(button_x, button_y), 0, 0.2, bright_white);
}

pub fn doubleArrowsSet() void {
    const button_x: f32 = 260;
    const button_y: f32 = 560;
    const button_width: f32 = @as(f32, @floatFromInt(c.tr.start_button_texture.width)) * 0.4;
    const button_height: f32 = @as(f32, @floatFromInt(c.tr.start_button_texture.height)) * 0.4;

    var top_arrow_color: c.rl.Color = c.rl.Color.white;
    var bottom_arrow_color: c.rl.Color = c.rl.Color.white;

    const mouse_pos = c.rl.getMousePosition();

    const is_mouse_over_top_arrow = mouse_pos.x >= button_x - 50 and mouse_pos.x <= (button_x + button_width - 250) and
        mouse_pos.y >= button_y - 50 and mouse_pos.y <= (button_y + button_height - 80);

    const is_mouse_over_bottom_arrow = mouse_pos.x >= button_x - 50 and mouse_pos.x <= (button_x + button_width - 250) and
        mouse_pos.y >= button_y + 5 and mouse_pos.y <= (button_y + button_height - 5);

    if (is_mouse_over_top_arrow) {
        top_arrow_color = c.rl.Color.gray;

        if (c.rl.isMouseButtonPressed(c.rl.MouseButton.left)) {
            top_arrow_color = c.rl.Color.yellow;
        }
    }

    if (is_mouse_over_bottom_arrow) {
        bottom_arrow_color = c.rl.Color.gray;

        if (c.rl.isMouseButtonPressed(c.rl.MouseButton.left)) {
            bottom_arrow_color = c.rl.Color.yellow;
        }
    }

    c.rl.drawTextureEx(c.tr.arrow_clicker, c.rl.Vector2.init(button_x, button_y), 180, 0.4, top_arrow_color);
    c.rl.drawTextureEx(c.tr.arrow_clicker, c.rl.Vector2.init(button_x - 60, button_y + 10), 0, 0.4, bottom_arrow_color);
}

var current_texture: u8 = 1;

pub fn dropDownButtonPressed() void {
    const button_x: f32 = 340;
    const button_y: f32 = 530;
    const button_width: f32 = @as(f32, @floatFromInt(c.tr.start_button_texture.width)) * 0.4;
    const button_height: f32 = @as(f32, @floatFromInt(c.tr.start_button_texture.height)) * 0.4;

    var number_color: c.rl.Color = c.rl.Color.white;

    const mouse_pos = c.rl.getMousePosition();

    const is_mouse_over = mouse_pos.x >= button_x and mouse_pos.x <= (button_x + button_width) and
        mouse_pos.y >= button_y and mouse_pos.y <= (button_y + button_height);

    if (is_mouse_over) {
        number_color = c.rl.Color.gray;
    }

    const textures_level_buttons: [5]c.rl.Texture2D = .{
        c.tr.number_one,
        c.tr.number_two,
        c.tr.number_three,
        c.tr.number_four,
        c.tr.number_random,
    };

    c.rl.drawTextureEx(textures_level_buttons[current_texture], c.rl.Vector2.init(button_x, button_y), 0, 0.8, number_color);
}
