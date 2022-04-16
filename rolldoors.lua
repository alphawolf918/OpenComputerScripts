local comp = require("component")

for address, name in comp.list("os_rolldoorcontroller", true) do
	comp.invoke(address, "setSpeed", 2)
	comp.invoke(address, "toggle")
end