const c = @import("constant.zig");

pub const screenWidth = 770;
pub const screenHeight = 770;

pub fn main() anyerror!void {
    c.rl.initWindow(screenWidth, screenHeight, "SuDoKu Game");
    defer c.rl.closeWindow();

    c.rl.setTargetFPS(60);

    c.clear();

    try c.g.BackendgridInit();
    try c.g.FrontendgridInit();

    while (!c.rl.windowShouldClose()) {
        if (c.w.windowHasBeenQuit()) break;

        c.rl.beginDrawing();
        defer c.rl.endDrawing();

        try switch (c.w.layer) {
            (c.w.Layer.GameMenuView) => c.w.GameMenuLayer(),
            (c.w.Layer.EndGameView) => c.w.EndGameLayer(),
            (c.w.Layer.PlayView) => c.w.PlayLayer(),
            (c.w.Layer.SettingView) => c.w.SettingLayer(),
        };
    }
}
