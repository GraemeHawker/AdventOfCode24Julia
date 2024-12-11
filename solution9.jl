using IterTools

function dense_to_map(dense)
    id = 0
    data_map = ""
    for x in partition(collect(string(dense))[1:end-1],2)
        data_map = data_map*string(id)^parse(Int,x[1])
        data_map = data_map*"."^parse(Int,x[2])
        id += 1
    end
    data_map = data_map * string(id) ^ parse(Int,collect(string(dense))[end])
    return data_map
end

function check_complete(data_map)
    return findfirst(==('.'), data_map) == length(data_map) - count(==('.'),collect(data_map)) + 1
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
        total += (i-1)*parse(Int, data_map[i])
    end
    return total
end

data_map = dense_to_map("2333133121414131402")
defrag_map = String(defrag(collect(data_map)))
@show checksum = get_checksum(defrag_map)

#data_map = dense_to_map(read("inputs/input9.txt", String))
#defrag_map = String(defrag(collect(data_map)))
#@show checksum = get_checksum(defrag_map)

data_map = dense_to_map("11111911111")
defrag_map = String(defrag(collect(data_map)))
@show checksum = get_checksum(defrag_map)

