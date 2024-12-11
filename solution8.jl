using Combinatorics

function parse_input(input)
    return permutedims(hcat(collect.(split(input, "\n"))...))
end

function calculate_pos(grid)
    return [[findall(==(antenna), grid_A)] for antenna in filter(!=('.'), Set(grid_A))]
end

function calculate_antipodes(grid)
    antipodes = Set()
    antennae = [findall(==(antenna), grid) for antenna in filter(!=('.'), Set(grid))]
    for antenna in antennae
        for (x,y) in combinations(antenna, 2)
            push!(antipodes, x+(x-y), y-(x-y))
        end
    end
    return filter(x->x.I[1]>0 && x.I[1]<=size(grid)[1] && x.I[2]>0 && x.I[2]<=size(grid)[2], antipodes)
end

grid_A = parse_input(read("inputs/input8_example.txt", String))
display(grid_A)
display(calculate_antipodes(grid_A))

grid_B = parse_input(read("inputs/input8.txt", String))
display(grid_B)
display(calculate_antipodes(grid_B))

function is_inbounds(grid, pos)
    return pos.I[1]>0 && pos.I[1]<=size(grid)[1] && pos.I[2]>0 && pos.I[2]<=size(grid)[2]
end

function calculate_extra_antipodes(grid)
    antipodes = Set()
    antennae = [findall(==(antenna), grid) for antenna in filter(!=('.'), Set(grid))]
    for antenna in antennae
        for (x,y) in combinations(antenna, 2)
            delta = x-y
            cur_pos = x
            while is_inbounds(grid, cur_pos)
                push!(antipodes, cur_pos)
                cur_pos += delta
            end
            cur_pos = y
            while is_inbounds(grid, cur_pos)
                push!(antipodes, cur_pos)
                cur_pos -= delta
            end
        end
    end
    return antipodes
end

grid_A = parse_input(read("inputs/input8_example.txt", String))
display(grid_A)
display(calculate_extra_antipodes(grid_A))

grid_B = parse_input(read("inputs/input8.txt", String))
display(grid_B)
display(calculate_extra_antipodes(grid_B))