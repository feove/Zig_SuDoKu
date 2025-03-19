const c = @import("constant.zig");

const SoundDisplay = struct {
    canPlayAllSound: bool = true,

    pub fn play(self: *const SoundDisplay, sound: c.rl.Sound) void {
        if (self.canPlayAllSound) {
            c.rl.playSound(sound);
        }
    }

    pub fn muteAll(self: *const SoundDisplay) void {
        self.canPlayAllSound = false;
    }

    pub fn demuteAll(self: *const SoundDisplay) void {
        self.canPlayAllSound = true;
    }
};

pub var button_sound: c.rl.Sound = undefined;
pub var back_sound: c.rl.Sound = undefined;
pub var arrow_sound: c.rl.Sound = undefined;
pub var small_sound: c.rl.Sound = undefined;
pub var game_over_sound: c.rl.Sound = undefined;
pub var wrong_sound: c.rl.Sound = undefined;
pub var rdn056: c.rl.Sound = undefined;
pub var soundControl = SoundDisplay{};

pub fn soundInit() !void {
    if (!c.rl.isAudioDeviceReady()) {
        c.rl.initAudioDevice();
        back_sound = try c.rl.loadSound("sound/back_button.mp3");
        button_sound = try c.rl.loadSound("sound/button.mp3");
        arrow_sound = try c.rl.loadSound("sound/arrow_button.mp3");
        small_sound = try c.rl.loadSound("sound/small_button.mp3");
        game_over_sound = try c.rl.loadSound("sound/game_over.mp3");
        wrong_sound = try c.rl.loadSound("sound/wrong.mp3");
        rdn056 = try c.rl.loadSound("sound/rdn056.mp3");
    }
}
