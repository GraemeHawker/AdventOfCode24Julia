A = "47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47"

A_rules = [split(i, '|') for i in split(split(A, "\n\n")[1], '\n')]
A_updates = [split(i, ',') for i in split(split(A, "\n\n")[2], '\n')]

B = read("5/input5.txt", String)
B_rules = [split(i, '|') for i in split(split(B, "\n\n")[1], '\n')]
B_updates = [split(i, ',') for i in split(split(B, "\n\n")[2], '\n')][1:end-1]

function test_rule(rule, update)
    #@show rule, update
    if rule[1] in update && rule[2] in update
        if findfirst(x -> x==rule[1], update) > findfirst(x -> x==rule[2], update)
            return false
        end
    end
    return true
end

function test_all_rules(rules, updates)
    total_mids = 0
    for update in updates
        @show update
        if all(i->(i==true), [test_rule(rule, update) for rule in rules])
            total_mids = total_mids + parse(Int, update[div(length(update),2)+1])
        end
    end
    return total_mids
end

@show test_all_rules(A_rules, A_updates)
@show test_all_rules(B_rules, B_updates)      


