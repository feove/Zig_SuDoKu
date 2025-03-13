const c = @import("constant.zig");

const ClickableArea = struct {
    x: f32,
    y: f32,
    width: f32,
    height: f32,
    color: c.rl.Color,
    alpha: u8 = 0,

    fn draw(self: *const ClickableArea) void {
        const rect = c.rl.Rectangle{
            .x = self.x,
            .y = self.y,
            .width = self.width,
            .height = self.height,
        };

        const updated_color = c.rl.Color{
            .r = self.color.r,
            .g = self.color.g,
            .b = self.color.b,
            .a = self.alpha,
        };

        c.rl.drawRectangleRounded(rect, 0.3, 8, updated_color);
        c.rl.drawRectangleRoundedLines(rect, 0.3, 8, c.rl.Color.dark_gray); // ✅ Fixed function call
    }

    fn isHover(self: *const ClickableArea) bool {
        const mouse_position: c.rl.Vector2 = c.rl.getMousePosition();
        return mouse_position.x >= self.x and mouse_position.y >= self.y and
            mouse_position.x <= self.x + self.width and
            mouse_position.y <= self.y + self.height;
    }

    fn isClicked(self: *const ClickableArea) bool {
        return self.isHover() and c.rl.isMouseButtonPressed(c.rl.MouseButton.left);
    }
};

var clickable_area_yes = ClickableArea{
    .x = 305,
    .y = 458,
    .width = 80,
    .height = 40,
    .color = c.rl.Color{ .r = 150, .g = 150, .b = 150, .a = 0 },
};

var clickable_area_no = ClickableArea{
    .x = 402,
    .y = 458,
    .width = 80,
    .height = 40,
    .color = c.rl.Color{ .r = 150, .g = 150, .b = 150, .a = 0 },
};

pub fn isGameMenuPressed() void {
    if (c.rl.isKeyPressed(c.rl.KeyboardKey.c)) {
        c.w.layer = c.w.Layer.GameMenuView;
    }
}

pub fn imageDisplay() void {
    c.g.drawFrontEndGrid();
    //c.p.TopGridinterface();
    c.s.game_over_image.draw();
}

pub fn yes_or_no_areas() !void {
    if (clickable_area_yes.isHover()) {
        clickable_area_yes.alpha = 100;
        if (clickable_area_yes.isClicked()) {
            c.w.layer = c.w.Layer.PlayView;
            c.w.previous_layer = c.w.Layer.PlayView;
            c.p.GameInit();
            try c.g.gridReset();
            try c.g.BackendgridInit(c.gm.current_texture);
            try c.g.FrontendgridInit();

            c.w.CanGameOver = true;
        }
    } else {
        clickable_area_yes.alpha = 0;
    }
    clickable_area_yes.draw();

    if (clickable_area_no.isHover()) {
        clickable_area_no.alpha = 100;
        if (clickable_area_no.isClicked()) {
            c.w.layer = c.w.Layer.GameMenuView;
        }
    } else {
        clickable_area_no.alpha = 0;
    }
    clickable_area_no.draw();
}
