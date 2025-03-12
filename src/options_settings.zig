const c = @import("constant.zig");

pub fn buttons_setup() void {
    c.s.background_display();

    c.s.back_button.draw();

    c.s.back_button.color = if (c.s.back_button.isHover()) c.rl.Color.gray else c.rl.Color.white;

    if (c.s.back_button.isClicked()) {
        c.w.layer = c.w.Layer.SettingView;
    }

    c.s.pink_right_arrow.draw();
    c.s.blue_left_arrow.draw();

    c.s.blue_top_arrow.draw();
    c.s.pink_bottom_arrow.draw();
}
