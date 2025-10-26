const std = @import("std");

pub fn main() !void {
    var rand_init = std.Random.DefaultPrng.init(blk: {
        var seed: u64 = undefined;
        try std.posix.getrandom(std.mem.asBytes(&seed));
        break :blk seed;
    });
    const rand = rand_init.random();
    const min_chars = rand.intRangeAtMost(u8, 18, 22);
    const dot_rand1 = rand.intRangeAtMost(u8, 2, 8);
    const dot_rand2 = rand.intRangeAtMost(u8, 10, 16);
    var digit_or_alpha: u8 = undefined;
    var my_char: u8 = undefined;
    var ret_chars_array: [32]u8 = undefined;
    var i: u8 = 1;
    my_char = rand.intRangeAtMost(u8, 97, 122);
    ret_chars_array[0] = my_char;
    while (i < min_chars) : (i += 1) {
        if (i == dot_rand1 or i == dot_rand2) {
            my_char = 46;
        } else {
            digit_or_alpha = rand.intRangeAtMost(u8, 1, 3);
            if (digit_or_alpha == 1) {
                my_char = rand.intRangeAtMost(u8, 48, 57);
            } else if (digit_or_alpha == 2) {
                my_char = rand.intRangeAtMost(u8, 65, 90);
            } else if (digit_or_alpha == 3) {
                my_char = rand.intRangeAtMost(u8, 97, 122);
            } else {
                std.os.linux.exit(1);
            }
        }
        ret_chars_array[i] = my_char;
    }
    const ret_chars_splice = ret_chars_array[0..i];
    std.debug.print("{s}\n", .{ret_chars_splice});
}
