const c = @import("constant.zig");

var gpa = c.std.heap.GeneralPurposeAllocator(.{}){};
const allocator = gpa.allocator();
const n: usize = 9;

pub fn gridInit() !void {
    var grid: *[n][n]u8 = try allocator.create([n][n]u8);
    defer allocator.free(grid);

    for (0..n) |i| {
        for (0..n) |j| {
            grid[i][j] = 0;
            c.print("{d}", .{grid[i][j]});
        }
        c.print("\n", .{});
    }
}

pub fn updateCellSelector() void {
    return;
}
