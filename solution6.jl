using ProgressBars

function parse_input(input)
    return permutedims(hcat(collect.(split(input, "\n"))...))
end

function rotate_direction(x)
    x == CartesianIndex(-1,0) && return CartesianIndex(0,1)
    x == CartesianIndex(0,1) && return CartesianIndex(1,0)
    x == CartesianIndex(1,0) && return CartesianIndex(0,-1)
    x == CartesianIndex(0,-1) && return CartesianIndex(-1,0)
end

function check_inbounds(grid, x)
    try
        new_pos = grid[x]
    catch e
        return false
    end
    return true
end

function check_obstacle(grid, x)
    return grid[x] == '#'
end

function run_simulation(grid)
    cur_pos = findfirst(==('^'), grid)
    grid[cur_pos] = 'X'
    cur_dir = CartesianIndex(-1,0)
        
    while check_inbounds(grid, cur_pos + cur_dir)
        while check_obstacle(grid, cur_pos + cur_dir)
            cur_dir = rotate_direction(cur_dir)
        end
        cur_pos = cur_pos + cur_dir
        grid[cur_pos] = 'X'
    end

    return count(==('X'), grid)
end

grid_A = parse_input(read("inputs/input6_example.txt", String))
@show run_simulation(grid_A)

grid_B = parse_input(read("inputs/input6.txt", String))
@show run_simulation(grid_B)

function checksum(pos, dir)
    return join([String(x) for x in [pos[1],',',pos[2],',',dir[1],',',dir[2]]])
end

function run_blocking_simulation(grid, block_pos)
    cur_pos = findfirst(==('^'), grid)
    if !(cur_pos == block_pos)
        grid[block_pos] = '#'
    end
    cur_dir = CartesianIndex(-1,0)
    prev_states = [[cur_pos, cur_dir]] 
    while check_inbounds(grid, cur_pos + cur_dir)
        while check_obstacle(grid, cur_pos + cur_dir)
            cur_dir = rotate_direction(cur_dir)
        end
        cur_pos = cur_pos + cur_dir
        if [cur_pos, cur_dir] in prev_states
            return true
        end
        push!(prev_states, [cur_pos, cur_dir])
    end
    return false
end

function run_all_blocks(grid)
    return count([run_blocking_simulation(copy(grid), block_pos) for block_pos in ProgressBar(CartesianIndices(grid))])
end

grid_A = parse_input(read("inputs/input6_example.txt", String))
@show run_all_blocks(grid_A)

grid_B = parse_input(read("inputs/input6.txt", String))
@show run_all_blocks(grid_B)