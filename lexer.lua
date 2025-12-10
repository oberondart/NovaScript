local keywords = {
    let = true, out = true, input = true, func = true, call = true,
    if = true, else = true, while = true, for = true, and = true,
    or = true, not = true, runfile = true, bool = true, array = true
}

local function lexer(input)
    local tokens = {}
    local i = 1
    local length = #input

    while i <= length do
        local c = input:sub(i, i)

        -- Skip whitespace and comments
        if c == " " or c == "\t" or c == "\n" or c == "\r" then
            i = i + 1
        -- Number token
        elseif c:match("%d") then
            local num = input:match("^[0-9]+", i)
            table.insert(tokens, {type = "NUMBER", value = tonumber(num)})
            i = i + #num
        -- String token
        elseif c == '"' then
            local str = input:match('^"([^"]+)"', i)
            table.insert(tokens, {type = "STRING", value = str})
            i = i + #str + 2
        -- Boolean token
        elseif input:sub(i, i + 3) == "true" then
            table.insert(tokens, {type = "BOOLEAN", value = true})
            i = i + 4
        elseif input:sub(i, i + 4) == "false" then
            table.insert(tokens, {type = "BOOLEAN", value = false})
            i = i + 5
        -- Identifier token (variables and functions)
        elseif c:match("%a") then
            local identifier = input:match("^[%a_][%a%d_]*", i)
            if keywords[identifier] then
                table.insert(tokens, {type = "KEYWORD", value = identifier})
            else
                table.insert(tokens, {type = "IDENTIFIER", value = identifier})
            end
            i = i + #identifier
        -- Operators
        elseif c == "=" then
            if input:sub(i + 1, i + 1) == "=" then
                table.insert(tokens, {type = "OPERATOR", value = "=="})
                i = i + 2
            else
                table.insert(tokens, {type = "OPERATOR", value = "="})
                i = i + 1
            end
        elseif c == ">" then
            if input:sub(i + 1, i + 1) == "=" then
                table.insert(tokens, {type = "OPERATOR", value = ">="})
                i = i + 2
            else
                table.insert(tokens, {type = "OPERATOR", value = ">"})
                i = i + 1
            end
        elseif c == "<" then
            if input:sub(i + 1, i + 1) == "=" then
                table.insert(tokens, {type = "OPERATOR", value = "<="})
                i = i + 2
            else
                table.insert(tokens, {type = "OPERATOR", value = "<"})
                i = i + 1
            end
        elseif c == "+" or c == "-" or c == "*" or c == "/" then
            table.insert(tokens, {type = "OPERATOR", value = c})
            i = i + 1
        -- Parentheses and braces
        elseif c == "(" or c == ")" or c == "{" or c == "}" then
            table.insert(tokens, {type = "DELIMITER", value = c})
            i = i + 1
        -- Semicolon and comma
        elseif c == ";" or c == "," then
            table.insert(tokens, {type = "DELIMITER", value = c})
            i = i + 1
        -- Unexpected character (error)
        else
            error("Unexpected character: " .. c)
        end
    end

    return tokens
end

-- Example usage:
local input_code = [[
let var_name = "Hello, world!";
out(var_name);
]]

local tokens = lexer(input_code)

for _, token in ipairs(tokens) do
    print(token.type, token.value)
end
