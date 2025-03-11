const c = @import("constant.zig");

const fshiny_font_bytes = @embedFile("font/Texts/SuperShiny-0v0rG.ttf");
const superdream_font_bytes = @embedFile("font/Texts/SuperDream-ax3vE.ttf");
const ProtoNerdFont_Bold_bytes = @embedFile("font/Texts/0xProtoNerdFont-Bold.ttf");
const MetalFont_Regular_bytes = @embedFile("font/Texts/MetalsmithRegular-p7ylO.otf");
const Espial_Regular_Font_bytes = @embedFile("font/Texts/EspialRegular15-6Y08Y.otf");

pub var dreamFont_100: c.rl.Font = undefined;
pub var ProtoNerdFont_Bold_30: c.rl.Font = undefined;
pub var ProtoNerdFont_Bold_70: c.rl.Font = undefined;
pub var MetalFont_Regular_70: c.rl.Font = undefined;
pub var Espial_Regular_Font: c.rl.Font = undefined;

pub fn FontInit() !void {
    dreamFont_100 = try loadFSuperDreamFont(100);
    ProtoNerdFont_Bold_30 = try loadProtoNerdFont_Bold_30(30);
    MetalFont_Regular_70 = try loadMetalFont(70);
    Espial_Regular_Font = try loadEspial_Regular_(120);
}

pub fn loadEspial_Regular_(fontSize: i32) !c.rl.Font {
    return try c.rl.loadFontFromMemory(".otf", Espial_Regular_Font_bytes, fontSize, null);
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

pub fn loadMetalFont(fontSize: i32) !c.rl.Font {
    return try c.rl.loadFontFromMemory(".otf", MetalFont_Regular_bytes, fontSize, null);
}

pub fn newText(font: c.rl.Font, text: [:0]const u8, x: f32, y: f32, fontSize: f32, spacing: f32, tint: c.rl.Color) void {
    const position: c.rl.Vector2 = c.rl.Vector2.init(x, y);
    c.rl.drawTextEx(font, text, position, fontSize, spacing, tint);
}
