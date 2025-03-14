const c = @import("constant.zig");

pub const screenWidth = 770;
pub const screenHeight = 770;

pub fn main() anyerror!void {
    c.rl.initWindow(screenWidth, screenHeight, "SuDoKu Game");
    defer c.rl.closeWindow();

    c.rl.setTargetFPS(60);
    c.rl.clearBackground(c.rl.Color.white);

    //Fonts
    try c.t.FontInit();

    //Textures
    try c.tr.TexturesInit();
    c.s.initButtons();

    c.clear();

    while (!c.rl.windowShouldClose() and !c.w.windowHasBeenQuit() and !c.w.exitWindowByProgram) {
        c.rl.beginDrawing();
        defer c.rl.endDrawing();

        try switch (c.w.layer) {
            (c.w.Layer.GameMenuView) => c.w.GameMenuLayer(),
            (c.w.Layer.EndGameView) => c.w.EndGameLayer(),
            (c.w.Layer.PlayView) => c.w.PlayLayer(),
            (c.w.Layer.SettingView) => c.w.SettingLayer(),
            (c.w.Layer.OptionView) => c.w.OptionsLayer(),
            (c.w.Layer.VictoryView) => c.w.VictoryLayer(),
        };
    }
}
