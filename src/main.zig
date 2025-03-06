const c = @import("constant.zig");

pub const screenWidth = 800;
pub const screenHeight = 800;
pub fn main() anyerror!void {
    c.rl.initWindow(screenWidth, screenHeight, "SuDoKu Game");
    defer c.rl.closeWindow(); // Close window and OpenGL context

    c.rl.setTargetFPS(60);

    c.clear();

    try c.g.gridInit();

    while (!c.rl.windowShouldClose()) { // Detect window close button or ESC key

        if (c.w.windowHasBeenQuit()) break;

        c.rl.drawFPS(20, 20);

        c.g.updateCellSelector();

        c.g.isIntegerPressed();

        c.rl.beginDrawing();

        defer c.rl.endDrawing();

        c.rl.clearBackground(c.rl.Color.white);

        c.rl.drawText("Grid Here", 200, 400, 20, c.rl.Color.light_gray);
    }
}
