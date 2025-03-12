const c = @import("constant.zig");

const background_dimensions: c.rl.Rectangle = c.rl.Rectangle.init(100, 100, 400, 400);

const Button = struct {
    texture: c.rl.Texture2D,
    x: f32,
    y: f32,
    scale: f32,
    rotation: f32 = 0,
    color: c.rl.Color = c.rl.Color.white,

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
        return isHover(self) and c.rl.isMouseButtonPressed(c.rl.MouseButton.left);
    }
};

//Initialization of buttons
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

pub fn initButtons() void {
    setting_background = Button{ .texture = c.tr.background_setting, .x = 100, .y = 100, .scale = 0.25 };
    resume_button = Button{ .texture = c.tr.resume_button, .x = 265, .y = 250, .scale = 0.2 };
    option_button = Button{ .texture = c.tr.option_button, .x = 260, .y = 355, .scale = 0.2 };
    quit_button = Button{ .texture = c.tr.quit_button, .x = 270, .y = 450, .scale = 0.19 };

    setting_game_menu_button = Button{ .texture = c.tr.start_setting_button, .x = 650, .y = 660, .scale = 0.14 };
    reset_button = Button{ .texture = c.tr.reset_button, .x = 580, .y = 30, .scale = 0.15 };
    back_button = Button{ .texture = c.tr.back_button, .x = 305, .y = 475, .scale = 0.7 };
    pink_right_arrow = Button{ .texture = c.tr.pink_right_arrow, .x = 522, .y = 270, .scale = 0.5 };
    blue_left_arrow = Button{ .texture = c.tr.blue_left_arrow, .x = 420, .y = 270, .scale = 0.5 };
    blue_top_arrow = Button{ .texture = c.tr.blue_left_arrow, .x = 515, .y = 250, .scale = 0.5, .rotation = 90 };
    pink_bottom_arrow = Button{ .texture = c.tr.pink_right_arrow, .x = 515, .y = 305, .scale = 0.5, .rotation = 90 };
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
