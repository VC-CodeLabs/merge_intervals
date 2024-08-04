"""
    T Washington
    Merge Intervals
    Do not score this. Score the julia program.
"""
import time


def merge_interval_list(intervals):
    ins = intervals.copy()
    for a in range(len(ins)):
        for b in range(a + 1, len(ins)):
            if not (ins[a] is None or ins[b] is None) and not (ins[a][1] < ins[b][0] or ins[b][1] < ins[a][0]):
                ins[b] = [min(ins[a][0], ins[b][0]), max(ins[a][1], ins[b][1])]
                ins[a] = None
    # time.sleep(0.1)
    return [c for c in ins if c is not None]


def get_input_list(filename):
    intervals_list = []

    with open(filename, 'r') as file:
        for line in file:
            # Strip whitespace and newlines, and evaluate the string as a Python expression
            stripped_line = line.strip()
            if stripped_line:  # Check if line is not empty
                intervals = eval(stripped_line)
                intervals_list.append(intervals)

    return intervals_list


def main():
    input_list_list = get_input_list("intervals.txt")
    for input_list in input_list_list:
        start = time.perf_counter_ns()
        output_list = sorted(merge_interval_list(input_list), key=lambda x: x[0])
        end = time.perf_counter_ns()
        print(f"Input: {input_list}, output: {output_list}")
        print(f"Time taken: {(end - start):.4f} ns")


if __name__ == "__main__":
    main()
