const c = @import("constant.zig");

const background_dimensions: c.rl.Rectangle = c.rl.Rectangle.init(100, 100, 400, 400);

const Button = struct {
    texture: c.rl.Texture2D,
    x: f32,
    y: f32,
    scale: f32,
    rotation: f32 = 0,
    color: c.rl.Color = c.rl.Color.white,
    type: ButtonType = ButtonType.BASIC,

    pub fn draw(self: *const Button) void {
        c.rl.drawTextureEx(self.texture, c.rl.Vector2.init(self.x, self.y), self.rotation, self.scale, self.color);
    }

    pub fn isHover(self: *const Button) bool {
        const mouse_position: c.rl.Vector2 = c.rl.getMousePosition();

        const width: f32 = @as(f32, @floatFromInt(self.texture.width)) * self.scale;
        const height: f32 = @as(f32, @floatFromInt(self.texture.height)) * self.scale;

        return mouse_position.x >= self.x and mouse_position.y >= self.y and mouse_position.x <= self.x + width and mouse_position.y <= self.y + height;
    }

    pub fn isClicked(self: *const Button) bool {
        const clicked: bool = isHover(self) and c.rl.isMouseButtonPressed(c.rl.MouseButton.left);

        if (clicked) playSound(self.type);
        return clicked;
    }
};

const ButtonType = enum {
    SMALL,
    BASIC,
    ARROW,
    BACK,
};

fn playSound(button_type: ButtonType) void {
    switch (button_type) {
        ButtonType.SMALL => c.sn.soundControl.play(c.sn.small_sound),
        ButtonType.BASIC => c.sn.soundControl.play(c.sn.button_sound),
        ButtonType.ARROW => c.sn.soundControl.play(c.sn.arrow_sound),
        ButtonType.BACK => c.sn.soundControl.play(c.sn.back_sound),
    }
}

var quit_button: Button = undefined;
var resume_button: Button = undefined;
var setting_background: Button = undefined;
var option_button: Button = undefined;

pub var setting_game_menu_button: Button = undefined;
pub var reset_button: Button = undefined;
pub var back_button: Button = undefined;
pub var pink_right_arrow: Button = undefined;
pub var blue_left_arrow: Button = undefined;
pub var blue_top_arrow: Button = undefined;
pub var pink_bottom_arrow: Button = undefined;
pub var game_over_image: Button = undefined;
pub var victory_panel: Button = undefined;
pub var victory_menu_button: Button = undefined;
pub var mute_state_button: Button = undefined;
pub var unmute_state_button: Button = undefined;
pub var pencil_button: Button = undefined;

pub var blanck_panel: Button = undefined;
pub var one_button: Button = undefined;
pub var two_button: Button = undefined;
pub var three_button: Button = undefined;
pub var four_button: Button = undefined;
pub var five_button: Button = undefined;
pub var six_button: Button = undefined;
pub var seven_button: Button = undefined;
pub var eight_button: Button = undefined;
pub var nine_button: Button = undefined;

pub fn initButtons() void {
    setting_background = Button{ .texture = c.tr.background_setting, .x = 100, .y = 100, .scale = 0.25 };
    resume_button = Button{ .texture = c.tr.resume_button, .x = 265, .y = 250, .scale = 0.2 };
    option_button = Button{ .texture = c.tr.option_button, .x = 260, .y = 355, .scale = 0.2 };
    quit_button = Button{ .texture = c.tr.quit_button, .x = 270, .y = 450, .scale = 0.19, .type = ButtonType.BACK };

    setting_game_menu_button = Button{ .texture = c.tr.start_setting_button, .x = 650, .y = 660, .scale = 0.14 };
    reset_button = Button{ .texture = c.tr.reset_button, .x = 580, .y = 30, .scale = 0.15, .type = ButtonType.ARROW };
    back_button = Button{ .texture = c.tr.back_button, .x = 305, .y = 475, .scale = 0.7, .type = ButtonType.BACK };
    pink_right_arrow = Button{ .texture = c.tr.pink_right_arrow, .x = 522, .y = 270, .scale = 0.5 };
    blue_left_arrow = Button{ .texture = c.tr.blue_left_arrow, .x = 420, .y = 270, .scale = 0.5 };
    blue_top_arrow = Button{ .texture = c.tr.blue_left_arrow, .x = 515, .y = 250, .scale = 0.5, .rotation = 90 };
    pink_bottom_arrow = Button{ .texture = c.tr.pink_right_arrow, .x = 515, .y = 305, .scale = 0.5, .rotation = 90 };
    game_over_image = Button{ .texture = c.tr.game_over, .x = 70, .y = 200, .scale = 0.73 };
    victory_panel = Button{ .texture = c.tr.victory_panel, .x = 70, .y = 185, .scale = 0.785 };
    victory_menu_button = Button{ .texture = c.tr.victory_menu_button, .x = 290, .y = 500, .scale = 0.7 };

    mute_state_button = Button{ .texture = c.tr.mute_state_button, .x = 220, .y = 340, .scale = 0.8 };
    unmute_state_button = Button{ .texture = c.tr.unmute_state_button, .x = 220, .y = 340, .scale = 0.8 };
    pencil_button = Button{ .texture = c.tr.pencil_button, .x = 515, .y = 30, .scale = 0.7, .type = ButtonType.ARROW };
    blanck_panel = Button{ .texture = c.tr.blanck_board_panel, .x = 170, .y = 220, .scale = 0.3 };

    one_button = Button{ .texture = c.tr.one_button, .x = 200, .y = 250, .scale = 1 };
    two_button = Button{ .texture = c.tr.two_button, .x = 280, .y = 250, .scale = 1 };
    three_button = Button{ .texture = c.tr.three_button, .x = 360, .y = 250, .scale = 1 };
    four_button = Button{ .texture = c.tr.four_button, .x = 440, .y = 250, .scale = 1 };
    five_button = Button{ .texture = c.tr.five_button, .x = 200, .y = 345, .scale = 1 };
    six_button = Button{ .texture = c.tr.six_button, .x = 280, .y = 345, .scale = 1 };
}

pub fn isPlayViewPressed() void {
    if (c.rl.isKeyPressed(c.rl.KeyboardKey.v)) {
        c.w.layer = c.w.Layer.PlayView;
    }
}

pub fn isGameMenuPressed() void {
    if (c.rl.isKeyPressed(c.rl.KeyboardKey.c)) {
        c.w.layer = c.w.Layer.GameMenuView;
    }
}
pub fn background_display() void {
    // c.rl.drawRectangleRoundedLinesEx(background_dimensions, 1.0, 1, 5, c.rl.Color.white);
    setting_background.draw();
}

pub fn buttons_display() void {
    quit_button.draw();
    resume_button.draw();
    option_button.draw();

    resume_button.color = if (resume_button.isHover()) c.rl.Color.gray else c.rl.Color.white;
    quit_button.color = if (quit_button.isHover()) c.rl.Color.gray else c.rl.Color.white;
    option_button.color = if (option_button.isHover()) c.rl.Color.gray else c.rl.Color.white;

    if (quit_button.isClicked()) {
        if (c.w.previous_layer == c.w.Layer.GameMenuView) {
            c.w.exitWindowByProgram = true;
        }
        if (c.w.previous_layer == c.w.Layer.PlayView) {
            c.w.layer = c.w.Layer.GameMenuView;
        }
    }

    if (resume_button.isClicked()) {
        c.w.layer = c.w.previous_layer;
    }

    if (option_button.isClicked()) {
        c.w.layer = c.w.Layer.OptionView;
    }
}
