// Copyright (c) 2024 VividCloud.  All rights reserved.

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.Scanner;
import java.util.stream.Collectors;

/**
 * Merge overlapping intervals of positive integers from console input.  Example:
 * Input: intervals = [[1,3],[2,6],[8,10],[15,18]]
 * Output: [[1,6],[8,10],[15,18]]
 * Explanation: Since intervals [1,3] and [2,6] overlap, merge them into [1,6].
 * Expects valid input!!
 *
 * Constraints:
 * intervals[i] = [starti, endi]
 * 1 <= intervals.length <= 10^4
 * intervals[i].length == 2
 * 0 <= starti <= endi <= 10^4
 * The input array is not guaranteed to be sorted
 *
 */
public class MergeIntervals {

    public static void main(String[] args) {

        warmUpJvm();

        String playAgain = "y";

        Scanner scanner = new Scanner(System.in);

        while("y".equalsIgnoreCase(playAgain)) {

            System.out.println("Enter your intervals:");

            String input = scanner.nextLine();

            List<int[]> intervals = convertInputToArrayList(input);

            long start = System.nanoTime();

            List<int[]> mergedIntervals = mergeIntervals(intervals);

            long stop = System.nanoTime();

            String output = mergedIntervals.stream()
                    .map(Arrays::toString)
                    .collect(Collectors.joining(",", "[", "]"));

            NumberFormat nf = NumberFormat.getInstance();
            System.out.println("Merged:");
            System.out.println(output);
            System.out.println("merge time: " + nf.format(stop - start) + " nanos");
            System.out.println();
            System.out.println("play again?");
            playAgain = scanner.nextLine();
        }
        System.out.println("Thanks for playing!");
        System.out.println("Copyright 2024, VividCloud. Smarter software, engineered here.");
    }

    /**
     * Merge all overlapping intervals
     * @param intervals A List of integer arrays of size 2.
     *                  Must be sorted by the first element, then the second element.
     *
     * @return a List of merged, non-overlapping intervals
     */
    public static List<int[]> mergeIntervals(List<int[]> intervals) {

        // first, sort intervals by start number
        intervals.sort(Comparator.comparingInt(a -> a[0]));

        List<int[]> mergedIntervals = new ArrayList<>();

        int[] mergedInterval = intervals.get(0);

        for (int i = 1; i < intervals.size(); i++) {

            int[] thisInterval = intervals.get(i);

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

    /**
     * Convert string input into a List of integer arrays of size 2.
     * @param input Must be formatted like [[1,3],[2,6], ... [n,m]]
     * @return a List of integer arrays.
     */
    public static List<int[]> convertInputToArrayList(String input) {
        List<int[]> parsedList = new ArrayList<>();

        input = input.substring(1, input.length() - 1);

        String[] arrayStrings = input.split("\\],\\[");

        for (String arrayString : arrayStrings) {
            arrayString = arrayString.replaceAll("\\[|\\]", "");

            String[] numberStrings = arrayString.split(",");
            int[] array = new int[numberStrings.length];

            for (int i = 0; i < numberStrings.length; i++) {
                array[i] = Integer.parseInt(numberStrings[i]);
            }

            parsedList.add(array);
        }

        return parsedList;
    }

    private static void warmUpJvm() {
        List<int[]> warmup = convertInputToArrayList("[[1,3],[2,6],[8,10],[15,18],[2,5],[12,16],[0,1]]");
        mergeIntervals(warmup);
    }
}
