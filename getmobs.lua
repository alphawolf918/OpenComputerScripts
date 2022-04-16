local comp = require("component")
local radar = comp.proxy(comp.radar.address)
local mobs = radar.getMobs()
local mobLen = #mobs

print("Nearby mobs: ")

for i = 1, mobLen do
	print("Name: " .. mobs[i]["name"])
	print("Distance: " .. mobs[i]["distance"])
end