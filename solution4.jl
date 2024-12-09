A = ["MMMSXXMASM",
"MSAMXMSMSA",
"AMXSXMAAMM",
"MSAMASMSMX",
"XMASAMXAMM",
"XXAMMXXAMA",
"SMSMSASXSS",
"SAXAMASAAA",
"MAMMMXMMMM",
"MXMXAXMASX"]

grid_A = [split(a,"") for a in A]

B = split(read("inputs/input4.txt", String), '\n')
grid_B = [split(b,"") for b in B] 

function get_substring_locs(x, y, x_max, y_max)
    combined_substring_locs = []
    directions = vcat(collect(Iterators.product(-1:1, -1:1))...) # array of cardinal direction vectors, clockwise from north-west (includes zero vector)
    for direction in directions
        substring_locs = []
        for distance in 1:3 # add locations up to 3 distant in given direction
            append!(substring_locs, [[x+distance*first(direction), y+distance*last(direction)]])
        end
        if all(>(0), getindex.(substring_locs,1)) && all(<=(x_max), getindex.(substring_locs,1)) && all(>(0), getindex.(substring_locs,2)) && all(<=(y_max), getindex.(substring_locs,2))  # check for any indices outside bounds of grid
            append!(combined_substring_locs, [substring_locs]) # only include if all indices within grid
        end
    end
    return combined_substring_locs
end

function get_substrings(grid, x, y)
    substring_locs = get_substring_locs(x, y, length(grid[1]), length(grid))
    substrings = []
    for substring_loc in substring_locs
        string = [grid[x][y]] # initialise with letter at starting point
        for char_loc in substring_loc
            push!(string, grid[char_loc[1]][char_loc[2]])
        end
        append!(substrings, [string])
    end
    return substrings
end

function count_substring_matches(grid, word)
    match_count = 0
    for x in 1:length(grid[1])
        for y in 1:length(grid)
            substrings = get_substrings(grid, x, y)
            match_count = match_count + count(i->(i==split(word,"")), substrings)
        end
    end
    return match_count
end

@show count_substring_matches(grid_A, "XMAS") # 18
@show count_substring_matches(grid_B, "XMAS") # 2551