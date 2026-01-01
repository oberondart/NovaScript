local nova = require("nova")
nova.let("my_string", "hello, world!")
nova.out("my_string")

nova.let("my_number", 1)
nova.let("this_number", 2)
nova.let("happy_number", 3)

nova.out("my_number")
nova.out("this_number")
nova.out("happy_number")

nova.array("my_array", {1, 2, 3, 4, 5})
nova.out("my_array")
nova.out("goodbye, world!")

nova.let("variable1", "novascript")
nova.out(nova.len("variable1"))
