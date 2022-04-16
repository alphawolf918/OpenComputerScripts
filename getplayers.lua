local comp = require("component")
local radar = comp.proxy(comp.radar.address)
local players = radar.getPlayers()
local playerLen = #players

print("Nearby players: ")

for i = 1, playerLen do
	print("Name: " .. players[i]["name"])
	print("Distance: " .. players[i]["distance"])
end