local nova = require("nova")

nova.let("my_number", 123)
nova.let("lucky", 12)
nova.let("counter", 0)

nova.out("my_number")
nova.out("lucky")

nova.array("my_array", {1, 2, 3, 4, 5})
nova.out("my_array")
