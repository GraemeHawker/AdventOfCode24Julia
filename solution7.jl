#=
190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20
=#

function parse_input(input)
    data = split.(split(rstrip(input), '\n'), ':')
    test_values = [parse(Int, x[1]) for x ∈ data]
    numbers = [parse.(Int, split(lstrip(x[2]))) for x ∈ data]
    return test_values, numbers
end

@show test_values, numbers = parse_input(read("inputs/input7_example.txt", String))

function check_solve(test_value, numbers)

end

@show check_solve(test_values[1], numbers[1])