#!/usr/bin/env lua
-- Nova Scripting Language Interpreter
-- Version 0.0.7
-- 100% Lua Implementation

local NovaInterpreter = {}
NovaInterpreter.__index = NovaInterpreter

function NovaInterpreter:new()
    local instance = {
        varstorage = {},
        arraystorage = {},
        funcstorage = {}
    }
    setmetatable(instance, NovaInterpreter)
    return instance
end

function NovaInterpreter:let(name, value)
    self.varstorage[name] = value
end

function NovaInterpreter:out(name)
    if type(name) == "string" and self.varstorage[name] ~= nil then
        print(self.varstorage[name])
        return
    end
    if self.arraystorage[name] then
        print(self:table_to_string(self.arraystorage[name]))
        return
    end
    print(name)
end

function NovaInterpreter:input(name)
    local value = io.read("*line")
    self.varstorage[name] = value
end

function NovaInterpreter:equal(name, value)
    return self.varstorage[name] == value
end

function NovaInterpreter:notequal(name, value)
    return self.varstorage[name] ~= value
end

function NovaInterpreter:greater(name, name2)
    local a = self.varstorage[name]
    local b = self.varstorage[name2]
    if a > b then 
        self:out(a .. " is greater than " .. b) 
    else 
        self:out(b .. " is greater than " .. a) 
    end
end

function NovaInterpreter:less(name, name2)
    local a = self.varstorage[name]
    local b = self.varstorage[name2]
    if a < b then 
        self:out(a .. " is less than " .. b) 
    else 
        self:out(b .. " is less than " .. a) 
    end
end

function NovaInterpreter:greateroreqt(name, name2)
    local a = self.varstorage[name]
    local b = self.varstorage[name2]
    if a >= b then 
        self:out(a) 
    else 
        self:out(b) 
    end
end

function NovaInterpreter:lessoreqt(name, name2)
    local a = self.varstorage[name]
    local b = self.varstorage[name2]
    if a <= b then 
        self:out(a) 
    else 
        self:out(b) 
    end
end

function NovaInterpreter:loop(times, event)
    for i = 1, times do
        event()
    end
end

function NovaInterpreter:while_loop(times, event)
    local counter = 0
    while counter < times do
        event()
        counter = counter + 1
    end
end

function NovaInterpreter:func(name, fn)
    self.funcstorage[name] = fn
end

function NovaInterpreter:call(name, ...)
    if self.funcstorage[name] then
        return self.funcstorage[name](...)
    else
        self:out("error: invalid function: " .. name .. ".")
    end
end

function NovaInterpreter:ifdo(name, value, then_fn, else_fn)
    if self.varstorage[name] == value then
        then_fn()
    elseif else_fn then
        else_fn()
    end
end

function NovaInterpreter:and_op(a, b)
    return a and b
end

function NovaInterpreter:or_op(a, b)
    return a or b
end

function NovaInterpreter:not_op(a)
    return not a
end

function NovaInterpreter:runfile(filename)
    if not filename:match("%.nova$") then
        filename = filename .. ".nova"
    end
    local file = io.open(filename, "r")
    if not file then
        self:out("error: file " .. filename .. " not found")
        return
    end
    local code = file:read("*all")
    file:close()
    self:execute(code)
end

function NovaInterpreter:bool(name)
    local value = self.varstorage[name]
    if value == true then
        self:out("true")
    else
        self:out("false")
    end
end

function NovaInterpreter:array(name, arr)
    self.arraystorage[name] = arr
end

function NovaInterpreter:table_to_string(t)
    local items = {}
    for i, v in ipairs(t) do
        items[#items+1] = tostring(v)
    end
    return "[" .. table.concat(items, ", ") .. "]"
end

function NovaInterpreter:cut(name, index)
    local a = self.arraystorage[name]
    if a then
        table.remove(a, index)
    end
end

function NovaInterpreter:insert(name, pos, value)
    local a = self.arraystorage[name]
    if a then
        table.insert(a, pos, value)
    end
end

function NovaInterpreter:sort(name)
    local a = self.arraystorage[name]
    if a then
        table.sort(a)
    else
        self:out("error: array " .. name .. " doesn't exist")
    end
end

function NovaInterpreter:add(x, y)
    x = self.varstorage[x] or x
    y = self.varstorage[y] or y
    return x + y
end

function NovaInterpreter:sub(x, y)
    x = self.varstorage[x] or x
    y = self.varstorage[y] or y
    return x - y
end

function NovaInterpreter:mul(x, y)
    x = self.varstorage[x] or x
    y = self.varstorage[y] or y
    return x * y
end

function NovaInterpreter:div(x, y)
    x = self.varstorage[x] or x
    y = self.varstorage[y] or y
    if y == 0 then
        print("error: division by zero")
        return nil
    end
    return x / y
end

function NovaInterpreter:len(inputstring)
    inputstring = self.varstorage[inputstring] or inputstring
    if type(inputstring) ~= "string" then
        print("error: len() expects type string")
        return nil
    end
    return string.len(inputstring)
end

function NovaInterpreter:reverse(inputstring)
    inputstring = self.varstorage[inputstring] or inputstring
    if type(inputstring) ~= "string" then
        print("error: reverse() expects type string")
        return nil
    end
    return string.reverse(inputstring)
end

function NovaInterpreter:upper(inputstring)
    inputstring = self.varstorage[inputstring] or inputstring
    if type(inputstring) ~= "string" then
        print("error: upper() expects type string")
        return nil
    end
    return string.upper(inputstring)
end

function NovaInterpreter:lower(inputstring)
    inputstring = self.varstorage[inputstring] or inputstring
    if type(inputstring) ~= "string" then
        print("error: lower() expects type string")
        return nil
    end
    return string.lower(inputstring)
end

-- Helper function to trim whitespace
local function trim(s)
    return s:match("^%s*(.-)%s*$")
end

-- Helper function to split string
local function split(str, delimiter)
    local result = {}
    local pattern = string.format("([^%s]+)", delimiter)
    for match in str:gmatch(pattern) do
        table.insert(result, match)
    end
    return result
end

function NovaInterpreter:parse_value(value_str)
    value_str = trim(value_str)
    
    -- Check for string literals
    if (value_str:match('^".*"$') or value_str:match("^'.*'$")) then
        return value_str:sub(2, -2)
    end
    
    -- Check for boolean
    if value_str:lower() == 'true' then
        return true
    end
    if value_str:lower() == 'false' then
        return false
    end
    
    -- Check for null/nil
    if value_str:lower() == 'nil' or value_str:lower() == 'null' then
        return nil
    end
    
    -- Check for function calls (e.g., add("x", "y"))
    local func_name, args_str = value_str:match("^(%w+)%s*%((.*)%)$")
    if func_name then
        local args = self:parse_arguments(args_str)
        if self[func_name] and type(self[func_name]) == "function" then
            local success, result = pcall(function()
                return self[func_name](self, table.unpack(args))
            end)
            if success then
                return result
            end
        elseif self.funcstorage[func_name] then
            return self:call(func_name, table.unpack(args))
        end
    end
    
    -- Check for array
    if value_str:match('^%[.*%]$') then
        local items_str = value_str:sub(2, -2)
        items_str = trim(items_str)
        if items_str == "" then
            return {}
        end
        
        -- Simple comma split (doesn't handle nested arrays perfectly)
        local items = {}
        local depth = 0
        local current = ""
        
        for i = 1, #items_str do
            local char = items_str:sub(i, i)
            if char == '[' then
                depth = depth + 1
                current = current .. char
            elseif char == ']' then
                depth = depth - 1
                current = current .. char
            elseif char == ',' and depth == 0 then
                table.insert(items, self:parse_value(current))
                current = ""
            else
                current = current .. char
            end
        end
        
        if current ~= "" then
            table.insert(items, self:parse_value(current))
        end
        
        return items
    end
    
    -- Check for number
    local num = tonumber(value_str)
    if num then
        return num
    end
    
    -- Check if it's a variable reference
    if self.varstorage[value_str] ~= nil then
        return self.varstorage[value_str]
    end
    
    -- Return as string
    return value_str
end

function NovaInterpreter:parse_arguments(args_str)
    args_str = trim(args_str)
    if args_str == "" then
        return {}
    end
    
    local args = {}
    local depth = 0
    local in_string = false
    local string_char = nil
    local current = ""
    
    for i = 1, #args_str do
        local char = args_str:sub(i, i)
        
        -- Handle string delimiters
        if (char == '"' or char == "'") and not in_string then
            in_string = true
            string_char = char
            current = current .. char
        elseif char == string_char and in_string then
            in_string = false
            string_char = nil
            current = current .. char
        elseif char == '(' or char == '[' then
            depth = depth + 1
            current = current .. char
        elseif char == ')' or char == ']' then
            depth = depth - 1
            current = current .. char
        elseif char == ',' and depth == 0 and not in_string then
            table.insert(args, self:parse_value(current))
            current = ""
        else
            current = current .. char
        end
    end
    
    if current ~= "" then
        table.insert(args, self:parse_value(current))
    end
    
    return args
end

function NovaInterpreter:execute_line(line)
    line = trim(line)
    
    -- Skip empty lines and comments
    if line == "" or line:match("^%-%-") or line:match("^//") then
        return
    end
    
    -- Parse function calls
    -- Pattern: function_name(args)
    local func_name, args_str = line:match("^(%w+)%s*%((.*)%)$")
    
    if func_name then
        -- Parse arguments
        local args = self:parse_arguments(args_str)
        
        -- Execute built-in functions
        if self[func_name] and type(self[func_name]) == "function" then
            local success, result = pcall(function()
                return self[func_name](self, table.unpack(args))
            end)
            
            if not success then
                print("error: " .. tostring(result))
            end
        elseif self.funcstorage[func_name] then
            -- Call user-defined function
            self:call(func_name, table.unpack(args))
        else
            print("error: unknown function '" .. func_name .. "'")
        end
    end
end

function NovaInterpreter:execute(code)
    -- Split code into lines
    local lines = {}
    for line in code:gmatch("[^\r\n]+") do
        table.insert(lines, line)
    end
    
    for _, line in ipairs(lines) do
        self:execute_line(line)
    end
end

-- Main function
local function main()
    local interpreter = NovaInterpreter:new()
    
    if arg[1] then
        -- Execute file
        local filename = arg[1]
        local file = io.open(filename, "r")
        if not file then
            print("error: file '" .. filename .. "' not found")
            os.exit(1)
        end
        local code = file:read("*all")
        file:close()
        interpreter:execute(code)
    else
        -- Interactive REPL
        print("Nova Interpreter v0.0.7")
        print("Type 'exit' or 'quit' to exit")
        print()
        
        while true do
            io.write("nova> ")
            io.flush()
            local line = io.read("*line")
            
            if not line then
                break
            end
            
            line = trim(line)
            
            if line:lower() == "exit" or line:lower() == "quit" then
                break
            end
            
            local success, err = pcall(function()
                interpreter:execute_line(line)
            end)
            
            if not success then
                print("error: " .. tostring(err))
            end
        end
    end
end

-- Run main
main()

collectgarbage("collect") -- forced garbage collection at end, helps when running large scripts
