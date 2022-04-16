local comp = require("component")
local event = require("event")
local colors = require("colors")
local term = require("term")

local writer = comp.os_cardwriter
local reader = comp.os_magreader
local door = comp.os_doorcontroller

local args = {...}
local numArgs = #args

local evidenceRoom = "3d4cb13b-fc72-4f17-bb0e-dad70509bd27"
local garageRoom = "947bcb28-7c60-4e53-9890-c6ccf61ec983"

local cardAddress = nil
local clr = colors.white

local function throwError(errMsg)
	if silent then
		error(errMsg, 2)
	else
		io.stderr:write(errMsg)
		os.exit();
	end
end

local room = nil

if(numArgs < 1) then
	throwError("Missing one parameter: ROOM.")
else
	room = args[1]
end

if(room == "evidence") then
	cardAddress = evidenceRoom
	clr = colors.green
elseif(room == "garage") then
	cardAddress = garageRoom
	clr = colors.blue
else
	throwError("Room " .. room .. " not recognized. Perhaps it's time for an update?")
end

local function openDoor(roomAddress, playerName, cardData)
	if(roomAddress ~= nil) then
		component.invoke(roomAddress, "open")
		os.sleep(3)
		component.invoke(roomAddress, "close")
	else
		throwError("No room address was assigned! ERR: ID-10-T")
	end
end

if(cardAddress ~= nil) then
	local cardName = "Room Card ".. " (" .. room .. ")"
	writer.write(cardAddress, cardName, true, clr)
	writer.flash(cardAddress, cardName, true)
else
	throwError("Unable to write card; no valid address given. ERR: PEBCAK")
end

function readMagCard(eventName, address, playerName, cardData, cardUniqueId, isCardLocked, side)
	print("PLAYER " .. playerName)
	print("CARD " .. cardUniqueId)
	print("DATA: " .. cardData)
	print("SIDE: " .. side)
	openDoor(cardAddress, playerName, cardData)
end

event.listen("magData", readMagCard)
event.pull("interrupted")
event.ignore("magData", readMagCard)