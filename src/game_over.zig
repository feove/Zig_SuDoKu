pub const CellExeption = struct {
    i_backend: u8,
    j_backend: u8,
    defined: bool,
    number_value: u8,
};

pub var cellExceptions: ?*[3]CellExeption = null;
pub var CanDrawRed: bool = false;

const c = @import("constant.zig");

pub fn isGameOver() void {
    const current_integer: u8 = c.g.BackendgridLocation.?.*[c.g.currentCellBackEnd.y][c.g.currentCellBackEnd.x];
    const x = c.g.currentCellBackEnd.x;
    const y = c.g.currentCellBackEnd.y;

    if (current_integer != 0) {
        if (checkWithSolution(current_integer)) {
            c.p.loseLife();

            addNewException(current_integer, x, y);

            c.g.BackendgridLocation.?.*[y][x] = 0;
            c.g.FrontendgridLocation.?.*[x][y].value = " ";

            c.sn.soundControl.play(c.sn.wrong_sound);

            return;
        }

        registerTrueInteger(current_integer);

        if (currentEqualsToException(x, y)) |cell_index| {
            cellExceptions.?.*[cell_index].defined = false;
        }
    }
}

fn registerTrueInteger(current_integer: u8) void {
    c.gs.copy_for_backend_and_frontend.?.*[c.g.currentCellBackEnd.y][c.g.currentCellBackEnd.x] = current_integer;
}

pub fn currentEqualsToException(x: u8, y: u8) ?usize {
    for (0..3) |e| {
        if (x == cellExceptions.?.*[e].i_backend and y == cellExceptions.?.*[e].j_backend) {
            return e;
        }
    }
    return null;
}

fn addNewException(current_integer: u8, i: u8, j: u8) void {
    for (0..3) |e| {
        if (cellExceptions.?.*[e].defined == false) {
            cellExceptions.?.*[e] = CellExeption{ .i_backend = i, .j_backend = j, .number_value = current_integer, .defined = true };
            return;
        }
    }
}
fn checkWithSolution(current_integer: u8) bool {
    return current_integer != c.gs.solution_grid.?.*[c.g.currentCellBackEnd.y][c.g.currentCellBackEnd.x];
}

pub fn paintInRedWrongCells() void {
    for (0..3) |e| {
        if (cellExceptions.?.*[e].defined) {
            const i = cellExceptions.?.*[e].i_backend;
            const j = cellExceptions.?.*[e].j_backend;

            const x: f32 = @as(f32, @floatFromInt(c.g.FrontendgridLocation.?.*[i][j].x - 10));
            const y: f32 = @as(f32, @floatFromInt(c.g.FrontendgridLocation.?.*[i][j].y - 10));
            const width: f32 = @as(f32, @floatFromInt(c.g.FrontendgridLocation.?.*[i][j].width));
            const height: f32 = @as(f32, @floatFromInt(c.g.FrontendgridLocation.?.*[i][j].height - 5));

            c.rl.drawRectangle(c.g.FrontendgridLocation.?.*[i][j].x - 10, c.g.FrontendgridLocation.?.*[i][j].y - 10, c.g.FrontendgridLocation.?.*[i][j].width, c.g.FrontendgridLocation.?.*[i][j].height - 5, c.rl.Color.white);

            const softRed: c.rl.Color = c.rl.Color{ .r = 220, .g = 80, .b = 80, .a = 150 };
            const gradientDarkRed: c.rl.Color = c.rl.Color{ .r = 180, .g = 50, .b = 50, .a = 180 };

            const WrongCellArea: c.rl.Rectangle = c.rl.Rectangle.init(x, y, width, height);

            c.rl.drawRectangleGradientEx(WrongCellArea, softRed, gradientDarkRed, softRed, gradientDarkRed);

            c.rl.drawRectangleRoundedLinesEx(WrongCellArea, 0.3, 10, 2.0, c.rl.Color{ .r = 150, .g = 50, .b = 50, .a = 200 });

            c.rl.drawText(c.g.intAddToSlice(cellExceptions.?.*[e].number_value), @as(i32, c.g.FrontendgridLocation.?.*[i][j].x) + 5, @as(i32, c.g.FrontendgridLocation.?.*[i][j].y), 35, c.rl.Color.black);
        }
    }
}

//The End
