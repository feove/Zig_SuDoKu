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

    c.t.newText(c.t.dreamFont_100, "SuDoKu", 225, 100, 100, 5, c.rl.Color.black);
    c.t.newText(c.t.ProtoNerdFont_Bold_30, "Zig Edition", 300, 205, 30, 0, c.rl.Color.gray);

    c.gm.startButtonPressed();
    c.gm.levelButton();

    c.gm.doubleArrowsSet();
    c.gm.dropDownButtonPressed();

    //c.clear();
}

pub fn SettingLayer() void {
    c.rl.clearBackground(c.rl.Color.white);

    c.rl.drawRectangleRounded(c.rl.Rectangle.init(100, 100, 400, 400), 30.0, 50, c.rl.Color.white);
    c.s.isGameMenuPressed();
    c.s.isPlayViewPressed();

    c.s.buttons_display();

    c.t.newText(c.t.Espial_Regular_Font, "Settings", 220, 100, 80, 0, c.rl.Color.black);
    //c.rl.drawText("Setting Layer", 100, 100, 35, c.rl.Color.black);
}

pub fn EndGameLayer() void {
    c.rl.clearBackground(c.rl.Color.yellow);
    c.e.isGameMenuPressed();

    c.rl.drawText("End", 100, 100, 35, c.rl.Color.black);
}

pub fn PlayLayer() void {
    c.g.drawFrontEndGrid();

    c.rl.drawFPS(20, 740);

    c.g.updateCellSelector();

    c.g.isIntegerPressed();

    c.p.TopGridinterface();

    c.p.endPressed();
}
