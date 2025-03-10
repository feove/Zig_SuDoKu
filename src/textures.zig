const c = @import("constant.zig");

pub var start_button_texture: c.rl.Texture2D = undefined;

pub var easy_button: c.rl.Texture2D = undefined;
pub var normal_button: c.rl.Texture2D = undefined;
pub var hard_button: c.rl.Texture2D = undefined;
pub var extreme_button: c.rl.Texture2D = undefined;

pub fn TexturesInit() !void {
    start_button_texture = try c.rl.loadTexture("image/start_button.png");
    easy_button = try c.rl.loadTexture("image/easy_button.png");
    normal_button = try c.rl.loadTexture("image/normal_button.png");
    hard_button = try c.rl.loadTexture("image/hard_button.png");
    extreme_button = try c.rl.loadTexture("image/extreme_button.png");
}
