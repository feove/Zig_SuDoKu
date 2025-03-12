const c = @import("constant.zig");

var gpa = c.std.heap.GeneralPurposeAllocator(.{}){};
const allocator = gpa.allocator();

pub var copy_for_backend_and_frontend: ?*[9][9]u8 = null;

pub fn readSudokuGrids(difficulty: u8) !void {
    copy_for_backend_and_frontend = try allocator.create([9][9]u8);

    const filenames = [_][]const u8{
        "",
        "src/data/easy_grids.json",
        "src/data/normal_grids.json",
        "src/data/difficult_grids.json",
        "src/data/extreme_grids.json",
    };

    const filename = filenames[difficulty];

    //open the json file
    var file = try c.std.fs.cwd().openFile(filename, .{});
    defer file.close();

    //read file
    const json_data = try file.readToEndAlloc(allocator, 1024 * 10);
    defer allocator.free(json_data);

    const parsed = c.std.json.parseFromSlice(c.std.json.Value, allocator, json_data, .{}) catch |err| {
        c.std.debug.print("JSON Parse Error: {}\n", .{err});
        return err;
    };
    defer parsed.deinit();

    const root_object = parsed.value.object;

    var iter = root_object.iterator();
    while (iter.next()) |entry| {
        const key = entry.key_ptr.*;
        if (c.std.mem.startsWith(u8, key, "grids_")) {
            const grid_array = entry.value_ptr.*.array;

            for (grid_array.items) |grid_obj| {
                const grid_difficulty = grid_obj.object.get("difficulty") orelse continue;

                if (grid_difficulty.integer != difficulty) continue;

                const incomplete_grid = grid_obj.object.get("incomplete_grid") orelse continue;
                const solved_grid = grid_obj.object.get("solved_grid") orelse continue;

                var row_index: usize = 0;
                for (incomplete_grid.array.items) |row| {
                    var col_index: usize = 0;
                    for (row.array.items) |cell| {
                        copy_for_backend_and_frontend.?.*[row_index][col_index] = @intCast(cell.integer);

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
            }
        }
    }
}
