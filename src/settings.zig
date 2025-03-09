const c = @import("constant.zig");

pub fn isPlayViewPressed() void {
    if (c.rl.isKeyPressed(c.rl.KeyboardKey.v)) {
        c.w.layer = c.w.Layer.PlayView;
    }
}

pub fn isGameMenuPressed() void {
    if (c.rl.isKeyPressed(c.rl.KeyboardKey.c)) {
        c.w.layer = c.w.Layer.GameMenuView;
    }
}
