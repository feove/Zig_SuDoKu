const c = @import("constant.zig");

pub var start_button_texture: c.rl.Texture2D = undefined;

pub fn TexturesInit() !void {
    const start_button_path = "image/start_button.png";
    start_button_texture = try c.rl.loadTexture(start_button_path);
}
