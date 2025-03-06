const c = @import("constant.zig");

pub fn windowHasBeenQuit() bool {
    return c.rl.isKeyPressed(c.rl.KeyboardKey.a) or c.rl.isKeyPressed(c.rl.KeyboardKey.q);
}
