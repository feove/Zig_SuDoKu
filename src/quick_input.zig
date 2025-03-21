const c = @import("constant.zig");

pub fn panel_display() void {
    const x: i32 = @intFromFloat(c.s.blanck_panel.x + 10);
    const y: i32 = @intFromFloat(c.s.blanck_panel.y + 20);

    c.rl.drawRectangle(x, y, 560, 300, c.rl.Color.white);
    c.s.blanck_panel.draw();

    c.s.clear_button.color = if (c.s.clear_button.isHover()) c.rl.Color.gray else c.rl.Color.white;
    c.s.confirm_button.color = if (c.s.confirm_button.isHover()) c.rl.Color.gray else c.rl.Color.white;

    c.s.one_button.draw();
    c.s.two_button.draw();
    c.s.three_button.draw();
    c.s.four_button.draw();
    c.s.five_button.draw();
    c.s.six_button.draw();
    c.s.seven_button.draw();
    c.s.eight_button.draw();
    c.s.nine_button.draw();
    c.s.confirm_button.draw();
    c.s.clear_button.draw();

    if (c.s.confirm_button.isClicked()) {
        c.w.layer = c.w.Layer.PlayView;
    }
}
