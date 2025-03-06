const c = @import("constant.zig");

var gpa = c.std.heap.GeneralPurposeAllocator(.{}){};
const allocator = gpa.allocator();
const n: usize = 9;

var gridLocation: ?*const [n][n]u8 = null;

var currentCell = struct {
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
    
    if (gridLocation != null) {
        drawBackendGrid();
        if (gridLocation) |grid| {
            grid.*[currentCellSelected.x][currentCellSelected.y]
        }
    }
}

pub fn drawBackendGrid() void {
    c.clear();

    if (gridLocation) |grid| {
        for (0..n) |i| {
            for (0..n) |j| {
                c.print("[{c}]", .{grid.*[i][j]});
            }
            c.print("\n", .{});
        }
    }
}
