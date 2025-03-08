//Here are All constants

pub const std = @import("std");

pub const print = std.debug.print;

pub const stdout = std.io.getStdOut().writer();

const sleep = std.time.sleep;

//Files
pub const w = @import("window.zig");
pub const g = @import("grid.zig");
pub const m = @import("main.zig");

pub const rl = @import("raylib");

pub fn clear() void {
    stdout.writeAll("\x1b[2J\x1b[H") catch {};
}

pub fn wait(time: f64) void {
    sleep(@as(u64, @intFromFloat(time * 1_000_000_000.0)));
}
