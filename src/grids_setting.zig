const c = @import("constant.zig");

var gpa = c.std.heap.GeneralPurposeAllocator(.{}){};
const allocator = gpa.allocator();

pub var copy_for_backend_and_frontend: ?*[9][9]u8 = null;
pub var solution_grid: ?*[9][9]u8 = null;

pub fn readSudokuGrids(difficulty: u8) !void {
    copy_for_backend_and_frontend = try allocator.create([9][9]u8);
    solution_grid = try allocator.create([9][9]u8);

    const filenames = [_][]const u8{
        "",
        "src/data/easy_grids.json",
        "src/data/normal_grids.json",
        "src/data/difficult_grids.json",
        "src/data/extreme_grids.json",
    };

    const filename = filenames[difficulty];

    // Open the JSON file
    var file = try c.std.fs.cwd().openFile(filename, .{});
    defer file.close();

    // Read the file
    const json_data = try file.readToEndAlloc(allocator, 1024 * 10);
    defer allocator.free(json_data);

    const parsed = c.std.json.parseFromSlice(c.std.json.Value, allocator, json_data, .{}) catch |err| {
        c.std.debug.print("JSON Parse Error: {}\n", .{err});
        return err;
    };
    defer parsed.deinit();

    const root_object = parsed.value.object;

    // Create a mutable iterator to go through the object entries
    var iter = root_object.iterator(); // Declare it as mutable

    // If the first key matches "grids_", process it
    if (iter.next()) |entry| {
        const key = entry.key_ptr.*;
        if (c.std.mem.startsWith(u8, key, "grids_")) {
            const grid_array = entry.value_ptr.*.array;

            // Process the first grid array that matches the difficulty
            for (grid_array.items) |grid_obj| {
                const grid_difficulty = grid_obj.object.get("difficulty") orelse continue;

                if (grid_difficulty.integer != difficulty) continue;

                const incomplete_grid = grid_obj.object.get("incomplete_grid") orelse continue;
                const solved_grid = grid_obj.object.get("solved_grid") orelse continue;

                // Populate the backend grid with the incomplete grid data
                var row_index: usize = 0;
                for (incomplete_grid.array.items) |row| {
                    var col_index: usize = 0;
                    for (row.array.items) |cell| {
                        copy_for_backend_and_frontend.?.*[row_index][col_index] = @intCast(cell.integer);
                        c.std.debug.print("{d} ", .{cell.integer});
                        col_index += 1;
                    }
                    c.std.debug.print("\n", .{});
                    row_index += 1;
                }

                c.std.debug.print("Solved Grid:\n", .{});
                row_index = 0;
                for (solved_grid.array.items) |row| {
                    var col_i: usize = 0;
                    for (row.array.items) |cell| {
                        c.std.debug.print("{d}[{d}][{d}] ", .{ cell.integer, row_index, col_i });
                        col_i += 1;
                    }
                    c.std.debug.print("\n", .{});
                }

                // Exit after processing the first valid grid
                return; // No value, just return void
            }
        }
    }

    // If we reach here, there was no matching grid array
    return error.NoGridsFound;
}

pub fn main() !void {
    try readSudokuGrids(1);
}
