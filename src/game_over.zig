const CellExeption = struct {
    i_backend: usize,
    j_backend: usize,
};

pub var cellExeption: CellExeption = CellExeption{ .i_backend = 0, .j_backend = 0 };

const c = @import("constant.zig");

pub fn isGameOver() void {
    for (0..9) |i| {
        for (0..9) |j| {
            const current_integer: u8 = c.g.BackendgridLocation.?.*[i][j];

            if (current_integer != 0 and current_integer != c.gs.solution_grid.?.*[i][j]) {
                c.p.loseLife();
                c.g.BackendgridLocation.?.*[i][j] = 0;
                cellExeption = CellExeption{ .i_backend = @as(usize, i), .j_backend = @as(usize, j) };
            }
        }
        c.print("\n", .{});
    }
}

fn paintInRedWrongCell(i: usize, j: usize) void {
    const x: f32 = @as(f32, @floatFromInt(c.g.FrontendgridLocation.?.*[i][j].x));
    const y: f32 = @as(f32, @floatFromInt(c.g.FrontendgridLocation.?.*[i][j].y));
    const width: f32 = @as(f32, @floatFromInt(c.g.FrontendgridLocation.?.*[i][j].width));
    const height: f32 = @as(f32, @floatFromInt(c.g.FrontendgridLocation.?.*[i][j].height));

    const WrongCellArea: c.rl.Rectangle = c.rl.Rectangle.init(x, y, width, height);

    c.rl.drawRectangleGradientEx(WrongCellArea, c.rl.Color.red.alpha(100), c.rl.Color.red.alpha(100), c.rl.Color.red.alpha(100), c.rl.Color.red.alpha(100));
}
