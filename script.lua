local nova = require("nova")

nova.let("my_number", 123) -- declare variables
nova.let("lucky", 12)
nova.let("counter", 0)

nova.out("my_number") -- standard output via out()
nova.out("lucky")

nova.loop(3, function() -- loop, not entirely sufficent, you need an anonymous function
    nova.incr("counter")
    nova.out("counter")
end)
