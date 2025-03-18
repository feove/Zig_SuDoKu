const c = @import("constant.zig");

pub fn playPressed() void {
    if (c.rl.isKeyPressed(c.rl.KeyboardKey.s)) {
        c.w.previous_layer = c.w.Layer.GameMenuView;
        c.w.layer = c.w.Layer.PlayView;
        c.sn.soundControl.play(c.sn.button_sound);
    }
}

pub fn settingsPressed() void {
    if (c.rl.isKeyPressed(c.rl.KeyboardKey.n)) {
        c.w.previous_layer = c.w.Layer.GameMenuView;
        c.w.layer = c.w.Layer.SettingView;
        c.sn.soundControl.play(c.sn.button_sound);
    }
}

pub fn startButtonPressed() void {
    const button_x: f32 = 245;
    const button_y: f32 = 300;
    const button_width: f32 = @as(f32, @floatFromInt(c.tr.start_button_texture.width)) * 0.4;
    const button_height: f32 = @as(f32, @floatFromInt(c.tr.start_button_texture.height)) * 0.4;

    var button_color: c.rl.Color = c.rl.Color.white.brightness(100);

    const mouse_pos = c.rl.getMousePosition();

    const is_mouse_over = mouse_pos.x >= button_x and mouse_pos.x <= (button_x + button_width - 250) and
        mouse_pos.y >= button_y and mouse_pos.y <= (button_y + button_height - 90);

    if (is_mouse_over) {
        button_color = c.rl.Color.gray;

        if (c.rl.isMouseButtonPressed(c.rl.MouseButton.left)) {
            c.w.layer = c.w.Layer.PlayView;
            c.w.previous_layer = c.w.Layer.PlayView;
            c.p.GameInit();
            c.w.CanGameOver = true;

            c.sn.soundControl.play(c.sn.button_sound);
        }
    }

    c.rl.drawTextureEx(c.tr.start_button_texture, c.rl.Vector2.init(button_x, button_y), 0, 0.2, button_color);
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
    var button_x: f32 = 260;
    const button_y: f32 = 560;

    var top_arrow_color: c.rl.Color = c.rl.Color.white;
    var bottom_arrow_color: c.rl.Color = c.rl.Color.white;

    var top_arrow_scale: f32 = 0.4;
    var bottom_arrow_scale: f32 = 0.4;

    const mouse_pos = c.rl.getMousePosition();

    const is_mouse_over_top_arrow = mouse_pos.x >= button_x - 50 and mouse_pos.x <= (button_x - 10) and
        mouse_pos.y >= button_y - 70 and mouse_pos.y <= (button_y - 10);

    const is_mouse_over_bottom_arrow = mouse_pos.x >= button_x - 50 and mouse_pos.x <= (button_x - 10) and
        mouse_pos.y >= button_y + 10 and mouse_pos.y <= (button_y + 70);

    if (is_mouse_over_top_arrow) {
        top_arrow_color = c.rl.Color.gray;
        top_arrow_scale = 0.45;
        button_x += 3;

        if (c.rl.isMouseButtonPressed(c.rl.MouseButton.left)) {
            top_arrow_color = c.rl.Color.yellow;
            if (current_texture != 4) {
                current_texture += 1;
            }
            c.sn.soundControl.play(c.sn.arrow_sound);
        }
    }

    if (is_mouse_over_bottom_arrow) {
        bottom_arrow_color = c.rl.Color.gray;
        bottom_arrow_scale = 0.45;

        if (c.rl.isMouseButtonPressed(c.rl.MouseButton.left)) {
            bottom_arrow_color = c.rl.Color.yellow;
            if (current_texture != 0) {
                current_texture -= 1;
            }
            c.sn.soundControl.play(c.sn.arrow_sound);
        }
    }

    c.rl.drawTextureEx(c.tr.arrow_clicker, c.rl.Vector2.init(button_x, button_y), 180, top_arrow_scale, top_arrow_color);
    c.rl.drawTextureEx(c.tr.arrow_clicker, c.rl.Vector2.init(button_x - 60, button_y + 10), 0, bottom_arrow_scale, bottom_arrow_color);
}

pub var current_texture: u8 = 2;

pub fn dropDownButtonPressed() void {
    const button_x: f32 = 355;
    const button_y: f32 = 530;
    //const button_width: f32 = @as(f32, @floatFromInt(c.tr.start_button_texture.width)) * 0.4;
    //const button_height: f32 = @as(f32, @floatFromInt(c.tr.start_button_texture.height)) * 0.4;

    var number_color: c.rl.Color = c.rl.Color.white;

    const mouse_pos = c.rl.getMousePosition();

    const is_mouse_over = mouse_pos.x >= button_x and mouse_pos.x <= (button_x + 50) and
        mouse_pos.y >= button_y and mouse_pos.y <= (button_y + 60);

    var number_scale: f32 = 0.8;
    if (is_mouse_over) {
        number_scale = 0.9;
        number_color = c.rl.Color.yellow;
    }

    const textures_level_buttons: [5]c.rl.Texture2D = .{
        c.tr.number_random,
        c.tr.number_one,
        c.tr.number_two,
        c.tr.number_three,
        c.tr.number_four,
    };

    c.rl.drawTextureEx(textures_level_buttons[current_texture], c.rl.Vector2.init(button_x, button_y), 0, number_scale, number_color);
}

pub fn settingButton() void {
    c.s.setting_game_menu_button.draw();

    if (c.s.setting_game_menu_button.isHover()) {
        c.s.setting_game_menu_button.color = c.rl.Color.gray;
        c.s.setting_game_menu_button.scale = 0.15;
    } else {
        c.s.setting_game_menu_button.color = c.rl.Color.white;
        c.s.setting_game_menu_button.scale = 0.14;
    }

    if (c.s.setting_game_menu_button.isClicked()) {
        c.w.layer = c.w.Layer.SettingView;
        c.w.previous_layer = c.w.Layer.GameMenuView;
    }
}
