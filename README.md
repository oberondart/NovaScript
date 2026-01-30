# Nova
Simple toy scripting language built entirely in Lua 5.4. This isn't really a serious project.
I made it for fun :)

## Language Reference

```nova
chmod +x interpreter.lua (turn file into executable)
```

### Variables

```nova
let("variable_name", value)
```

Store a value in a variable. Values can be:
- Numbers: `10`, `3.14`
- Strings: `"hello"`, `'world'`
- Booleans: `true`, `false`
- Arrays: `[1, 2, 3]`

### Input/Output

**Output a value:**
```nova
out("variable_name")  -- Outputs the value of variable_name
out("Hello")          -- Outputs the string "Hello"
out(42)               -- Outputs the number 42
```

**Get user input:**
```nova
input("name")  -- Reads a line from stdin and stores in "name"
```

### Arithmetic Operations

```nova
let("a", 10)
let("b", 5)

let("sum", add("a", "b"))        -- 15
let("difference", sub("a", "b")) -- 5
let("product", mul("a", "b"))    -- 50
let("quotient", div("a", "b"))   -- 2
```

### String Operations

```nova
let("text", "Hello World")

let("length", len("text"))      -- 11
let("upper", upper("text"))     -- "HELLO WORLD"
let("lower", lower("text"))     -- "hello world"
let("rev", reverse("text"))     -- "dlroW olleH"
```

### Array Operations

**Create an array:**
```nova
array("numbers", [5, 2, 8, 1, 9])
```

**Sort an array:**
```nova
sort("numbers")  -- Sorts in ascending order
```

**Insert element:**
```nova
insert("numbers", 1, 10)  -- Insert 10 at position 1
```

**Remove element:**
```nova
cut("numbers", 2)  -- Remove element at index 2
```

**Output array:**
```nova
out("numbers")  -- Prints [1, 2, 5, 8, 9]
```

### Comparison Operations

```nova
equal("var1", value)         -- Returns true if var1 equals value
notequal("var1", value)      -- Returns true if var1 does not equal value
greater("var1", "var2")      -- Outputs which is greater
less("var1", "var2")         -- Outputs which is less
greateroreqt("var1", "var2") -- Outputs the greater or equal value
lessoreqt("var1", "var2")    -- Outputs the lesser or equal value
```

### Control Flow

**Conditional execution:**
```nova
ifdo("variable", value, function() 
    -- then block
end, function()
    -- else block (optional)
end)
```

**Loop a fixed number of times:**
```nova
loop(5, function()
    out("Hello")
end)
```

**While loop:**
```nova
while_loop(10, function()
    -- Code to execute
end)
```

### Functions

**Define a function:**
```nova
func("my_function", function(arg1, arg2)
    out(arg1)
    out(arg2)
end)
```

**Call a function:**
```nova
call("my_function", "Hello", "World")
```

### Logical Operations

```nova
and_op(true, false)   -- Returns false
or_op(true, false)    -- Returns true
not_op(true)          -- Returns false
```

### Boolean Operations

```nova
let("flag", true)
bool("flag")  -- Outputs "true"
```

### File Operations

**Run another Nova script:**
```nova
runfile("other_script")  -- Executes other_script.nova
```

## Example Scripts

### Hello World

```nova
let("name", "World")
out("Hello, ")
out("name")
```

### Calculator

```nova
let("a", 15)
let("b", 3)

let("sum", add("a", "b"))
let("diff", sub("a", "b"))
let("prod", mul("a", "b"))
let("quot", div("a", "b"))

out("Addition: ")
out("sum")
out("Subtraction: ")
out("diff")
out("Multiplication: ")
out("prod")
out("Division: ")
out("quot")
```

### Array Manipulation

```nova
array("fruits", ["apple", "orange", "banana"])
out("Original:")
out("fruits")

insert("fruits", 2, "grape")
out("After insert:")
out("fruits")

cut("fruits", 1)
out("After cut:")
out("fruits")

sort("fruits")
out("Sorted:")
out("fruits")
```

### String Processing

```nova
let("message", "Hello Nova")
out("Original:")
out("message")

let("upper_msg", upper("message"))
out("Uppercase:")
out("upper_msg")

let("lower_msg", lower("message"))
out("Lowercase:")
out("lower_msg")

let("reversed", reverse("message"))
out("Reversed:")
out("reversed")

let("msg_length", len("message"))
out("Length:")
out("msg_length")
```

### Interactive Input

```nova
out("What is your name?")
input("username")
out("Hello, ")
out("username")
out("!")
```
