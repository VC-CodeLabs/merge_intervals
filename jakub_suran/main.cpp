#include <vector>
#include <algorithm>
#include <cstdio>

using namespace std;

vector<vector<int>> merge(vector<vector<int>>& intervals) {
    if (intervals.size() <= 0)
        return {};
    
    sort(intervals.begin(), intervals.end());

    vector<vector<int>> result;
    result.push_back(intervals[0]);

    for (int i = 1; i < intervals.size(); i++) {
        if (result.back()[1] < intervals[i][0])
            result.push_back(intervals[i]);
        else
            result.back()[1] = result.back()[1] > intervals[i][1] ? result.back()[1] : intervals[i][1];
    }
    return result;
}

int main() {
    vector<vector<int>> intervals = {{1, 3}, {2, 6}, {8, 10}, {15, 18}};
    
    vector<vector<int>> mergedIntervals = merge(intervals);
    
    for (const auto& interval : mergedIntervals) {
        printf("[%d, %d] ", interval[0], interval[1]);
    }
    
    return 0;
}