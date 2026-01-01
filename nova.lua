-- Nova v0.0.7 (module)

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
    if varstorage[name] ~= nil and type(name) == "string" then
        print(varstorage[name])
        return
    end
    if arraystorage[name] then
        print(Nova.table_to_string(arraystorage[name]))
        return
    end
    print(name)
end

function Nova.table_to_string(t)
    local items = {}
    for i, v in ipairs(t) do
        items[#items+1] = tostring(v)
    end
    return "[" .. table.concat(items, ", ") .. "]"
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

function Nova.ifdo(name, value, then_fn, else_fn)
    if varstorage[name] == value then
        then_fn()
    elseif else_fn then
        else_fn()
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

function Nova.add(x, y)
    x = varstorage[x] or x
    y = varstorage[y] or y
    return x + y
end

function Nova.sub(x, y)
    x = varstorage[x] or x
    y = varstorage[y] or y
    return x - y
end

function Nova.mul(x, y)
    x = varstorage[x] or x
    y = varstorage[y] or y
    return x * y
end

function Nova.div(x, y)
    x = varstorage[x] or x
    y = varstorage[y] or y
    if y == 0 then
        print("error: division by zero")
        return
    end
    return x / y
end

function Nova.len(inputstring)
    inputstring = varstorage[inputstring] or inputstring
    if type(inputstring) ~= "string" then
        print("error: len() expects type string")
        return
    end
    return string.len(inputstring)
end

function Nova.reverse(inputstring)
    inputstring = varstorage[inputstring] or inputstring
    if type(inputstring) ~= "string" then
        print("error: reverse() expects type string")
        return
    end
    return string.reverse(inputstring)
end

function Nova.upper(inputstring)
    inputstring = varstorage[inputstring] or inputstring
    if type(inputstring) ~= "string" then
        print("error: upper() expects type string")
        return
    end
    return string.upper(inputstring)
end

function Nova.lower(inputstring)
    inputstring = varstorage[inputstring] or inputstring
    if type(inputstring) ~= "string" then
        print("error: lower() expects type string")
        return
    end
    return string.lower(inputstring)
end

return Nova
