local comp = require("component")
local proxy = comp.proxy(comp.chat_box.address)
local args = {...}
local argLen = #args
local msg = ""

proxy.setDistance(40)

for i = 1, argLen do
	msg = msg .. " " .. args[i]
end

proxy.say(msg)