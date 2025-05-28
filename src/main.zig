const VGA_WIDTH = 80;
const VGA_HEIGHT = 25;
const VGA_MEMORY: [*]volatile u16 = @ptrFromInt(0xb8000);

var cursor_x: usize = 0;
var cursor_y: usize = 0;

fn printChar(c: u8, color: u8) void {
    if (c == '\n') {
        cursor_x = 0;
        cursor_y += 1;
        return;
    }

    const index = cursor_y * VGA_WIDTH + cursor_x;
    VGA_MEMORY[index] = (@as(u16, color) << 8) | c;
    cursor_x += 1;

    if (cursor_x >= VGA_WIDTH) {
        cursor_x = 0;
        cursor_y += 1;
    }
}

fn print(msg: []const u8, color: u8) void {
    for (msg) |c| {
        printChar(c, color);
    }
}

pub export fn kmain() callconv(.C) noreturn {
    print("Welcome to Zig OS!\n", 0x0A); // Light green
    print("Type-safe and blazing fast!\n", 0x0F); // White
    print("Now running in an infinite loop...\n", 0x0E); // Yellow

    while (true) {}
}
