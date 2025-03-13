pub const CellExeption = struct { i_backend: usize, j_backend: usize, defined: bool };

pub var cellExceptions: ?*[2]CellExeption = undefined;
pub var resetColor: bool = false;

const c = @import("constant.zig");

pub fn isGameOver() void {
    const current_integer: u8 = c.g.BackendgridLocation.?.*[c.g.currentCellBackEnd.y][c.g.currentCellBackEnd.x];

    if (current_integer != 0) {
        if (current_integer != c.gs.solution_grid.?.*[c.g.currentCellBackEnd.y][c.g.currentCellBackEnd.x]) {
            c.p.loseLife();

            if (!cellExceptions.?.*[0].defined) {
                cellExceptions.?.*[0] = CellExeption{ .i_backend = c.g.currentCellBackEnd.x, .j_backend = c.g.currentCellBackEnd.y, .defined = true };
            } else {
                cellExceptions.?.*[1] = CellExeption{ .i_backend = c.g.currentCellBackEnd.x, .j_backend = c.g.currentCellBackEnd.y, .defined = true };
            }

            c.g.BackendgridLocation.?.*[c.g.currentCellBackEnd.y][c.g.currentCellBackEnd.x] = 0;
        } else {
            c.gs.copy_for_backend_and_frontend.?.*[c.g.currentCellBackEnd.y][c.g.currentCellBackEnd.x] = current_integer;

            const was_first_error: bool = cellExceptions.?.*[0].i_backend == c.g.currentCellBackEnd.x and cellExceptions.?.*[0].j_backend == c.g.currentCellBackEnd.y;

            if (was_first_error) {
                cellExceptions.?.*[0].defined = false;
            }
        }
    }
}

pub fn paintInRedWrongCell(j: usize, i: usize) void {
    const x: f32 = @as(f32, @floatFromInt(c.g.FrontendgridLocation.?.*[i][j].x - 10));
    const y: f32 = @as(f32, @floatFromInt(c.g.FrontendgridLocation.?.*[i][j].y - 10));
    const width: f32 = @as(f32, @floatFromInt(c.g.FrontendgridLocation.?.*[i][j].width));
    const height: f32 = @as(f32, @floatFromInt(c.g.FrontendgridLocation.?.*[i][j].height - 5));

    const softRed: c.rl.Color = c.rl.Color{ .r = 220, .g = 80, .b = 80, .a = 150 };
    const gradientDarkRed: c.rl.Color = c.rl.Color{ .r = 180, .g = 50, .b = 50, .a = 180 };

    const WrongCellArea: c.rl.Rectangle = c.rl.Rectangle.init(x, y, width, height);

    c.rl.drawRectangleGradientEx(WrongCellArea, softRed, gradientDarkRed, softRed, gradientDarkRed);

    c.rl.drawRectangleRoundedLinesEx(WrongCellArea, 0.3, 10, 2.0, c.rl.Color{ .r = 150, .g = 50, .b = 50, .a = 200 });

    c.rl.drawText(c.g.FrontendgridLocation.?.*[i][j].value, @as(i32, c.g.FrontendgridLocation.?.*[i][j].x) + 5, @as(i32, c.g.FrontendgridLocation.?.*[i][j].y), 35, c.rl.Color.black);
}

//The End
