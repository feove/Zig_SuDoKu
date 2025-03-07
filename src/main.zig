const c = @import("constant.zig");

pub const screenWidth = 770;
pub const screenHeight = 770;
pub fn main() anyerror!void {
    c.rl.initWindow(screenWidth, screenHeight, "SuDoKu Game");
    defer c.rl.closeWindow();

    c.rl.setTargetFPS(60);

    c.clear();

    try c.g.gridInit();

    while (!c.rl.windowShouldClose()) {
        if (c.w.windowHasBeenQuit()) break;

        c.rl.beginDrawing();
        defer c.rl.endDrawing();

        c.rl.drawFPS(20, 20);

        c.g.updateCellSelector();

        c.g.isIntegerPressed();

        c.rl.clearBackground(c.rl.Color.white);
    }
}
