
def main():

    input_intervals = [[1, 3], [2, 6], [8, 10], [15, 18]]

    output = merge(input_intervals)

    print(f"Input:  {input_intervals}")
    print(f"Output: {output}")


def merge(intervals: list[list[int]]) -> list[list[int]]:
    intervals.sort(key=lambda x: x[0])
    merged = []
    current = intervals[0]
    for i in intervals[1:]:
        # check if next interval i is contained in the current working interval
        if i[0] <= current[1] and i[1] <= current[1]:
            pass
        # check to see if next interval i should be merged with the current interval
        elif i[0] <= current[1]:
            current = [current[0], i[1]]
        # else it can't be merged. append the current interval to the answer list and make i the new current
        else:
            merged.append(current)
            current = i
    merged.append(current)
    return merged


if __name__ == "__main__":
    main()
