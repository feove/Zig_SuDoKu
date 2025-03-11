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

var quit_button: Button = undefined;
var resume_button: Button = undefined;
var setting_background: Button = undefined;
var option_button: Button = undefined;

pub var setting_game_menu_button: Button = undefined;

pub fn initButtons() void {
    quit_button = Button{ .texture = c.tr.quit_button, .x = 270, .y = 500, .scale = 0.19 };
    resume_button = Button{ .texture = c.tr.resume_button, .x = 265, .y = 300, .scale = 0.2 };
    option_button = Button{ .texture = c.tr.option_button, .x = 260, .y = 400, .scale = 0.2 };
    setting_background = Button{ .texture = c.tr.background_setting, .x = 100, .y = 100, .scale = 0.25 };
    setting_game_menu_button = Button{ .texture = c.tr.start_setting_button, .x = 600, .y = 605, .scale = 0.14 };
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
            //
        }
        c.w.layer = c.w.Layer.PlayView;
        c.w.layer = c.w.Layer.GameMenuView;
    }

    if (resume_button.isClicked()) {
        c.w.layer = c.w.previous_layer;
        c.w.previous_layer = c.w.Layer.SettingView;
    }
}
