const c = @import("constant.zig");

pub var start_button_texture: c.rl.Texture2D = undefined;
pub var levels_button: c.rl.Texture2D = undefined;
pub var number_one: c.rl.Texture2D = undefined;
pub var number_two: c.rl.Texture2D = undefined;
pub var number_three: c.rl.Texture2D = undefined;
pub var number_four: c.rl.Texture2D = undefined;
pub var number_random: c.rl.Texture2D = undefined;
pub var arrow_clicker: c.rl.Texture2D = undefined;

pub fn TexturesInit() !void {
    start_button_texture = try c.rl.loadTexture("image/start_button.png");
    levels_button = try c.rl.loadTexture("image/levels_button.png");

    number_one = try c.rl.loadTexture("image/number_one.png");
    number_two = try c.rl.loadTexture("image/number_two.png");
    number_three = try c.rl.loadTexture("image/number_three.png");
    number_four = try c.rl.loadTexture("image/number_four.png");
    number_random = try c.rl.loadTexture("image/random_number.png");
    arrow_clicker = try c.rl.loadTexture("image/arrow.png");
}
