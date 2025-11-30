-- Nova v0.0.5
local Nova = {}

-- Storage tables
Nova.varstorage = {}
Nova.funcstorage = {}

-- Variable assignment
function Nova.let(name, value)
    Nova.varstorage[name] = value
end

-- Output
function Nova.out(name)
    if Nova.varstorage[name] ~= nil then
        print(Nova.varstorage[name])
    else
        print(name)
    end
end

-- Input from user
function Nova.input(name)
    local value = io.read("*line")
    Nova.varstorage[name] = value
end

-- Comparisons
function Nova.equal(name, value)
    return Nova.varstorage[name] == value
end

function Nova.notequal(name, value)
    return Nova.varstorage[name] ~= value
end

function Nova.greater(name1, name2)
    local a = Nova.varstorage[name1]
    local b = Nova.varstorage[name2]
    if a > b then
        Nova.out(a .. " is greater than " .. b)
    else
        Nova.out(b .. " is greater than " .. a)
    end
end

function Nova.less(name1, name2)
    local a = Nova.varstorage[name1]
    local b = Nova.varstorage[name2]
    if a < b then
        Nova.out(a .. " is less than " .. b)
    else
        Nova.out(b .. " is less than " .. a)
    end
end

function Nova.greateroreqt(name1, name2)
    local a = Nova.varstorage[name1]
    local b = Nova.varstorage[name2]
    if a >= b then Nova.out(a) else Nova.out(b) end
end

function Nova.lessoreqt(name1, name2)
    local a = Nova.varstorage[name1]
    local b = Nova.varstorage[name2]
    if a <= b then Nova.out(a) else Nova.out(b) end
end

-- Loops
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

-- Functions
function Nova.func(name, fn)
    Nova.funcstorage[name] = fn
end

function Nova.call(name, ...)
    if Nova.funcstorage[name] then
        return Nova.funcstorage[name](...)
    else
        Nova.out("error: invalid function: " .. name .. ".")
    end
end

-- If clause
function Nova.ifclause(varname, value, statement, elseclause)
    if Nova.varstorage[varname] == value then
        Nova.out(statement)
    else
        Nova.out(elseclause)
    end
end

-- Boolean operations
function Nova.and_op(a, b) return a and b end
function Nova.or_op(a, b) return a or b end
function Nova.not_op(a) return not a end

-- Run other Lua files
function Nova.runfile(filename)
    dofile(filename .. ".lua")
end

-- Boolean print
function Nova.bool(name)
    local value = Nova.varstorage[name]
    if value == true then
        Nova.out("true")
    else
        Nova.out("false")
    end
end

return Nova
