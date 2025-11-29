-- Nova v0.1

var_name = nil
var_value = nil

local function out(input)
    if var_name == input then
        print(var_value)
    else
        print(input)
    end
end

local function let(name, value)
    var_name = name
    var_value = value
end

local function equal(name, value)
    return var_name == name and var_value == value
end

local function notequal(name, value)
    return var_name ~= name and var_value ~= value
end

let(myvar, 10)
out(myvar)
out("hello, world!")

if equal(myvar, 10) then out(myvar) end
if notequal(myvar, 20) then out(myvar) end