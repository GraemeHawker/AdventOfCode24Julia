using DelimitedFiles

A = readdlm("inputs/input2_example.txt")
B = readdlm("inputs/input2.txt") # creates a 2D array; input rows are different lengths so shorter rows will contain empty strings to fill

function test_safe(a)
    filtered_array = filter((i) -> i != "", a) # removes empty strings
    diffs = [t - s for (s, t) in zip(filtered_array, filtered_array[2:end])]
    if (all(>(0), diffs) || all(<(0), diffs))
        if all(<=(3), [abs(i) for i in diffs])
            return true
        end
    end
    return false
end

function test_really_safe(a)
    filtered_array = filter((i) -> i != "", a) # removes empty strings
    for i in 1:length(filtered_array)
        if test_safe(deleteat!(copy(filtered_array),i))
            return true
        end
    end
    return false
end

@show sum(mapslices(test_safe, A, dims=2)) #2
@show sum(mapslices(test_safe, B, dims=2)) #407
@show sum(mapslices(test_really_safe, A, dims=2)) #4
@show sum(mapslices(test_really_safe, B, dims=2)) #459