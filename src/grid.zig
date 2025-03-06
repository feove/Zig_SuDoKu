const c = @import("constant.zig");

var gpa = c.std.heap.GeneralPurposeAllocator(.{}){};
const allocator = gpa.allocator();
const n: usize = 9;

var gridLocation: ?*[n][n]u8 = null;

const currentCell = struct {
    x: u8 = 0,
    y: u8 = 0,
    on_top: bool = true,
    on_left: bool = true,
    on_right: bool = false,
    on_bottom: bool = false,
};

var currentCellSelected = currentCell{};

pub fn gridInit() !void {
    var grid = try allocator.create([n][n]u8);

    for (0..n) |i| {
        for (0..n) |j| {
            grid[i][j] = ' ';
        }
        c.print("\n", .{});
    }

    gridLocation = grid;
}

pub fn updateCellSelector() void {
    if (c.rl.isKeyPressed(c.rl.KeyboardKey.down) and !currentCellSelected.on_bottom) {
        cellSwitching(currentCellSelected.x, currentCellSelected.y, 0, 1);
    }

    if (c.rl.isKeyPressed(c.rl.KeyboardKey.left) and !currentCellSelected.on_left) {
        cellSwitching(currentCellSelected.x, currentCellSelected.y, -1, 0);
    }

    if (c.rl.isKeyPressed(c.rl.KeyboardKey.up) and !currentCellSelected.on_top) {
        cellSwitching(currentCellSelected.x, currentCellSelected.y, 0, -1);
    }

    if (c.rl.isKeyPressed(c.rl.KeyboardKey.right) and !currentCellSelected.on_right) {
        cellSwitching(currentCellSelected.x, currentCellSelected.y, 1, 0);
    }
    drawFrontEndGrid();
    drawBackendGrid();
}

fn cellSwitching(x: u8, y: u8, i: i8, j: i8) void {
    if (gridLocation) |grid| {
        grid[y][x] = ' ';

        const new_x: u8 = @intCast(@as(i16, x) + i);
        const new_y: u8 = @intCast(@as(i16, y) + j);

        grid[new_y][new_x] = 'X';

        currentCellSelected.x = new_x;
        currentCellSelected.y = new_y;

        currentCellSelected.on_bottom = new_y == n - 1;
        currentCellSelected.on_top = new_y == 0;
        currentCellSelected.on_left = new_x == 0;
        currentCellSelected.on_right = new_x == n - 1;
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
    gridLocation.?.*[currentCellSelected.y][currentCellSelected.x] = integer;
    drawBackendGrid();
}

pub fn drawBackendGrid() void {
    c.clear();

    for (0..n) |i| {
        for (0..n) |j| {
            c.print("[{c}]", .{gridLocation.?.*[i][j]});
        }
        c.print("\n", .{});
    }
    c.print("\n" ** 3, .{});
    c.print(" X : {d}\n Y : {d}\n", .{ currentCellSelected.x, currentCellSelected.y });
    c.print("\n" ** 3, .{});
}
pub fn drawFrontEndGrid() void {
    var x: i32 = 70;
    var y: i32 = 70;

    const spacement = 70;

    const x_end = 70 + spacement * n;
    const y_end = 70 + spacement * n;

    for (1..n + 2) |_| { // Use `_` since we don't need the loop variable
        c.rl.drawLine(x, y, x, y_end, c.rl.Color.black);
        x += spacement;
    }
    x = 70;
    for (1..n + 2) |_| { // Use `_` since we don't need the loop variable
        c.rl.drawLine(x, y, x_end, y, c.rl.Color.black);
        y += spacement;
    }
}
