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

A_rules, A_updates = split(A, "\n\n")
A_rules = [parse.(Int, rule) for rule in split.(split(A_rules, "\n"), "|")]
A_updates = [parse.(Int, update) for update in split.(split(A_updates, "\n"), ",")]

B_rules, B_updates = split(read("inputs/input5.txt", String), "\n\n")
B_rules = [parse.(Int, rule) for rule in split.(split(B_rules, "\n"), "|")]
B_updates = [parse.(Int, update) for update in split.(split(B_updates, "\n"), ",")]

function test_rule(rule, update)
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
        if all(i->(i==true), [test_rule(rule, update) for rule in rules])
            total_mids = total_mids + update[div(length(update),2)+1]
        end
    end
    return total_mids
end

@show test_all_rules(A_rules, A_updates) # 143
@show test_all_rules(B_rules, B_updates) # 5374      

function test_update(rules, update)
    return all(i->(i==true), [test_rule(rule, update) for rule in rules])
end

function apply_rule(rule, update)
    if test_rule(rule, update)
        return update
    end

    pos_1 = findfirst(==(rule[2]), update)
    pos_2 = findfirst(==(rule[1]), update)

    update[pos_1] = rule[1]
    update[pos_2] = rule[2]

    return update 
end

function apply_all_rules(rules, update)
    while !test_update(rules, update)
        for rule in rules
            update = apply_rule(rule, update)
        end
    end
    return update
end

function get_updated_mids(rules, updates)
    total_mids = 0
    for update in updates
        if !test_update(rules, update)
            fixed_update = apply_all_rules(rules, update)
            @show fixed_update
            total_mids = total_mids + fixed_update[div(length(fixed_update),2)+1]
        end
    end
    return total_mids
end

@show get_updated_mids(A_rules, A_updates) # 123
@show get_updated_mids(B_rules, B_updates) # 4260