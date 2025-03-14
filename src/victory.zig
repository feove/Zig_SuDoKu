const c = @import("constant.zig");

pub fn imageDisplay() void {
    c.g.drawFrontEndGrid();
    c.s.victory_panel.draw();
    c.s.victory_menu_button.draw();

    c.s.victory_menu_button.color = c.rl.Color.white;
    if (c.s.victory_menu_button.isHover()) {
        c.s.victory_menu_button.color = c.rl.Color.gray;

        if (c.s.victory_menu_button.isClicked()) {
            c.w.layer = c.w.Layer.GameMenuView;
        }
    }
}
