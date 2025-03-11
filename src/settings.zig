const c = @import("constant.zig");

const Button = struct {
    texture: c.rl.Texture2D,
    x: f32,
    y: f32,
    width: f32 = @as(f32, @floatFromInt(texture.width)) * scale,
    scale: f32,
    rotation: f32 = 0,
    color: c.rl.Color = c.rl.Color.white,

    fn draw(self: *const Button) void {
        c.rl.drawTextureEx(self.texture, c.rl.Vector2.init(self.x, self.y), self.rotation, self.scale, self.color);
    }

    fn isHover(self: *const Button) bool {
        const mouse_position: c.rl.Vector2 = c.rl.getMousePosition();

        if (mouse_position.x >= self.x and mouse_position.y >= self.y and ) {
            return true;
        }

        return false;
    }
};

var quit_button: Button = undefined;

pub fn initButtons() void {
    quit_button = Button{ .texture = c.tr.quit_button, .x = 265, .y = 500, .scale = 0.2 };
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

pub fn buttons_display() void {
    quit_button.draw();
    quit_button.color = if (quit_button.isHover()) c.rl.Color.gray else c.rl.Color.white;
}
