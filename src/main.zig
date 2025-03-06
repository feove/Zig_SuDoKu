const rl = @import("raylib");

const c = @import("constant.zig");

pub fn main() anyerror!void {
    const screenWidth = 800;
    const screenHeight = 800;

    rl.initWindow(screenWidth, screenHeight, "raylib-zig [core] example - basic window");
    defer rl.closeWindow(); // Close window and OpenGL context

    rl.setTargetFPS(60);

    while (!rl.windowShouldClose()) { // Detect window close button or ESC key

        if (c.w.windowHasBeenQuit()) break;

        rl.drawFPS(20, 20);

        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(rl.Color.white);

        rl.drawText("Grid Here", 200, 400, 20, rl.Color.light_gray);
        //----------------------------------------------------------------------------------
    }
}
