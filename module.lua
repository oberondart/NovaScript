-- Nova v0.0.6 (module)

local Nova = {}

Nova.var_name = nil
Nova.var_value = nil
local funcstorage = {}
local varstorage = {}
local arraystorage = {}

function Nova.let(name, value)
    varstorage[name] = value
end

function Nova.out(name)
    if varstorage[name] ~= nil then
        print(varstorage[name])
    else
        print(name)
    end
    if arraystorage[name] ~= nil then
        print(arraystorage[name])
    else
        print(name)
    end
end

function Nova.input(name)
    local value = io.read("*line")
    varstorage[name] = value
end

function Nova.equal(name, value)
    return varstorage[name] == value
end

function Nova.notequal(name, value)
    return varstorage[name] ~= value
end

function Nova.greater(name, name2)
    local a = varstorage[name]
    local b = varstorage[name2]
    if a > b then 
        Nova.out(a .. " is greater than " .. b) 
    else 
        Nova.out(b .. " is greater than " .. a) 
    end
end

function Nova.less(name, name2)
    local a = varstorage[name]
    local b = varstorage[name2]
    if a < b then 
        Nova.out(a .. " is less than " .. b) 
    else 
        Nova.out(b .. " is less than " .. a) 
    end
end

function Nova.greateroreqt(name, name2)
    local a = varstorage[name]
    local b = varstorage[name2]
    if a >= b then 
        Nova.out(a) 
    else 
        Nova.out(b) 
    end
end

function Nova.lessoreqt(name, name2)
    local a = varstorage[name]
    local b = varstorage[name2]
    if a <= b then 
        Nova.out(a) 
    else 
        Nova.out(b) 
    end
end

function Nova.incr(name, amount, times)
    amount = amount or 1       -- default increment is 1
    times = times or 1         -- default times is 1
    local counter = 0
    while counter < times do
        varstorage[name] = (varstorage[name] or 0) + amount
        counter = counter + 1
    end
end

function Nova.loop(times, event)
    for i = 1, times do
        event()
    end
end

function Nova.while_loop(times, event)
    local counter = 0
    while counter < times do
        event()
        counter = counter + 1
    end
end

function Nova.func(name, fn)
    funcstorage[name] = fn
end

function Nova.call(name, ...)
    if funcstorage[name] then
        return funcstorage[name](...)
    else
        Nova.out("error: invalid function: " .. name .. ".")
    end
end

function Nova.ifclause(varname, value, statement, elseclause)
    if varstorage[varname] == value then
        Nova.out(statement)
    else
        Nova.out(elseclause)
    end
end

function Nova.and_op(a, b)
    return a and b
end

function Nova.or_op(a, b)
    return a or b
end

function Nova.not_op(a)
    return not a
end

function Nova.runfile(filename)
    dofile(filename .. ".lua")
end

function Nova.bool(name)
    local value = varstorage[name]
    if value == true then
        Nova.out("true")
    else
        Nova.out("false")
    end
end

function Nova.array(name, arr)
    arraystorage[name] = arr
end

function Nova.cut(name, index)
    local a = arraystorage[name]
    if not a then
        Nova.out("error: array " .. name .. " doesn't exist")
        return
    end
    table.remove(a, index)
end

function Nova.insert(name, pos, value)
    local a = arraystorage[name]
    if not a then
        Nova.out("error: array " .. name .. " doesn't exist")
        return 
    end
    table.insert(a, pos, value)
end

function Nova.sort(name)
    local a = arraystorage[name]
    if not a then
        Nova.out("error: array " .. name .. " doesn't exist")
        return
    end
    table.sort(a)
end

function Nova.arraylength(name)
    local a = arraystorage[name]
    if not a then
        Nova.out("error: array " .. name .. " doesn't exist")
        return
    end
    Nova.out(#a)
end

return Nova
