const c = @import("constant.zig");

pub const spacement = 70;

const init_grid_position: c.rl.Vector2 = c.rl.Vector2.init(70, 90);
const init_selector_position: c.rl.Vector2 = c.rl.Vector2.init(85, 140); //Left Top Corner

var selector_shape: c.rl.Rectangle = c.rl.Rectangle.init(init_selector_position.x, init_selector_position.y, 40, 5);
var hiligther_shape: c.rl.Rectangle = c.rl.Rectangle.init(init_selector_position.x, init_grid_position.y - 50, 40, 40);

var colored_number: u8 = 0;

const Cell = struct {
    x: u16,
    y: u16,
    width: u16,
    height: u16,
    value: [:0]const u8,
};

const FrontEndCursorLimits = struct {
    x_left: u16 = init_grid_position.x,
    x_right: u16 = init_grid_position.x + n * spacement,

    y_top: u16 = init_grid_position.y,
    y_bottom: u16 = init_selector_position.y + (n - 1) * spacement,
};

const cursorlimits = FrontEndCursorLimits{};

const CurrentCellFrontEnd = struct {
    x: u16 = init_selector_position.x,
    y: u16 = init_selector_position.y,

    x_prev: u16 = init_selector_position.x,
    y_prev: u16 = init_selector_position.y,

    on_top: bool = true,
    on_left: bool = true,
    on_right: bool = false,
    on_bottom: bool = false,
};

const CurrentCellBackend = struct {
    x: u8 = 0,
    y: u8 = 0,
    on_top: bool = true,
    on_left: bool = true,
    on_right: bool = false,
    on_bottom: bool = false,
};

pub var currentCellBackEnd = CurrentCellBackend{};
var currentCellFrontEnd = CurrentCellFrontEnd{};

var gpa = c.std.heap.GeneralPurposeAllocator(.{}){};
pub const allocator = gpa.allocator();

const n: usize = 9;
pub var BackendgridLocation: ?*[n][n]u8 = null;

pub fn exceptionInit() !void {
    c.go.cellExceptions = try allocator.create([3]c.go.CellExeption);
    c.go.cellExceptions.?.*[0].defined = false;
    c.go.cellExceptions.?.*[1].defined = false;
    c.go.cellExceptions.?.*[2].defined = false;
}

fn buttonsInit() !void {
    c.s.integers_button = try allocator.create([9]c.s.Button);
    c.s.integers_button.?.*[0] = c.s.one_button;
    c.s.integers_button.?.*[1] = c.s.two_button;
    c.s.integers_button.?.*[2] = c.s.three_button;
    c.s.integers_button.?.*[3] = c.s.four_button;
    c.s.integers_button.?.*[4] = c.s.five_button;
    c.s.integers_button.?.*[5] = c.s.six_button;
    c.s.integers_button.?.*[6] = c.s.seven_button;
    c.s.integers_button.?.*[7] = c.s.eight_button;
    c.s.integers_button.?.*[8] = c.s.nine_button;
}

pub fn BackendgridInit(difficulty: u8) !void {
    try exceptionInit();

    try buttonsInit();

    const backend_grid = try allocator.create([n][n]u8);

    try c.gs.readSudokuGrids(difficulty);

    for (0..n) |i| {
        for (0..n) |j| {
            backend_grid[i][j] = c.gs.copy_for_backend_and_frontend.?.*[i][j];
        }
    }
    BackendgridLocation = backend_grid;
}

pub fn drawBackendGrid() void {
    c.clear();

    for (0..n) |i| {
        for (0..n) |j| {
            if (BackendgridLocation.?.*[i][j] >= 0 and BackendgridLocation.?.*[i][j] <= 9) {
                c.print("[{d}]", .{BackendgridLocation.?.*[i][j]});
            } else {
                c.print("[X]", .{});
            }
        }
        c.print("\n", .{});
    }
    c.print("\n" ** 3, .{});
    c.print(" Backend :\n X : {d}\n Y : {d}\n", .{ currentCellBackEnd.x, currentCellBackEnd.y });
    c.print("\n Frontend :\n X : {d}\n Y : {d}\n", .{ currentCellFrontEnd.x, currentCellFrontEnd.y });
    c.print("\n" ** 3, .{});
    c.print(" Current Number : {d}\n", .{colored_number});
}

pub fn drawFrontEndGrid() void {
    c.rl.clearBackground(c.rl.Color.white);

    var x: i32 = init_grid_position.x;
    var y: i32 = init_grid_position.y;

    const x_end = init_grid_position.x + spacement * n;
    const y_end = init_grid_position.y + spacement * n;

    for (1..n + 2) |col| {
        if (col == 1 or col == n + 1 or @mod(col - 1, 3) == 0) {
            if (col == n + 1) {
                c.rl.drawRectangle(x, y, 3, 9 * spacement + 3, c.rl.Color.black);
            } else {
                c.rl.drawRectangle(x, y, 3, 9 * spacement, c.rl.Color.black);
            }
        } else {
            c.rl.drawLine(x, y, x, y_end, c.rl.Color.black);
        }
        x += spacement;
    }
    x = init_grid_position.x;
    for (1..n + 2) |line| {
        if (line == 1 or line == n + 1 or @mod(line - 1, 3) == 0) {
            c.rl.drawRectangle(x, y, 9 * spacement, 3, c.rl.Color.black);
        } else {
            c.rl.drawLine(x, y, x_end, y, c.rl.Color.black);
        }
        y += spacement;
    }
    //Draw Numbers
    for (0..n) |i| {
        for (0..n) |j| {
            if (BackendgridLocation.?.*[i][j] == 0) {
                c.go.paintInRedWrongCells();
            }

            if (FrontendgridLocation.?.*[i][j].value[0] != ' ' and BackendgridLocation.?.*[j][i] == colored_number) {
                hiligther_number(i, j);
            }

            if (FrontendgridLocation.?.*[i][j].value[0] == ' ' and !c.d.draftCells.?.*[i][j].empty) {
                c.d.drawDraftNumbers(i, j);
            }
            c.rl.drawText(FrontendgridLocation.?.*[i][j].value, @as(i32, FrontendgridLocation.?.*[i][j].x) + 5, @as(i32, FrontendgridLocation.?.*[i][j].y), 35, c.rl.Color.black);
        }
    }
}
fn hiligther_number(i: usize, j: usize) void {
    c.rl.drawRectangle(c.g.FrontendgridLocation.?.*[i][j].x - 10, c.g.FrontendgridLocation.?.*[i][j].y - 10, c.g.FrontendgridLocation.?.*[i][j].width, c.g.FrontendgridLocation.?.*[i][j].height - 5, c.rl.Color.white);

    const x: f32 = @as(f32, @floatFromInt(c.g.FrontendgridLocation.?.*[i][j].x - 10));
    const y: f32 = @as(f32, @floatFromInt(c.g.FrontendgridLocation.?.*[i][j].y - 10));
    const width: f32 = @as(f32, @floatFromInt(c.g.FrontendgridLocation.?.*[i][j].width));
    const height: f32 = @as(f32, @floatFromInt(c.g.FrontendgridLocation.?.*[i][j].height - 5));

    const softBlue: c.rl.Color = c.rl.Color{ .r = 80, .g = 80, .b = 220, .a = 150 };
    const gradientDarkBlue: c.rl.Color = c.rl.Color{ .r = 50, .g = 50, .b = 180, .a = 180 };

    const HighlightCellArea: c.rl.Rectangle = c.rl.Rectangle.init(x, y, width, height);

    c.rl.drawRectangleGradientEx(HighlightCellArea, softBlue, gradientDarkBlue, softBlue, gradientDarkBlue);

    c.rl.drawRectangleRoundedLinesEx(HighlightCellArea, 0.3, 10, 2.0, c.rl.Color{ .r = 50, .g = 50, .b = 150, .a = 200 });
}

//cuz clc
pub fn intAddToSlice(char: u8) [:0]const u8 {
    return switch (char) {
        1 => return "1",
        2 => return "2",
        3 => return "3",
        4 => return "4",
        5 => return "5",
        6 => return "6",
        7 => return "7",
        8 => return "8",
        9 => return "9",
        else => return " ",
    };
}

pub var FrontendgridLocation: ?*[n][n]Cell = null;

pub fn FrontendgridInit() !void {
    var frontend_grid = try allocator.create([n][n]Cell);
    for (0..n) |i| {
        for (0..n) |j| {
            var val: u8 = 0;
            if (c.gs.copy_for_backend_and_frontend) |backend| {
                val = backend[j][i];
            } else {
                val = 0;
            }
            frontend_grid[i][j] = Cell{
                .x = @intFromFloat(init_grid_position.x + @as(f32, @floatFromInt(i)) * spacement + 20),
                .y = @intFromFloat(init_grid_position.y + @as(f32, @floatFromInt(j)) * spacement + 20),
                .width = spacement - 20,
                .height = spacement - 20,
                .value = intAddToSlice(val),
            };
        }
    }
    FrontendgridLocation = frontend_grid;

    try exceptionInit();

    try c.d.draftCellsInit();
}

pub fn gridReset() !void {
    for (0..n) |i| {
        for (0..n) |j| {
            BackendgridLocation.?.*[i][j] = c.gs.copy_for_backend_and_frontend.?.*[i][j];
        }
    }

    try FrontendgridInit();
}

pub fn updateCellSelector() void {
    if (c.rl.isKeyPressed(c.rl.KeyboardKey.down) and !currentCellBackEnd.on_bottom) {
        cellSwitchingBackend(currentCellBackEnd.x, currentCellBackEnd.y, 0, 1);
        cellSwitchingFrontend(0, spacement);
    }

    if (c.rl.isKeyPressed(c.rl.KeyboardKey.left) and !currentCellBackEnd.on_left) {
        cellSwitchingBackend(currentCellBackEnd.x, currentCellBackEnd.y, -1, 0);
        cellSwitchingFrontend(-spacement, 0);
    }

    if (c.rl.isKeyPressed(c.rl.KeyboardKey.up) and !currentCellBackEnd.on_top) {
        cellSwitchingBackend(currentCellBackEnd.x, currentCellBackEnd.y, 0, -1);
        cellSwitchingFrontend(0, -spacement);
    }

    if (c.rl.isKeyPressed(c.rl.KeyboardKey.right) and !currentCellBackEnd.on_right) {
        cellSwitchingBackend(currentCellBackEnd.x, currentCellBackEnd.y, 1, 0);
        cellSwitchingFrontend(spacement, 0);
    }

    drawBackendGrid(); //Draw selectorBackend too inside

    drawSelectorGrid();

    isClickedOnCell();

    colored_number = BackendgridLocation.?.*[currentCellBackEnd.y][currentCellBackEnd.x];
}

fn drawSelectorGrid() void {
    const i32_width: i32 = @as(i32, @intFromFloat(selector_shape.width));
    const i32_height: i32 = @as(i32, @intFromFloat(selector_shape.height));

    //Clear last selection
    c.rl.drawRectangle(currentCellFrontEnd.x_prev, currentCellFrontEnd.y_prev + 10, i32_width, i32_height, c.rl.Color.white);
    //c.rl.drawRectangleGradientEx(hiligther_shape, c.rl.Color.white, c.rl.Color.white, c.rl.Color.white, c.rl.Color.white);

    selector_shape.x = @as(f32, @floatFromInt(currentCellFrontEnd.x));
    selector_shape.y = @as(f32, @floatFromInt(currentCellFrontEnd.y)) + 10;

    hiligther_shape.x = selector_shape.x;
    hiligther_shape.y = selector_shape.y - 50;

    c.rl.drawRectangleGradientEx(selector_shape, c.rl.Color.gray, c.rl.Color.black, c.rl.Color.black, c.rl.Color.gray);
}

fn cellSwitchingFrontend(i: i32, j: i32) void {
    currentCellFrontEnd.x_prev = currentCellFrontEnd.x;
    currentCellFrontEnd.y_prev = currentCellFrontEnd.y;

    currentCellFrontEnd.x = @intCast(@as(i32, currentCellFrontEnd.x) + i);
    currentCellFrontEnd.y = @intCast(@as(i32, currentCellFrontEnd.y) + j);

    currentCellFrontEnd.on_right = currentCellFrontEnd.x == cursorlimits.x_right;
    currentCellFrontEnd.on_left = currentCellFrontEnd.x == cursorlimits.x_left;
    currentCellFrontEnd.on_top = currentCellFrontEnd.y == cursorlimits.y_top;
    currentCellFrontEnd.on_bottom = currentCellFrontEnd.y == cursorlimits.y_bottom;
}

fn cellSwitchingBackend(x: u8, y: u8, i: i8, j: i8) void {
    if (BackendgridLocation) |grid| {
        if (grid[y][x] == 'X') {
            grid[y][x] = 0;
        }

        const new_x: u8 = @intCast(@as(i16, x) + i);
        const new_y: u8 = @intCast(@as(i16, y) + j);

        currentCellBackEnd.x = new_x;
        currentCellBackEnd.y = new_y;

        currentCellBackEnd.on_bottom = new_y == n - 1;
        currentCellBackEnd.on_top = new_y == 0;
        currentCellBackEnd.on_left = new_x == 0;
        currentCellBackEnd.on_right = new_x == n - 1;
    }

    c.sn.soundControl.play(c.sn.cell_sound);
}

pub fn isIntegerPressed() void {
    if (c.rl.isKeyPressed(c.rl.KeyboardKey.backspace)) {
        integerSettingBackend(0);
        integerSettingFrontend(" ");

        if (c.go.currentEqualsToException(currentCellBackEnd.x, currentCellBackEnd.y)) |cell_index| {
            c.go.cellExceptions.?.*[cell_index].defined = false;
        }
    }
    if (c.rl.isKeyPressed(c.rl.KeyboardKey.one)) {
        integerSettingBackend(1);
        integerSettingFrontend("1");
    }
    if (c.rl.isKeyPressed(c.rl.KeyboardKey.two)) {
        integerSettingBackend(2);
        integerSettingFrontend("2");
    }
    if (c.rl.isKeyPressed(c.rl.KeyboardKey.three)) {
        integerSettingBackend(3);
        integerSettingFrontend("3");
    }
    if (c.rl.isKeyPressed(c.rl.KeyboardKey.four)) {
        integerSettingBackend(4);
        integerSettingFrontend("4");
    }
    if (c.rl.isKeyPressed(c.rl.KeyboardKey.five)) {
        integerSettingBackend(5);
        integerSettingFrontend("5");
    }
    if (c.rl.isKeyPressed(c.rl.KeyboardKey.six)) {
        integerSettingBackend(6);
        integerSettingFrontend("6");
    }
    if (c.rl.isKeyPressed(c.rl.KeyboardKey.seven)) {
        integerSettingBackend(7);
        integerSettingFrontend("7");
    }
    if (c.rl.isKeyPressed(c.rl.KeyboardKey.eight)) {
        integerSettingBackend(8);
        integerSettingFrontend("8");
    }
    if (c.rl.isKeyPressed(c.rl.KeyboardKey.nine)) {
        integerSettingBackend(9);
        integerSettingFrontend("9");
    }
}

fn integerSettingBackend(integer: u8) void {
    if (BackendgridLocation.?.*[currentCellBackEnd.y][currentCellBackEnd.x] == 0) {
        BackendgridLocation.?.*[currentCellBackEnd.y][currentCellBackEnd.x] = integer;
    }
}

fn integerSettingFrontend(integer: [:0]const u8) void {
    c.d.draftCells.?.*[currentCellBackEnd.x][currentCellBackEnd.y].empty = true;
    if (c.gs.copy_for_backend_and_frontend.?.*[currentCellBackEnd.y][currentCellBackEnd.x] == 0)
        FrontendgridLocation.?.*[currentCellBackEnd.x][currentCellBackEnd.y].value = integer;
}

fn cursorOnCell(mousePos: c.rl.Vector2) bool {
    const in_width: bool = mousePos.x > cursorlimits.x_left and mousePos.x < cursorlimits.x_right;
    const in_height: bool = mousePos.y > cursorlimits.y_top and mousePos.y < cursorlimits.y_bottom;

    return in_width and in_height;
}

fn moveCursor(mousePos: c.rl.Vector2) void {
    const mouseX: i32 = @as(i32, @intFromFloat(mousePos.x));
    const mouseY: i32 = @as(i32, @intFromFloat(mousePos.y));

    cursorToLeft(mouseX);
    cursorToRight(mouseX);

    cursorToTop(mouseY);
    cursorToBottom(mouseY);
}

fn isClickedOnCell() void {
    const mousePos = c.rl.getMousePosition();

    if (cursorOnCell(mousePos)) {
        if (c.rl.isMouseButtonPressed(c.rl.MouseButton.right)) {
            moveCursor(mousePos);
            c.w.layer = c.w.Layer.QuickInputView;
        }
        if (c.rl.isMouseButtonPressed(c.rl.MouseButton.left)) {
            moveCursor(mousePos);
        }
    }
}

fn cursorToTop(mouseY: i32) void {
    if (currentCellFrontEnd.y > mouseY) {
        while (mouseY + spacement < currentCellFrontEnd.y) {
            cellSwitchingFrontend(0, -spacement);
            cellSwitchingBackend(currentCellBackEnd.x, currentCellBackEnd.y, 0, -1);
        }
    }
}

fn cursorToBottom(mouseY: i32) void {
    if (currentCellFrontEnd.y < mouseY) {
        while (mouseY - spacement / 2 > currentCellFrontEnd.y) {
            cellSwitchingFrontend(0, spacement);
            cellSwitchingBackend(currentCellBackEnd.x, currentCellBackEnd.y, 0, 1);
        }
    }
}

fn cursorToRight(mouseX: i32) void {
    if (currentCellFrontEnd.x < mouseX) {
        while (mouseX - spacement > currentCellFrontEnd.x) {
            cellSwitchingFrontend(spacement, 0);
            cellSwitchingBackend(currentCellBackEnd.x, currentCellBackEnd.y, 1, 0);
        }
    }
}
fn cursorToLeft(mouseX: i32) void {
    if (currentCellFrontEnd.x > mouseX) {
        while (mouseX + spacement / 2 < currentCellFrontEnd.x) {
            cellSwitchingFrontend(-spacement, 0);
            cellSwitchingBackend(currentCellBackEnd.x, currentCellBackEnd.y, -1, 0);
        }
    }
}
