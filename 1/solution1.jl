using DelimitedFiles

A = [3,4,2,1,3,3]
B = [4,3,5,3,9,3]
C,D = readdlm("1/input1.txt") |> x -> (x[:, 1], x[:, 2])

function sum_distances(A,B)
    pairs = zip(sort(A),sort(B))
    sum_of_distances = 0
    for (x,y) in pairs
        sum_of_distances = sum_of_distances + abs(x-y)
    end
    return sum_of_distances
end

function get_similarity(A,B)
    similarity = 0
    for i in A
        similarity = similarity + count(x->(x==i), B)*i
    end
    return similarity
end

@show sum_distances(A,B) #11
@show sum_distances(C,D) #2285373
@show get_similarity(A,B) #31
@show get_similarity(C,D) #211426537