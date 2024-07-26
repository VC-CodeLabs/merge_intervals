const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    const start_time = std.time.nanoTimestamp();

    var input = [_][2]u16{ [_]u16{ 15, 18 }, [_]u16{ 8, 10 }, [_]u16{ 2, 6 }, [_]u16{ 1, 3 } };
    // var input = [_][2]u16{ [_]u16{ 1, 2 }, [_]u16{ 3, 4 }, [_]u16{ 5, 6 } };
    // var input = [_][2]u16{ [_]u16{ 1, 5 }, [_]u16{ 2, 4 }, [_]u16{ 6, 8 }, [_]u16{ 7, 10 } };
    // var input = [_][2]u16{ [_]u16{ 0, 1 }, [_]u16{ 1, 2 }, [_]u16{ 2, 3 }, [_]u16{ 3, 4 } };
    try merge(input[0..]);

    const end_time = std.time.nanoTimestamp();
    print("Time: {} ns\n", .{end_time - start_time});
}

fn merge(input: [][2]u16) !void {
    std.sort.pdq([2]u16, input[0..], {}, cmpByValue);
    var result: [][2]u16 = input;

    var ii: usize = 1; // Input index.
    var ri: usize = 0; // Result index.

    while (ii < input.len) {
        if (input[ii][0] <= result[ri][1]) {
            result[ri][1] = @max(result[ii][1], input[ri][1]);

            if (ii == input.len) {
                break;
            }

            ii += 1;
        } else {
            ri += 1;
            result[ri] = input[ii];
            ii += 1;
        }
    }

    const stdout = std.io.getStdOut().writer();
    _ = try stdout.write("[");
    for (result, 0..) |item, i| {
        try stdout.print("[{},{}]", .{ item[0], item[1] });
        if (i != result.len - 1) {
            _ = try stdout.write(",");
        }
    }
    _ = try stdout.write("]\n");
}

fn cmpByValue(context: void, a: [2]u16, b: [2]u16) bool {
    return std.sort.asc(u16)(context, a[0], b[0]);
}

test "case0" {
    var input = [_][2]u16{ [_]u16{ 15, 18 }, [_]u16{ 8, 10 }, [_]u16{ 2, 6 }, [_]u16{ 1, 3 } };
    const result = [_][2]u16{ [_]u16{ 1, 6 }, [_]u16{ 8, 10 }, [_]u16{ 15, 18 } };
    try std.testing.expectEqualDeep(try merge(input[0..]), result[0..]);
}

test "case1" {
    var input = [_][2]u16{ [_]u16{ 1, 3 }, [_]u16{ 2, 6 }, [_]u16{ 8, 10 }, [_]u16{ 15, 18 } };
    const result = [_][2]u16{ [_]u16{ 1, 6 }, [_]u16{ 8, 10 }, [_]u16{ 15, 18 } };
    try std.testing.expectEqualDeep(try merge(input[0..]), result[0..]);
}

test "case2" {
    var input = [_][2]u16{ [_]u16{ 1, 4 }, [_]u16{ 4, 5 } };
    const result = [_][2]u16{[_]u16{ 1, 5 }};
    try std.testing.expectEqualDeep(try merge(input[0..]), result[0..]);
}

test "case3" {
    var input = [_][2]u16{ [_]u16{ 0, 2 }, [_]u16{ 3, 4 }, [_]u16{ 5, 7 }, [_]u16{ 6, 10 } };
    const result = [_][2]u16{ [_]u16{ 0, 2 }, [_]u16{ 3, 4 }, [_]u16{ 5, 10 } };
    try std.testing.expectEqualDeep(try merge(input[0..]), result[0..]);
}

test "case4" {
    var input = [_][2]u16{ [_]u16{ 0, 1 }, [_]u16{ 1, 2 }, [_]u16{ 2, 3 }, [_]u16{ 3, 4 } };
    const result = [_][2]u16{[_]u16{ 0, 4 }};
    try std.testing.expectEqualDeep(result[0..], try merge(input[0..]));
}

test "case5" {
    var input = [_][2]u16{ [_]u16{ 1, 2 }, [_]u16{ 3, 5 }, [_]u16{ 4, 8 }, [_]u16{ 10, 12 } };
    const result = [_][2]u16{ [_]u16{ 1, 2 }, [_]u16{ 3, 8 }, [_]u16{ 10, 12 } };
    try std.testing.expectEqualDeep(try merge(input[0..]), result[0..]);
}

test "case6" {
    var input = [_][2]u16{ [_]u16{ 5, 7 }, [_]u16{ 6, 9 }, [_]u16{ 1, 3 } };
    const result = [_][2]u16{ [_]u16{ 1, 3 }, [_]u16{ 5, 9 } };
    try std.testing.expectEqualDeep(try merge(input[0..]), result[0..]);
}

test "case7" {
    var input = [_][2]u16{ [_]u16{ 1, 3 }, [_]u16{ 3, 6 }, [_]u16{ 6, 8 } };
    const result = [_][2]u16{[_]u16{ 1, 8 }};
    try std.testing.expectEqualDeep(try merge(input[0..]), result[0..]);
}

test "case8" {
    var input = [_][2]u16{ [_]u16{ 1, 4 }, [_]u16{ 5, 10 }, [_]u16{ 10, 12 } };
    const result = [_][2]u16{ [_]u16{ 1, 4 }, [_]u16{ 5, 12 } };
    try std.testing.expectEqualDeep(try merge(input[0..]), result[0..]);
}

test "case9" {
    var input = [_][2]u16{ [_]u16{ 0, 3 }, [_]u16{ 5, 7 }, [_]u16{ 6, 8 }, [_]u16{ 10, 12 } };
    const result = [_][2]u16{ [_]u16{ 0, 3 }, [_]u16{ 5, 8 }, [_]u16{ 10, 12 } };
    try std.testing.expectEqualDeep(try merge(input[0..]), result[0..]);
}

test "case10" {
    var input = [_][2]u16{ [_]u16{ 1, 10 }, [_]u16{ 2, 3 }, [_]u16{ 4, 8 }, [_]u16{ 9, 12 } };
    const result = [_][2]u16{[_]u16{ 1, 12 }};
    try std.testing.expectEqualDeep(try merge(input[0..]), result[0..]);
}

test "case11" {
    var input = [_][2]u16{ [_]u16{ 1, 3 }, [_]u16{ 2, 4 }, [_]u16{ 3, 5 }, [_]u16{ 5, 7 } };
    const result = [_][2]u16{[_]u16{ 1, 7 }};
    try std.testing.expectEqualDeep(try merge(input[0..]), result[0..]);
}

test "case12" {
    var input = [_][2]u16{ [_]u16{ 0, 1 }, [_]u16{ 2, 3 }, [_]u16{ 4, 5 }, [_]u16{ 6, 7 } };
    const result = [_][2]u16{ [_]u16{ 0, 1 }, [_]u16{ 2, 3 }, [_]u16{ 4, 5 }, [_]u16{ 6, 7 } };
    try std.testing.expectEqualDeep(try merge(input[0..]), result[0..]);
}

test "case13" {
    var input = [_][2]u16{ [_]u16{ 1, 4 }, [_]u16{ 5, 9 }, [_]u16{ 8, 10 }, [_]u16{ 10, 12 } };
    const result = [_][2]u16{ [_]u16{ 1, 4 }, [_]u16{ 5, 12 } };
    try std.testing.expectEqualDeep(try merge(input[0..]), result[0..]);
}

test "case14" {
    var input = [_][2]u16{ [_]u16{ 1, 3 }, [_]u16{ 5, 8 }, [_]u16{ 6, 10 }, [_]u16{ 12, 15 } };
    const result = [_][2]u16{ [_]u16{ 1, 3 }, [_]u16{ 5, 10 }, [_]u16{ 12, 15 } };
    try std.testing.expectEqualDeep(try merge(input[0..]), result[0..]);
}

test "case15" {
    var input = [_][2]u16{ [_]u16{ 1, 3 }, [_]u16{ 2, 5 }, [_]u16{ 6, 9 }, [_]u16{ 8, 10 } };
    const result = [_][2]u16{ [_]u16{ 1, 5 }, [_]u16{ 6, 10 } };
    try std.testing.expectEqualDeep(try merge(input[0..]), result[0..]);
}

test "case16" {
    var input = [_][2]u16{ [_]u16{ 2, 6 }, [_]u16{ 1, 3 }, [_]u16{ 4, 7 }, [_]u16{ 5, 8 } };
    const result = [_][2]u16{[_]u16{ 1, 8 }};
    try std.testing.expectEqualDeep(try merge(input[0..]), result[0..]);
}

test "case17" {
    var input = [_][2]u16{ [_]u16{ 1, 2 }, [_]u16{ 2, 3 }, [_]u16{ 3, 4 }, [_]u16{ 4, 5 }, [_]u16{ 5, 6 } };
    const result = [_][2]u16{[_]u16{ 1, 6 }};
    try std.testing.expectEqualDeep(try merge(input[0..]), result[0..]);
}

test "case18" {
    var input = [_][2]u16{ [_]u16{ 1, 4 }, [_]u16{ 0, 2 }, [_]u16{ 3, 5 }, [_]u16{ 6, 8 } };
    const result = [_][2]u16{ [_]u16{ 0, 5 }, [_]u16{ 6, 8 } };
    try std.testing.expectEqualDeep(try merge(input[0..]), result[0..]);
}

test "case19" {
    var input = [_][2]u16{ [_]u16{ 5, 10 }, [_]u16{ 1, 3 }, [_]u16{ 4, 6 }, [_]u16{ 7, 8 } };
    const result = [_][2]u16{ [_]u16{ 1, 3 }, [_]u16{ 4, 10 } };
    try std.testing.expectEqualDeep(try merge(input[0..]), result[0..]);
}

test "case20" {
    var input = [_][2]u16{ [_]u16{ 1, 5 }, [_]u16{ 2, 4 }, [_]u16{ 6, 8 }, [_]u16{ 7, 10 } };
    const result = [_][2]u16{ [_]u16{ 1, 5 }, [_]u16{ 6, 10 } };
    try std.testing.expectEqualDeep(try merge(input[0..]), result[0..]);
}

test "case21" {
    var input = [_][2]u16{ [_]u16{ 1, 3 }, [_]u16{ 2, 6 }, [_]u16{ 5, 7 }, [_]u16{ 8, 9 } };
    const result = [_][2]u16{ [_]u16{ 1, 7 }, [_]u16{ 8, 9 } };
    try std.testing.expectEqualDeep(try merge(input[0..]), result[0..]);
}

test "case22" {
    var input = [_][2]u16{ [_]u16{ 0, 1 }, [_]u16{ 1, 2 }, [_]u16{ 3, 4 }, [_]u16{ 4, 5 } };
    const result = [_][2]u16{ [_]u16{ 0, 2 }, [_]u16{ 3, 5 } };
    try std.testing.expectEqualDeep(try merge(input[0..]), result[0..]);
}

test "case23" {
    var input = [_][2]u16{ [_]u16{ 1, 3 }, [_]u16{ 2, 4 }, [_]u16{ 3, 5 }, [_]u16{ 5, 6 }, [_]u16{ 6, 7 } };
    const result = [_][2]u16{[_]u16{ 1, 7 }};
    try std.testing.expectEqualDeep(try merge(input[0..]), result[0..]);
}

test "case24" {
    var input = [_][2]u16{ [_]u16{ 1, 3 }, [_]u16{ 2, 5 }, [_]u16{ 4, 6 }, [_]u16{ 5, 8 } };
    const result = [_][2]u16{[_]u16{ 1, 8 }};
    try std.testing.expectEqualDeep(try merge(input[0..]), result[0..]);
}

test "case25" {
    var input = [_][2]u16{ [_]u16{ 0, 5 }, [_]u16{ 1, 2 }, [_]u16{ 2, 3 }, [_]u16{ 3, 4 }, [_]u16{ 5, 10 } };
    const result = [_][2]u16{[_]u16{ 0, 10 }};
    try std.testing.expectEqualDeep(try merge(input[0..]), result[0..]);
}
