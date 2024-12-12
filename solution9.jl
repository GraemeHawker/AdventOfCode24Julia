using IterTools

function dense_to_map(dense)
    data_map = []
    int_dense = [parse(Int,i) for i in collect(string(dense))]
    for i in eachindex(int_dense)
        if i % 2 == 1
            append!(data_map, repeat([(i-1)÷2], int_dense[i]))
        else
            append!(data_map, repeat(['.'], int_dense[i]))
        end
    end
    return data_map
end

function check_complete(data_map)
    return findfirst(==('.'), data_map) == length(data_map) - count(==('.'),data_map) + 1
end

function defrag(data_map)
    while !check_complete(data_map)
        data_map[findfirst(==('.'),data_map)] = data_map[findlast(!=('.'), data_map)]
        data_map[findlast(!=('.'), data_map)] = '.'
        #display(String(data_map))
    end
    return data_map
end

function get_checksum(data_map)
    total = 0
    for i in 1:findlast(!=('.'), data_map)
        total += (i-1)*data_map[i]
    end
    return total
end

@show data_map = dense_to_map("2333133121414131402")
@show defrag_map = defrag(data_map)
@show checksum = get_checksum(defrag_map)

data_map = dense_to_map(read("inputs/input9.txt", String))
defrag_map = defrag(data_map)
@show checksum = get_checksum(defrag_map)

#data_map = dense_to_map("11111911111")
#defrag_map = String(defrag(collect(data_map)))
#@show checksum = get_checksum(defrag_map)

