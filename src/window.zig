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

    const dreamFont = try c.t.loadFSuperDreamFont();

    c.t.newText(dreamFont, "SuDoKu", 260, 120, 70, 5, c.rl.Color.black);
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
