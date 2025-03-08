const c = @import("constant.zig");

const spacement = 70;

const init_grid_position: c.rl.Vector2 = c.rl.Vector2.init(70, 70);
const init_selector_position: c.rl.Vector2 = c.rl.Vector2.init(85, 120); //Left Top Corner

const h_diff_cursor: f32 = spacement;
const v_diff_cursor: f32 = spacement;

var selector_shape: c.rl.Rectangle = c.rl.Rectangle.init(init_selector_position.x, init_selector_position.y, 40, 5);

const Cell = struct {
    x: u16,
    y: u16,
    width: u16,
    height: u16,
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

var currentCellBackEnd = CurrentCellBackend{};
var currentCellFrontEnd = CurrentCellFrontEnd{};

var gpa = c.std.heap.GeneralPurposeAllocator(.{}){};
const allocator = gpa.allocator();

const n: usize = 9;
var BackendgridLocation: ?*[n][n]u8 = null;

pub fn BackendgridInit() !void {
    var backend_grid = try allocator.create([n][n]u8);

    for (0..n) |i| {
        for (0..n) |j| {
            backend_grid[i][j] = ' ';
        }
        c.print("\n", .{});
    }

    BackendgridLocation = backend_grid;
}

var FrontendgridLocation: ?*[n][n]Cell = null;

pub fn FrontendgridInit() !void {
    var frontend_grid = try allocator.create([n][n]Cell); // Allocate memory for a 2D array of Cells

    for (0..n) |i| {
        for (0..n) |j| {
            frontend_grid[i][j] = Cell{
                .x = @intFromFloat(init_grid_position.x + @as(f32, @floatFromInt(i)) * spacement + 20),
                .y = @intFromFloat(init_grid_position.y + @as(f32, @floatFromInt(j)) * spacement + 20),
                .width = spacement - 20,
                .height = spacement - 20,
            };
        }
    }

    FrontendgridLocation = frontend_grid;
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

    drawBackendGrid(); //Draw selectorBackend too

    drawFrontEndGrid();
    drawSelectorGrid();

    isClickedOnCell();
}

fn drawSelectorGrid() void {
    const i32_width: i32 = @as(i32, @intFromFloat(selector_shape.width));
    const i32_height: i32 = @as(i32, @intFromFloat(selector_shape.height));

    //Clear last selection
    c.rl.drawRectangle(currentCellFrontEnd.x_prev, currentCellFrontEnd.y_prev, i32_width, i32_height, c.rl.Color.white);

    selector_shape.x = @as(f32, @floatFromInt(currentCellFrontEnd.x));
    selector_shape.y = @as(f32, @floatFromInt(currentCellFrontEnd.y));

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
        grid[y][x] = ' ';

        const new_x: u8 = @intCast(@as(i16, x) + i);
        const new_y: u8 = @intCast(@as(i16, y) + j);

        grid[new_y][new_x] = 'X';

        currentCellBackEnd.x = new_x;
        currentCellBackEnd.y = new_y;

        currentCellBackEnd.on_bottom = new_y == n - 1;
        currentCellBackEnd.on_top = new_y == 0;
        currentCellBackEnd.on_left = new_x == 0;
        currentCellBackEnd.on_right = new_x == n - 1;
    }
}

fn drawFrontEndGrid() void {
    var x: i32 = init_grid_position.x;
    var y: i32 = init_grid_position.y;

    const x_end = init_grid_position.x + spacement * n;
    const y_end = init_grid_position.y + spacement * n;

    for (1..n + 2) |_| {
        c.rl.drawLine(x, y, x, y_end, c.rl.Color.black);
        x += spacement;
    }
    x = init_grid_position.x;
    for (1..n + 2) |_| {
        c.rl.drawLine(x, y, x_end, y, c.rl.Color.black);
        y += spacement;
    }
}

pub fn isIntegerPressed() void {
    if (c.rl.isKeyPressed(c.rl.KeyboardKey.one)) integerSetting('1');
    if (c.rl.isKeyPressed(c.rl.KeyboardKey.two)) integerSetting('2');
    if (c.rl.isKeyPressed(c.rl.KeyboardKey.three)) integerSetting('3');
    if (c.rl.isKeyPressed(c.rl.KeyboardKey.four)) integerSetting('4');
    if (c.rl.isKeyPressed(c.rl.KeyboardKey.five)) integerSetting('5');
    if (c.rl.isKeyPressed(c.rl.KeyboardKey.six)) integerSetting('6');
    if (c.rl.isKeyPressed(c.rl.KeyboardKey.seven)) integerSetting('7');
    if (c.rl.isKeyPressed(c.rl.KeyboardKey.eight)) integerSetting('8');
    if (c.rl.isKeyPressed(c.rl.KeyboardKey.nine)) integerSetting('9');
}

fn integerSetting(integer: u8) void {
    BackendgridLocation.?.*[currentCellBackEnd.y][currentCellBackEnd.x] = integer;
    drawBackendGrid();
}

pub fn drawBackendGrid() void {
    c.clear();

    for (0..n) |i| {
        for (0..n) |j| {
            c.print("[{c}]", .{BackendgridLocation.?.*[i][j]});
        }
        c.print("\n", .{});
    }
    c.print("\n" ** 3, .{});
    c.print(" Backend :\n X : {d}\n Y : {d}\n", .{ currentCellBackEnd.x, currentCellBackEnd.y });
    c.print("\n Frontend :\n X : {d}\n Y : {d}\n", .{ currentCellFrontEnd.x, currentCellFrontEnd.y });
    c.print("\n" ** 3, .{});
}

fn isClickedOnCell() void {
    if (c.rl.isMouseButtonPressed(c.rl.MouseButton.left)) {
        const mousePos = c.rl.getMousePosition();

        if (mousePos.x > cursorlimits.x_left and mousePos.x < cursorlimits.x_right and mousePos.y > cursorlimits.y_top and mousePos.y < cursorlimits.y_bottom) {
            const mouseX: i32 = @as(i32, @intFromFloat(mousePos.x));
            const mouseY: i32 = @as(i32, @intFromFloat(mousePos.y));

            c.print("Mouse Clicked at: X: {d}, Y: {d}\n", .{ mouseX, mouseY });
            c.print("Backend: X: {d}, Frontend: Y: {d}\n", .{ currentCellBackEnd.x, currentCellFrontEnd.x });

            cursorToLeft(mouseX);
            cursorToRight(mouseX);

            cursorToTop(mouseY);
            cursorToBottom(mouseY);

            drawFrontEndGrid();
            drawBackendGrid();
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
