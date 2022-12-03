local calc, biggest = 0, {}
local elve_num, filename = tonumber(arg[1]), arg[2]

for line in io.lines(filename) do
    local num = tonumber(line)
    if num == nil then
        local entry_count = #biggest
        if entry_count < elve_num then
            biggest[entry_count + 1] = calc
        else
            table.sort(biggest)
            if biggest[1] < calc then biggest[1] = calc end
        end
        calc = 0
    else
        calc = calc + tonumber(num)
    end
end

local sum = 0
for k, v in pairs(biggest) do
    print(v)
    sum = sum + v
end

print(sum)
