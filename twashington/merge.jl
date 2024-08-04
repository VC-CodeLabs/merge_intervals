#=
  T Washington
  Merged Intervals Julia
  Score this program, not the python one.
=#

debug = false

function get_intervals(filename::String)::Vector{Vector{Vector{Int}}}
    intervals_list = Vector{Vector{Vector{Int}}}()
    open(filename, "r") do file
        for line in eachline(file)
            stripped_line = replace(strip(line, ['[', ']']), " " => "")
            interval_strings = split(stripped_line, "],[")
            intervals = [parse.(Int, split(interval_str, ',')) for interval_str in interval_strings]
            
            push!(intervals_list, intervals)
        end
    end
    return intervals_list
end

function intervals_intersect(a::Vector{Int}, b::Vector{Int})::Bool
    if a == [] || b == []
        return false
    else
        return !( a[2] < b[1] || b[2] < a[1])
    end
end


function merge_these_two_intervals(a::Vector{Int}, b::Vector{Int})::Vector{Int}
    return [min(a[1], b[1]), max(a[2], b[2])]
end


"""
    merge_intervals(intervals::Vector{Vector{Int}})::Vector{Vector{Int}}

TBW
"""
function merge_intervals(intervals::Vector{Vector{Int}})::Vector{Vector{Int}}
    merged_intervals = copy(intervals)
    
    for i in eachindex(merged_intervals)
        for j in (i+1):(length(merged_intervals))
            if intervals_intersect(merged_intervals[i], merged_intervals[j])
                if debug
                    println("Intervals intersect: $(merged_intervals[i]), $(merged_intervals[j]); merged = $(merge_these_two_intervals(merged_intervals[i], merged_intervals[j]))")
                    println("Merged: $([x for x in merged_intervals if x != []])")
                end
                merged_intervals[j] = merge_these_two_intervals(merged_intervals[i], merged_intervals[j])
                merged_intervals[i] = []
            end
        end
    end

    return [x for x in merged_intervals if x != []]
end
# warm up
merge_intervals([[1, 2], [9, 10], [-100, -50], [2, 2], [-6, 0], [3, 4], [20, 30]])


filename = "intervals.txt"
intervals_list = get_intervals(filename)
# intervals_list = [intervals_list[1]]
for intervals in intervals_list
    
    elapsed_time = @elapsed merged_intervals = merge_intervals(intervals)
    elapsed_ms = round(elapsed_time * 1000, sigdigits=3)
    println("Input: intervals = $intervals")
    println("Output: $merged_intervals")
    println("Elapsed time: $elapsed_ms ms")
    # println("The merged intervals of $intervals is: $merged_intervals.  Took $elapsed_ms ms.")
end
