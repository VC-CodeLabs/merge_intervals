const std = @import("std");
const print = std.debug.print;
const ArrayList = std.ArrayList;

pub fn main() !void {
    const start_time = std.time.nanoTimestamp();

    // var input = [_][2]u16{ [_]u16{ 1, 3 }, [_]u16{ 2, 6 }, [_]u16{ 8, 10 }, [_]u16{ 15, 18 } };
    var input = [_][2]u16{ [_]u16{ 15, 18 }, [_]u16{ 8, 10 }, [_]u16{ 2, 6 }, [_]u16{ 1, 3 } };
    try merge(input[0..]);

    const end_time = std.time.nanoTimestamp();
    print("Time: {} ns\n", .{end_time - start_time});
}

fn merge(input: [][2]u16) !void {
    // std.sort.block([2]u16, input[0..], {}, cmpByValue);
    std.sort.heap([2]u16, input[0..], {}, cmpByValue);
    // std.sort.insertion([2]u16, input[0..], {}, cmpByValue);
    // std.sort.pdq([2]u16, input[0..], {}, cmpByValue);

    // var buffer: [1000]u8 = undefined;
    // var fba = std.heap.FixedBufferAllocator.init(&buffer);
    // const allocator = fba.allocator();

    const allocator = std.heap.page_allocator;

    var result = ArrayList([2]u16).init(allocator);
    defer result.deinit();

    var i: usize = 0;
    while (i < input.len) {
        if (i == input.len - 1) {
            try result.append(input[i]);
            break;
        } else if (input[i][1] > input[i + 1][0]) {
            try result.append([_]u16{ input[i][0], input[i + 1][1] });
            i += 2;
        } else {
            try result.append(input[i]);
            i += 1;
        }
    }

    print("{any}\n", .{result.items});
}

fn cmpByValue(context: void, a: [2]u16, b: [2]u16) bool {
    return std.sort.asc(u16)(context, a[0], b[0]);
}
