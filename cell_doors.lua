local comp = require("component")
local sides = require("sides")
local term = require("term")
local os = require("os")
local rs = comp.redstone

local args = {...}
local numArgs = #args

local silent = not term.isAvailable()

local function throwError(errMsg)
	if silent then
		error("Error: " .. errMsg, 2)
	else
		io.stderr:write(errMsg)
		os.exit();
	end
end

if numArgs < 2 then
	throwError("Invalid number of arguments.")
end

local power
local control = args[1]

if control == "open" then
	power = 15
elseif control == "close" then
	power = 0
else
	throwError("Don't know what " .. tostring(control) .. "is.")
end

local rsSide = sides.back
local pSide = args[2]

if pSide == "top" then
	rsSide = sides.top
elseif pSide == "bottom" then
	rsSide = sides.bottom
elseif pSide == "left" then
	rsSide = sides.left
elseif pSide == "right" then
	rsSide = sides.right
elseif pSide == "back" then
	rsSide = sides.back
elseif pSide == "front" then
	rsSide = sides.front
else
	throwError("Side not recognized, please input valid side, all lowercase (top, bottom, left, right, back, front).")
end

local nTime

if numArgs < 3 then
	nTime = 5
else
	nTime = tonumber(args[3])
end

--------
rs.setOutput(rsSide, power)
if nTime >= 0 then
	print("Setting side " .. pSide .. " to " .. control .. " for " .. tostring(nTime) .. " second(s).")
	os.sleep(nTime)
	---------------------------------
	if power == 15 then
		power = 0
	else
		power = 15
	end
	rs.setOutput(rsSide, power)
	---------------------------------
else
	print("Skipping sleep timer; remember to set this back manually!")
end

print("Code execution complete.")
--------