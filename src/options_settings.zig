const c = @import("constant.zig");

pub fn buttons_setup() void {
    c.s.background_display();

    c.s.back_button.draw();

    c.s.back_button.color = if (c.s.back_button.isHover()) c.rl.Color.gray else c.rl.Color.white;

    c.s.mute_state_button.color = if (c.s.mute_state_button.isHover()) c.rl.Color.gray else c.rl.Color.white;
    c.s.unmute_state_button.color = if (c.s.unmute_state_button.isHover()) c.rl.Color.gray else c.rl.Color.white;

    if (c.s.back_button.isClicked()) {
        c.w.layer = c.w.Layer.SettingView;
    }

    c.s.pink_right_arrow.draw();
    c.s.blue_left_arrow.draw();

    c.s.blue_top_arrow.draw();
    c.s.pink_bottom_arrow.draw();

    c.s.right_click_icon.draw();

    if (c.sn.soundControl.canPlayAllSound) {
        c.s.unmute_state_button.draw();
    } else {
        c.s.mute_state_button.draw();
        c.sn.soundControl.stopMusic(c.sn.rdn056);
    }

    if (c.s.mute_state_button.isClicked()) {
        c.sn.soundControl.canPlayAllSound = !c.sn.soundControl.canPlayAllSound;
        if (c.sn.soundControl.canPlayAllSound) {
            c.sn.soundControl.play(c.sn.rdn056);
        }
    }
}
