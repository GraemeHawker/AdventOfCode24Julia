function parse_input(input)
    data = split.(split(rstrip(input), '\n'), ':')
    test_values = [parse(Int, x[1]) for x ∈ data]
    numbers = [parse.(Int, split(lstrip(x[2]))) for x ∈ data]
    return test_values, numbers
end

function get_permutations(numbers)
    if length(numbers) > 2
        tail_permutations = get_permutations(numbers[1:end-1])
        return [[numbers[end]+i for i in tail_permutations]; [numbers[end]*i for i in tail_permutations]]
    end
    return [numbers[1]+numbers[2], numbers[1]*numbers[2]]
end

function check_solve(test_values, numbers)
    test_total = 0
    for (test_value, cur_numbers) in zip(test_values, numbers)
        if test_value ∈ get_permutations(cur_numbers)
            test_total += test_value
        end
    end
    return test_total
end

@show get_permutations([3,4,5])
@show test_values, numbers = parse_input(read("inputs/input7_example.txt", String))
@show check_solve(test_values, numbers)

@show test_values, numbers = parse_input(read("inputs/input7.txt", String))
@show check_solve(test_values, numbers)

function get_extra_permutations(numbers)
    if length(numbers) > 2
        tail_permutations = get_extra_permutations(numbers[1:end-1])
        return [[numbers[end]+i for i in tail_permutations]; [numbers[end]*i for i in tail_permutations]; [parse(Int, string(i, numbers[end])) for i in tail_permutations]]
    end
    return [numbers[1]+numbers[2], numbers[1]*numbers[2], parse(Int, string(numbers[1], numbers[2]))]
end

function check_extra_solve(test_values, numbers)
    test_total = 0
    for (test_value, cur_numbers) in zip(test_values, numbers)
        if test_value ∈ get_extra_permutations(cur_numbers)
            test_total += test_value
        end
    end
    return test_total
end

@show get_extra_permutations([3,4,5])
@show test_values, numbers = parse_input(read("inputs/input7_example.txt", String))
@show check_extra_solve(test_values, numbers)

@show test_values, numbers = parse_input(read("inputs/input7.txt", String))
@show check_extra_solve(test_values, numbers)