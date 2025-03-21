//Here are All constants

pub const std = @import("std");

pub const print = std.debug.print;

pub const stdout = std.io.getStdOut().writer();

const sleep = std.time.sleep;

//Files
pub const w = @import("window.zig");
pub const g = @import("grid.zig");
pub const m = @import("main.zig");
pub const gm = @import("game_menu.zig");
pub const rl = @import("raylib");
pub const s = @import("settings.zig");
pub const e = @import("end.zig");
pub const t = @import("texts.zig");
pub const tr = @import("textures.zig");
pub const p = @import("play.zig");
pub const gs = @import("grids_setting.zig");
pub const go = @import("game_over.zig");
pub const o = @import("options_settings.zig");
pub const v = @import("victory.zig");
pub const sn = @import("sounds.zig");
pub const d = @import("draft_sheet.zig");
pub const q = @import("quick_input.zig");

pub fn clear() void {
    stdout.writeAll("\x1b[2J\x1b[H") catch {};
}

pub fn wait(time: f64) void {
    sleep(@as(u64, @intFromFloat(time * 1_000_000_000.0)));
}
