const c = @import("constant.zig");

pub const Layer = enum {
    GameMenuView,
    PlayView,
    SettingView,
    EndGameView,
};

pub var layer = Layer.GameMenuView;

pub fn windowHasBeenQuit() bool {
    return c.rl.isKeyPressed(c.rl.KeyboardKey.a) or c.rl.isKeyPressed(c.rl.KeyboardKey.q);
}
pub fn GameMenuLayer() !void {
    c.rl.clearBackground(c.rl.Color.white);

    c.gm.playPressed();
    c.gm.settingsPressed();

    c.t.newText(c.t.dreamFont_100, "SuDoKu", 220, 100, 100, 5, c.rl.Color.black);
    c.t.newText(c.t.ProtoNerdFont_Bold_30, "Zig Edition", 300, 205, 30, 0, c.rl.Color.gray);
    c.clear();
}

pub fn SettingLayer() void {
    c.rl.clearBackground(c.rl.Color.orange);

    c.s.isGameMenuPressed();
    c.s.isPlayViewPressed();

    c.rl.drawText("Setting Layer", 100, 100, 35, c.rl.Color.black);
}

pub fn EndGameLayer() void {
    c.rl.clearBackground(c.rl.Color.yellow);
    c.e.isGameMenuPressed();

    c.rl.drawText("End", 100, 100, 35, c.rl.Color.black);
}

pub fn PlayLayer() void {
    c.g.drawFrontEndGrid();

    c.rl.drawFPS(20, 20);

    c.g.updateCellSelector();

    c.g.isIntegerPressed();

    c.g.settingPressed();
    c.g.endPressed();
}
