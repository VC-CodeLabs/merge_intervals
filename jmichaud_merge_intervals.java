// Copyright (c) 2024 VividCloud.  All rights reserved.

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;

public class MergeIntervals {

    public static void main(String[] args) {
        
        int[][] inputArray = {
                {1, 3},
                {2, 6},
                {8, 10},
                {15, 18},
                {2, 5},
                {12, 16},
                {11, 11},
                {17, 17},
                {0, 1}
        };

        Arrays.sort(inputArray, Comparator.comparingInt(a -> a[0]));

        List<int[]> mergedIntervals = mergeIntervals(inputArray);

        System.out.println(formatList(mergedIntervals));
    }

    public static List<int[]> mergeIntervals(int[][] intervals) {

        List<int[]> mergedIntervals = new ArrayList<>();

        int[] mergedInterval = intervals[0];

        for (int i = 1; i < intervals.length; i++) {

            int[] thisInterval = intervals[i];

            if (thisInterval[0] <= mergedInterval[1]) {
                // thisInterval starts inside the mergedInterval

                if (thisInterval[1] > mergedInterval[1]) {
                    // thisInterval stops after the mergedInterval, expand mergedInterval
                    mergedInterval[1] = thisInterval[1];
                }
                // otherwise, thisInterval is fully contained within mergedInterval, ignore it.

            } else {
                // thisInterval starts after the end of the mergedInterval,
                // so we are done creating mergedInterval. Save it and start fresh with thisInterval.
                mergedIntervals.add(mergedInterval);
                mergedInterval = thisInterval;
            }
        }
        // add the last mergedInterval
        mergedIntervals.add(mergedInterval);
        return mergedIntervals;
    }

    private static String formatList(List<int[]> list) {
        StringBuilder sb = new StringBuilder();
        sb.append("[");
        for (int i = 0; i < list.size(); i++) {
            int[] interval = list.get(i);
            sb.append("[");
            sb.append(interval[0]);
            sb.append(",");
            sb.append(interval[1]);
            sb.append("]");
            if (i < list.size() - 1) {
                sb.append(",");
            }
        }
        sb.append("]");
        return sb.toString();
    }
}
