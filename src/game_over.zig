const CellExeption = struct {
    i_backend: usize,
    j_backend: usize,
};

pub var cellExeption: CellExeption = CellExeption{ .i_backend = 0, .j_backend = 0 };

const c = @import("constant.zig");

pub fn isGameOver() void {
    const current_integer: u8 = c.g.BackendgridLocation.?.*[c.g.currentCellBackEnd.y][c.g.currentCellBackEnd.x];

    if (current_integer != 0 and current_integer != c.gs.solution_grid.?.*[c.g.currentCellBackEnd.y][c.g.currentCellBackEnd.x]) {
        c.g.BackendgridLocation.?.*[c.g.currentCellBackEnd.y][c.g.currentCellBackEnd.x] = 0;
        c.p.loseLife();

        //cellExeption = CellExeption{ .i_backend = @as(usize, c.g.currentCellBackEnd.y), .j_backend = @as(usize, c.g.currentCellBackEnd.x) };
        //paintInRedWrongCell(c.g.currentCellBackEnd.y, c.g.currentCellBackEnd.x);
    }

    c.print("\n", .{});
}

fn paintInRedWrongCell(j: usize, i: usize) void {
    const x: f32 = @as(f32, @floatFromInt(c.g.FrontendgridLocation.?.*[i][j].x));
    const y: f32 = @as(f32, @floatFromInt(c.g.FrontendgridLocation.?.*[i][j].y));
    const width: f32 = @as(f32, @floatFromInt(c.g.FrontendgridLocation.?.*[i][j].width));
    const height: f32 = @as(f32, @floatFromInt(c.g.FrontendgridLocation.?.*[i][j].height));

    const WrongCellArea: c.rl.Rectangle = c.rl.Rectangle.init(x, y, width, height);

    c.rl.drawRectangleGradientEx(WrongCellArea, c.rl.Color.red.alpha(100), c.rl.Color.red.alpha(100), c.rl.Color.red.alpha(100), c.rl.Color.red.alpha(100));
}

//The End
