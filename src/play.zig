const c = @import("constant.zig");

const start_life_number: u8 = 3;

var current_life: usize = start_life_number - 1;

pub var backendLifeBar: [start_life_number]bool = lifeBarInit();

fn lifeBarInit() [start_life_number]bool {

    //I Will put a Level Condition
    return .{ true, true, true };
}

pub fn settingPressed() void {
    if (c.rl.isKeyPressed(c.rl.KeyboardKey.n)) {
        c.w.layer = c.w.Layer.SettingView;
    }

    //Test
    if (c.rl.isKeyPressed(c.rl.KeyboardKey.m)) {
        loseLife();
    }
}

fn loseLife() void {
    backendLifeBar[current_life] = false;

    if (current_life != 0) {
        current_life -= 1;
    }
}

pub fn endPressed() void {
    if (c.rl.isKeyPressed(c.rl.KeyboardKey.b)) {
        c.w.layer = c.w.Layer.EndGameView;
    }
}

pub fn TopGridinterface() void {
    var heart_x: f32 = 670;
    const heart_y: f32 = 50;

    const settings_x: f32 = 430;
    const settings_y: f32 = 20;

    for (0..start_life_number) |i| {
        if (backendLifeBar[i]) {
            c.rl.drawTextureEx(c.tr.full_heart, c.rl.Vector2.init(heart_x, heart_y), 0, 0.4, c.rl.Color.white);
        } else {
            c.rl.drawTextureEx(c.tr.empty_heart, c.rl.Vector2.init(heart_x, heart_y), 0, 0.4, c.rl.Color.white);
        }
        heart_x -= 40;
    }

    const text: [:0]const u8 = switch (c.gm.current_texture) {
        1 => "Difficulty : Easy",
        2 => "Difficulty : Normal",
        3 => "Difficulty : Hard",
        4 => "Difficulty : Extrem",
        else => "Difficulty : Random",
    };

    //difficulty
    c.t.newText(c.t.ProtoNerdFont_Bold_30, text, 70, 45, 30, 0, c.rl.Color.black);

    c.rl.drawTextureEx(c.tr.settings_button, c.rl.Vector2.init(settings_x, settings_y), 0, 0.150, c.rl.Color.white);
}
