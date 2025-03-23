const c = @import("constant.zig");

pub var exitWindowByProgram = false;

pub const Layer = enum {
    GameMenuView,
    PlayView,
    SettingView,
    EndGameView,
    OptionView,
    VictoryView,
    DraftSheetView,
    QuickInputView,
};

pub var previous_layer = Layer.GameMenuView;

pub var layer = Layer.GameMenuView;

var GameLaunched: bool = true;
pub var CanGameOver: bool = true;
pub var WonSound: bool = true;

pub fn windowHasBeenQuit() bool {
    return c.rl.isKeyPressed(c.rl.KeyboardKey.a) or c.rl.isKeyPressed(c.rl.KeyboardKey.q);
}

pub fn QuickInputLayer() void {
    c.q.panel_display();
}

pub fn DraftSheetLayer() void {
    c.d.pencilPanelView();
}

pub fn VictoryLayer() !void {
    if (WonSound) {
        c.sn.soundControl.play(c.sn.good_answer_sound);
        WonSound = false;
    }
    c.v.imageDisplay();
}

pub fn OptionsLayer() void {
    c.o.buttons_setup();

    c.t.newText(c.t.Espial_Regular_Font, "Options", 270, 160, 60, 0, c.rl.Color.black);

    c.t.newText(c.t.Espial_Regular_Font, "Controls :", 185, 275, 40, 0, c.rl.Color.black);

    c.t.newText(c.t.Espial_Regular_Font, "Quick Access : ", 185, 400, 35, 0, c.rl.Color.black);
}

pub fn GameMenuLayer() !void {
    if (GameLaunched) {
        c.sn.soundControl.play(c.sn.rdn056);
        GameLaunched = false;
        WonSound = true;
    }

    c.rl.clearBackground(c.rl.Color.white);

    c.gm.playPressed();
    c.gm.settingsPressed();

    c.t.newText(c.t.dreamFont_100, "SuDoKu", 225, 100, 100, 5, c.rl.Color.black);
    c.t.newText(c.t.ProtoNerdFont_Bold_30, "Zig Edition", 300, 205, 30, 0, c.rl.Color.gray);

    c.gm.startButtonPressed();
    c.gm.levelButton();

    c.gm.doubleArrowsSet();
    c.gm.dropDownButtonPressed();

    c.gm.settingButton();
}

pub fn SettingLayer() void {
    c.s.background_display();
    c.s.buttons_display();

    c.t.newText(c.t.Espial_Regular_Font, "Settings", 265, 170, 60, 0, c.rl.Color.black);

    c.s.isGameMenuPressed();
    c.s.isPlayViewPressed();
}

pub fn EndGameLayer() !void {
    //c.rl.clearBackground(c.rl.Color.yellow);

    if (c.w.CanGameOver) {
        c.wait(2);
        c.w.CanGameOver = false;
        c.sn.soundControl.play(c.sn.game_over_sound);
    }
    c.e.isGameMenuPressed();

    c.e.imageDisplay();

    try c.e.yes_or_no_areas();
    //c.rl.drawText("End", 100, 100, 35, c.rl.Color.black);
}

pub fn PlayLayer() !void {
    if (!GameLaunched) {
        try c.g.BackendgridInit(c.gm.current_texture);
        try c.g.FrontendgridInit();

        GameLaunched = true;
    }

    c.g.drawFrontEndGrid();

    c.rl.drawFPS(20, 740);

    c.g.updateCellSelector();

    c.g.isIntegerPressed();

    c.p.TopGridinterface();

    try c.p.settingsOrResetButtons();

    c.p.pencilButton();

    c.p.cheatPressed();

    try c.p.resetPressed();

    c.p.isVictory();

    if (c.rl.isKeyPressed(c.rl.KeyboardKey.h)) {
        c.p.loseLife();
    }

    c.go.isGameOver();
}
