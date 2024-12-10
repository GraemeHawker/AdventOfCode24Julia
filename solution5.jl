function parse_input(input)
    rules, updates = split(input, "\n\n")
    rules = [parse.(Int, rule) for rule in split.(split(rules, "\n"), "|")]
    updates = [parse.(Int, update) for update in split.(split(updates, "\n"), ",")]
    return rules, updates
end

A_rules, A_updates = parse_input(read("inputs/input5_example.txt", String))
B_rules, B_updates = parse_input(read("inputs/input5.txt", String))

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

@show get_updated_mids(A_rules, A_updates) 
@show get_updated_mids(B_rules, B_updates) 