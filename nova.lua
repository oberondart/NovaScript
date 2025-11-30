-- Nova v0.0.3

var_name = nil
var_value = nil
local funcstorage = {}
local varstorage = {}

local function let(name, value)
    varstorage[name] = value
end

local function out(name)
    if varstorage[name] ~= nil then
        print(varstorage[name])
    else
        print(name)
    end
end

local function equal(name, value)
    return varstorage[name] == value
end

local function notequal(name, value)
    return varstorage[name] ~= value
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

local function define(name, func)
    funcstorage[name] = func
end

local function call(name)
    if funcstorage[name] then
        funcstorage[name]()
    else
        out("error: invalid function: " .. name .."")
    end
end

local function ifclause(varname, value)
    if varstorage[varname] == value then
        out("true")
    else
        out("false")
    end
end
