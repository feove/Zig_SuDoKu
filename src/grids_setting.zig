const c = @import("constant.zig");

var gpa = c.std.heap.GeneralPurposeAllocator(.{}){};
const allocator = gpa.allocator();

pub fn readSudokuGrids() !void {
    var file = try c.std.fs.cwd().openFile("src/data/grids.json", .{});
    defer file.close();

    const json_data = try file.readToEndAlloc(allocator, 1024 * 10);
    defer allocator.free(json_data);

    const parsed = c.std.json.parseFromSlice(c.std.json.Value, allocator, json_data, .{}) catch |err| {
        c.std.debug.print("JSON Parse Error: {}\n", .{err});
        return err;
    };
    defer parsed.deinit();

    const root_object = parsed.value.object;

    // Iterate over all "grids_X" keys in the JSON file
    var iter = root_object.iterator();
    while (iter.next()) |entry| {
        const key = entry.key_ptr.*;
        if (c.std.mem.startsWith(u8, key, "grids_")) {
            const grid_array = entry.value_ptr.*.array;

            for (grid_array.items) |grid_obj| {
                const difficulty = grid_obj.object.get("difficulty") orelse continue;
                const incomplete_grid = grid_obj.object.get("incomplete_grid") orelse continue;
                const solved_grid = grid_obj.object.get("solved_grid") orelse continue;

                c.std.debug.print("\nGrid Set: {s}\n", .{key});
                c.std.debug.print("Difficulty: {d}\n", .{difficulty.integer});

                // Print incomplete grid
                c.std.debug.print("Incomplete Grid:\n", .{});
                for (incomplete_grid.array.items) |row| {
                    for (row.array.items) |cell| {
                        c.std.debug.print("{d}", .{cell.integer});
                    }
                    c.std.debug.print("\n", .{});
                }

                // Print solved grid
                c.std.debug.print("Solved Grid:\n", .{});
                for (solved_grid.array.items) |row| {
                    for (row.array.items) |cell| {
                        c.std.debug.print("{d}", .{cell.integer});
                    }
                    c.std.debug.print("\n", .{});
                }
            }
        }
    }
}

pub fn main() !void {
    try readSudokuGrids();
}
