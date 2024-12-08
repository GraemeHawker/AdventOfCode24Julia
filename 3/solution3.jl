A = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
B = read("3/input3.txt", String)
C = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

function do_muls(a)
    re = r"mul\((?<first>[0-9]{1,3}),(?<second>[0-9]{1,3})\)"
    total = 0
    for hit in findall(re, a)
        m = match(re, a[hit])
        total = total + parse(Int, m[:first]) * parse(Int, m[:second])
    end
    return total
end

@show do_muls(A) #161
@show do_muls(B) #164730528

# determine whether muls are enabled at index i of string a
function get_enabled_state(a, pos)
    enables = [[0];[y for (x,y) in findall(r"do\(\)", a)]] # list of indices at which mul statements are enabled; include 0-index to default to enabled
    disables = [y for (x,y) in findall(r"don't\(\)", a)] # list of indices at which mul statements are disabled
    # @show enables, disables
    prev_enables = filter((i) -> i <= pos, enables) # list of indices at which mul statements are enabled up to index pos
    prev_disables = filter((i) -> i <= pos, disables) # list of indices at which mul statements are disabled up to index pos
    if length(prev_disables) == 0 # if no disables prior to index, muls are enabled
        return true
    end
    if last(prev_enables) > last(prev_disables) # if there are disables but there is a more recent enable, muls are enabled
        return true
    end
    return false # otherwise most recent state change is to disable; muls are disabled
end

# extend do_muls to check if muls are disabled or not
function do_enabled_muls(a)
    re = r"mul\((?<first>[0-9]{1,3}),(?<second>[0-9]{1,3})\)"
    total = 0
    for hit in findall(re, a)
        m = match(re, a[hit])
        if get_enabled_state(a, first(hit))
            total = total + parse(Int, m[:first]) * parse(Int, m[:second])
        end
    end
    return total
end

@show do_enabled_muls(C) #48
@show do_enabled_muls(B) #70478672