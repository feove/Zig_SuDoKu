const c = @import("constant.zig");

pub const fshiny_font_bytes = @embedFile("font/Texts/SuperShiny-0v0rG.ttf");
pub const superdream_font_bytes = @embedFile("font/Texts/SuperDream-ax3vE.ttf");

pub fn loadFShinyFont() !c.rl.Font {
    return try c.rl.loadFontFromMemory(".ttf", fshiny_font_bytes, 60, null);
}
pub fn loadFSuperDreamFont() !c.rl.Font {
    return try c.rl.loadFontFromMemory(".ttf", superdream_font_bytes, 60, null);
}

pub fn newText(font: c.rl.Font, text: [:0]const u8, x: f32, y: f32, fontSize: f32, spacing: f32, tint: c.rl.Color) void {
    const position: c.rl.Vector2 = c.rl.Vector2.init(x, y);
    c.rl.drawTextEx(font, text, position, fontSize, spacing, tint);
}
