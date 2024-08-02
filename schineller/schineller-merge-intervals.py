from typing import List

# To run, pass the intervals list into Solution().merge(intervals)

class Solution:
    def sorter(self, ival: List[int]):
        return ival[0]
    def merge(self, intervals: List[List[int]]) -> List[List[int]]:
        intervals.sort(key=self.sorter)
        # reverse loop intervals
        for i in range(len(intervals)-1, -1, -1):
            ivalStart = intervals[i][0]
            ivalEnd = intervals[i][1]
            k = i+1
            # while k is in bounds and the interval start at k is less than current interval end
            while len(intervals) > k and intervals[k][0] <= ivalEnd:
                if (intervals[k][0] <= ivalEnd):
                    if (ivalEnd <= intervals[k][1]):
                        # large k end, set current ivalEnd to k end, then remove k
                        ivalEnd = intervals[k][1]
                        intervals.pop(k)
                    elif (ivalEnd > intervals[k][1]):
                        # this ivalEnd is greater than k end so remove k
                        intervals.pop(k)
                else:
                    # if the start of k is greater, then go next
                    k += 1
            intervals[i] = [ivalStart, ivalEnd]
        return intervals


# intervals = [[1, 3], [2, 6], [8, 10], [15, 18]]
# solution = Solution()
# merged_intervals = solution.merge(intervals)
# print(merged_intervals)