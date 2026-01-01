-- Nova v0.0.7

var_name = nil
var_value = nil
local funcstorage = {}
local varstorage = {}
local arraystorage = {}

local function let(name, value)
    varstorage[name] = value
end

local function out(name)
    if varstorage[name] ~= nil and type(name) == "string" then
        print(varstorage[name])
        return
    end
    if arraystorage[name] then
        print(table_to_string(arraystorage[name]))
        return
    end
    print(name)
end

local function input(name)
    local value = io.read("*line")
    varstorage[name] = value
end

local function equal(name, value)
    return varstorage[name] == value
end

local function notequal(name, value)
    return varstorage[name] ~= value
end

local function greater(name, name2)
    local a = varstorage[name]
    local b = varstorage[name2]
    if a > b then 
        out(a .. " is greater than " .. b) 
    else 
        out(b .. " is greater than " .. a) 
    end
end

local function less(name, name2)
    local a = varstorage[name]
    local b = varstorage[name2]
    if a < b then 
        out(a .. " is less than " .. b) 
    else 
        out(b .. " is less than " .. a) 
    end
end

local function greateroreqt(name, name2)
    local a = varstorage[name]
    local b = varstorage[name2]
    if a >= b then 
        out(a) 
    else 
        out(b) 
    end
end

local function lessoreqt(name, name2)
    local a = varstorage[name]
    local b = varstorage[name2]
    if a <= b then 
        out(a) 
    else 
        out(b) 
    end
end

local function loop(times, event)
    for i = 1, times do
        event()
    end
end

local function while_loop(times, event)
    local counter = 0
    while counter < times do
        event()
        counter = counter + 1
    end
end

local function func(name, fn)
    funcstorage[name] = fn
end

local function call(name, ...)
    if funcstorage[name] then
        return funcstorage[name](...)
    else
        out("error: invalid function: " .. name .. ".")
    end
end

local function ifdo(name, value, then_fn, else_fn)
    if varstorage[name] == value then
        then_fn()
    elseif else_fn then
        else_fn()
    end
end

local function and_op(a, b)
    return a and b
end

local function or_op(a, b)
    return a or b
end

local function not_op(a)
    return not a
end

local function runfile(filename)
    dofile(filename .. ".lua")
end

local function bool(name)
    local value = varstorage[name]
    if value == true then
        out("true")
    else
        out("false")
    end
end

local function array(name, arr)
    arraystorage[name] = arr
end
local function table_to_string(t)
    local items = {}
    for i, v in ipairs(t) do
        items[#items+1] = tostring(v)
    end
    return "[" .. table.concat(items, ", ") .. "]"
end

local function cut(name, index)
    local a = arraystorage[name]
    table.remove(a, index)
end

local function insert(name, pos, value)
    local a = arraystorage[name]
    table.insert(a, pos, value)
end

local function sort(name)
    local a =arraystorage[name]
    table.sort(a)
    if a == nil then
        out("error: array" .. a .. "doesn't exist")
    end
end

local function add(x, y)
    x = varstorage[x] or x
    y = varstorage[y] or y
    return x + y
end

local function sub(x, y)
    x = varstorage[x] or x
    y = varstorage[y] or y
    return x - y
end

local function mul(x, y)
    x = varstorage[x] or x
    y = varstorage[y] or y
    return x * y
end

local function div(x, y)
    x = varstorage[x] or x
    y = varstorage[y] or y
    if y == 0 then
        print("error: division by zero")
        return
    end
    return x / y
end

local function len(inputstring)
    inputstring = varstorage[inputstring] or inputstring
    if type(inputstring) ~= "string" then
        print("error: len() expects type string")
        return
    end
    return string.len(inputstring)
end

local function reverse(inputstring)
    inputstring = varstorage[inputstring] or inputstring
    if type(inputstring) ~= "string" then
        print("error: reverse() expects type string")
        return
    end
    return string.reverse(inputstring)
end

local function upper(inputstring)
    inputstring = varstorage[inputstring] or inputstring
    if type(inputstring) ~= "string" then
        print("error: upper() expects type string")
        return
    end
    return string.upper(inputstring)
end

local function lower(inputstring)
    inputstring = varstorage[inputstring] or inputstring
    if type(inputstring) ~= "string" then
        print("error: lower() expects type string")
        return
    end
    return string.lower(inputstring)
end
