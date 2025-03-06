//Here are All of constants

pub const std = @import("std");

pub const print = std.debug.print;

pub const stdout = std.io.getStdOut().writer();

pub const w = @import("window.zig");
pub const g = @import("grid.zig");

pub const rl = @import("raylib");

pub fn clear() void {
    stdout.writeAll("\x1b[2J\x1b[H") catch {};
}
