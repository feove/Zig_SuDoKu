const c = @import("constant.zig");

pub fn pencilPanelView() void {
    c.s.blanck_panel.draw();

    if (c.rl.isKeyPressed(c.rl.KeyboardKey.g)) {
        c.w.layer = c.w.Layer.PlayView;
    }
}
