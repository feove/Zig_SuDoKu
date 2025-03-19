const c = @import("constant.zig");

const DraftCell = struct {
    empty: bool = true,

    integers: *[9]bool = undefined,
};

pub var draftCells: ?*[9][9]DraftCell = null;

pub fn draftCellsInit() !void {
    draftCells = try c.g.allocator.create([9][9]DraftCell);

    for (0..9) |i| {
        for (0..9) |j| {
            const integers_init: *[9]bool = try c.g.allocator.create([9]bool);

            for (0..9) |e| {
                integers_init.*[e] = false;
            }
            draftCells.?.*[i][j] = DraftCell{ .integers = integers_init };
        }
    }
}

pub fn pencilPanelView() void {
    const x: i32 = @intFromFloat(c.s.blanck_panel.x + 10);
    const y: i32 = @intFromFloat(c.s.blanck_panel.y + 20);

    c.rl.drawRectangle(x, y, 560, 300, c.rl.Color.white);
    c.s.blanck_panel.draw();

    draft_buttons_display();

    draft_meca();
}

pub fn clearCell(i: usize, j: usize) void {
    c.rl.drawRectangle(c.g.FrontendgridLocation.?.*[i][j].x - 10, c.g.FrontendgridLocation.?.*[i][j].y - 10, c.g.FrontendgridLocation.?.*[i][j].width, c.g.FrontendgridLocation.?.*[i][j].height - 5, c.rl.Color.white);
}

pub fn isEmpty(x: usize, y: usize) bool {
    for (0..9) |i| {
        if (draftCells.?.*[y][x].integers.*[i]) return false;
    }
    return true;
}

pub fn drawDraftNumbers(i: usize, j: usize) void {
    const x_corner: f32 = @as(f32, @floatFromInt(c.g.FrontendgridLocation.?.*[i][j].x + 5));
    const y_corner: f32 = @as(f32, @floatFromInt(c.g.FrontendgridLocation.?.*[i][j].y + 5));

    if (draftCells.?.*[j][i].integers.*[0]) {
        c.t.newText(c.t.ProtoNerdFont_Bold_30, "1", x_corner, y_corner, 15, 0, c.rl.Color.black);
    }
}

fn draft_meca() void {
    const x: u8 = c.g.currentCellBackEnd.x;
    const y: u8 = c.g.currentCellBackEnd.y;

    if (c.s.confirm_button.isClicked() or c.rl.isKeyPressed(c.rl.KeyboardKey.enter)) {
        c.w.layer = c.w.Layer.PlayView;

        //clearCell(x, y);
        drawDraftNumbers(x, y);
        draftCells.?.*[x][y].empty = isEmpty(x, y);
    }

    c.s.one_button.color = if (draftCells.?.*[y][x].integers.*[0]) c.rl.Color.gray else c.rl.Color.white;
    c.s.two_button.color = if (draftCells.?.*[y][x].integers.*[1]) c.rl.Color.gray else c.rl.Color.white;
    c.s.three_button.color = if (draftCells.?.*[y][x].integers.*[2]) c.rl.Color.gray else c.rl.Color.white;
    c.s.four_button.color = if (draftCells.?.*[y][x].integers.*[3]) c.rl.Color.gray else c.rl.Color.white;
    c.s.five_button.color = if (draftCells.?.*[y][x].integers.*[4]) c.rl.Color.gray else c.rl.Color.white;
    c.s.six_button.color = if (draftCells.?.*[y][x].integers.*[5]) c.rl.Color.gray else c.rl.Color.white;
    c.s.seven_button.color = if (draftCells.?.*[y][x].integers.*[6]) c.rl.Color.gray else c.rl.Color.white;
    c.s.eight_button.color = if (draftCells.?.*[y][x].integers.*[7]) c.rl.Color.gray else c.rl.Color.white;
    c.s.nine_button.color = if (draftCells.?.*[y][x].integers.*[8]) c.rl.Color.gray else c.rl.Color.white;

    if (c.s.one_button.isClicked()) integerClicked(0);
    if (c.s.two_button.isClicked()) integerClicked(1);
    if (c.s.three_button.isClicked()) integerClicked(2);
    if (c.s.four_button.isClicked()) integerClicked(3);
    if (c.s.five_button.isClicked()) integerClicked(4);
    if (c.s.six_button.isClicked()) integerClicked(5);
    if (c.s.seven_button.isClicked()) integerClicked(6);
    if (c.s.eight_button.isClicked()) integerClicked(7);
    if (c.s.nine_button.isClicked()) integerClicked(8);
}

fn integerClicked(i: usize) void {
    const x: u8 = c.g.currentCellBackEnd.x;
    const y: u8 = c.g.currentCellBackEnd.y;

    const isGray: bool = draftCells.?.*[y][x].integers.*[i];

    draftCells.?.*[y][x].integers.*[i] = !isGray;
}

fn draft_buttons_display() void {
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
}
