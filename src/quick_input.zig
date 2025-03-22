const c = @import("constant.zig");

pub fn panel_display() void {
    const x: i32 = @intFromFloat(c.s.blanck_panel.x + 10);
    const y: i32 = @intFromFloat(c.s.blanck_panel.y + 20);

    c.rl.drawRectangle(x, y, 560, 300, c.rl.Color.white);
    c.s.blanck_panel.draw();

    c.s.cancel_button.color = if (c.s.cancel_button.isHover()) c.rl.Color.gray else c.rl.Color.white;

    c.s.one_button.color = if (c.s.one_button.isHover()) c.rl.Color.gray else c.rl.Color.white;
    c.s.two_button.color = if (c.s.two_button.isHover()) c.rl.Color.gray else c.rl.Color.white;
    c.s.three_button.color = if (c.s.three_button.isHover()) c.rl.Color.gray else c.rl.Color.white;
    c.s.four_button.color = if (c.s.four_button.isHover()) c.rl.Color.gray else c.rl.Color.white;
    c.s.five_button.color = if (c.s.five_button.isHover()) c.rl.Color.gray else c.rl.Color.white;
    c.s.six_button.color = if (c.s.six_button.isHover()) c.rl.Color.gray else c.rl.Color.white;
    c.s.seven_button.color = if (c.s.seven_button.isHover()) c.rl.Color.gray else c.rl.Color.white;
    c.s.eight_button.color = if (c.s.eight_button.isHover()) c.rl.Color.gray else c.rl.Color.white;
    c.s.nine_button.color = if (c.s.nine_button.isHover()) c.rl.Color.gray else c.rl.Color.white;

    c.s.one_button.draw();
    c.s.two_button.draw();
    c.s.three_button.draw();
    c.s.four_button.draw();
    c.s.five_button.draw();
    c.s.six_button.draw();
    c.s.seven_button.draw();
    c.s.eight_button.draw();
    c.s.nine_button.draw();
    c.s.cancel_button.draw();

    if (c.s.one_button.isClicked()) integerClicked(1, "1");
    if (c.s.two_button.isClicked()) integerClicked(2, "2");
    if (c.s.three_button.isClicked()) integerClicked(3, "3");
    if (c.s.four_button.isClicked()) integerClicked(4, "4");
    if (c.s.five_button.isClicked()) integerClicked(5, "5");
    if (c.s.six_button.isClicked()) integerClicked(6, "6");
    if (c.s.seven_button.isClicked()) integerClicked(7, "7");
    if (c.s.eight_button.isClicked()) integerClicked(8, "8");
    if (c.s.nine_button.isClicked()) integerClicked(9, "9");

    if (c.s.cancel_button.isClicked()) {
        c.w.layer = c.w.Layer.PlayView;
    }
}

fn integerClicked(integer: u8, value: [:0]const u8) void {
    if (c.g.BackendgridLocation.?.*[c.g.currentCellBackEnd.y][c.g.currentCellBackEnd.x] == 0) {
        c.g.BackendgridLocation.?.*[c.g.currentCellBackEnd.y][c.g.currentCellBackEnd.x] = integer;
        c.g.FrontendgridLocation.?.*[c.g.currentCellBackEnd.x][c.g.currentCellBackEnd.y].value = value;
        c.w.layer = c.w.Layer.PlayView;
    }
}
