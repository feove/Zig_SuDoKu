const c = @import("constant.zig");

const fshiny_font_bytes = @embedFile("font/Texts/SuperShiny-0v0rG.ttf");
const superdream_font_bytes = @embedFile("font/Texts/SuperDream-ax3vE.ttf");

const ProtoNerdFont_Bold_bytes = @embedFile("font/Texts/0xProtoNerdFont-Bold.ttf");

pub var dreamFont_100: c.rl.Font = undefined;
pub var ProtoNerdFont_Bold_30: c.rl.Font = undefined;

pub fn FontInit() !void {
    dreamFont_100 = try loadFSuperDreamFont(100);
    ProtoNerdFont_Bold_30 = try loadProtoNerdFont_Bold_30(30);
}

pub fn loadProtoNerdFont_Bold_30(fontSize: i32) !c.rl.Font {
    return try c.rl.loadFontFromMemory(".ttf", ProtoNerdFont_Bold_bytes, fontSize, null);
}

fn loadFShinyFont(fontSize: i32) !c.rl.Font {
    return try c.rl.loadFontFromMemory(".ttf", fshiny_font_bytes, fontSize, null);
}

pub fn loadFSuperDreamFont(fontSize: i32) !c.rl.Font {
    return try c.rl.loadFontFromMemory(".ttf", superdream_font_bytes, fontSize, null);
}

pub fn newText(font: c.rl.Font, text: [:0]const u8, x: f32, y: f32, fontSize: f32, spacing: f32, tint: c.rl.Color) void {
    const position: c.rl.Vector2 = c.rl.Vector2.init(x, y);
    c.rl.drawTextEx(font, text, position, fontSize, spacing, tint);
}
