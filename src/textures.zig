const c = @import("constant.zig");

pub var start_button_texture: c.rl.Texture2D = undefined;
pub var levels_button: c.rl.Texture2D = undefined;
pub var number_one: c.rl.Texture2D = undefined;
pub var number_two: c.rl.Texture2D = undefined;
pub var number_three: c.rl.Texture2D = undefined;
pub var number_four: c.rl.Texture2D = undefined;
pub var number_random: c.rl.Texture2D = undefined;
pub var arrow_clicker: c.rl.Texture2D = undefined;
pub var empty_heart: c.rl.Texture2D = undefined;
pub var full_heart: c.rl.Texture2D = undefined;
pub var settings_button: c.rl.Texture2D = undefined;
pub var quit_button: c.rl.Texture2D = undefined;
pub var resume_button: c.rl.Texture2D = undefined;
pub var background_setting: c.rl.Texture2D = undefined;
pub var start_setting_button: c.rl.Texture2D = undefined;
pub var option_button: c.rl.Texture2D = undefined;
pub var reset_button: c.rl.Texture2D = undefined;
pub var back_button: c.rl.Texture2D = undefined;
pub var pink_right_arrow: c.rl.Texture2D = undefined;
pub var blue_left_arrow: c.rl.Texture2D = undefined;
pub var game_over: c.rl.Texture2D = undefined;
pub var victory_panel: c.rl.Texture2D = undefined;
pub var victory_menu_button: c.rl.Texture2D = undefined;
pub var unmute_state_button: c.rl.Texture2D = undefined;
pub var mute_state_button: c.rl.Texture2D = undefined;

pub fn TexturesInit() !void {
    start_button_texture = try c.rl.loadTexture("image/start_button.png");
    levels_button = try c.rl.loadTexture("image/levels_button.png");

    number_one = try c.rl.loadTexture("image/number_one.png");
    number_two = try c.rl.loadTexture("image/number_two.png");
    number_three = try c.rl.loadTexture("image/number_three.png");
    number_four = try c.rl.loadTexture("image/number_four.png");
    number_random = try c.rl.loadTexture("image/random_number.png");
    arrow_clicker = try c.rl.loadTexture("image/arrow.png");

    empty_heart = try c.rl.loadTexture("image/heart_empty.png");
    full_heart = try c.rl.loadTexture("image/heart_filled.png");

    settings_button = try c.rl.loadTexture("image/settings_button.png");
    quit_button = try c.rl.loadTexture("image/quit_button.png");
    resume_button = try c.rl.loadTexture("image/resume_button.png");
    background_setting = try c.rl.loadTexture("image/background_setting.png");
    start_setting_button = try c.rl.loadTexture("image/start_setting_button.png");
    reset_button = try c.rl.loadTexture("image/reset_button.png");

    option_button = try c.rl.loadTexture("image/option_button.png");
    back_button = try c.rl.loadTexture("image/back_button.png");
    pink_right_arrow = try c.rl.loadTexture("image/pink_right_arrow.png");
    blue_left_arrow = try c.rl.loadTexture("image/blue_left_arrow.png");
    game_over = try c.rl.loadTexture("image/game_over.png");
    victory_panel = try c.rl.loadTexture("image/victory_panel.png");
    victory_menu_button = try c.rl.loadTexture("image/victory_menu_button.png");

    mute_state_button = try c.rl.loadTexture("image/mute_state_button.png");
    unmute_state_button = try c.rl.loadTexture("image/unmute_state_button.png");
}
