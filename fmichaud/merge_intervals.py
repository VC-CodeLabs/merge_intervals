import heapq

def merge(intervals: list[list[int]]) -> list[list[int]]:
    # min heap - sorted by first element in intervals
    heapq.heapify(intervals)
    res = [] 
    
    if intervals:
        curr = heapq.heappop(intervals)
    else:
        return []

    while intervals:
        next = heapq.heappop(intervals)
        
        if curr[1] >= next[0]:
            curr = [curr[0], max(curr[1], next[1])]
        else:
            res.append(curr)
            curr = next
    
    res.append(curr)

    return res


# Test Cases
test_cases = [
        [[1,3],[2,6],[8,10],[15,18]],
        [[1,4],[4,5]],
        [[1,4],[2,3]],
        [[1,3]],
        [[1,4],[5,6]],
        [[]]
    ]
 

for interval in test_cases:
    print(merge(interval))

