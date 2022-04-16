local comp = require("component")
local sides = require("sides")
local colors = require("colors")
local term = require("term")
local rs = comp.redstone

local args = {...}
local numArgs = #args

local silent = not term.isAvailable()

local function throwError(errMsg)
	if silent then
		error(errMsg, 2)
	else
		io.stderr:write(errMsg)
		os.exit();
	end
end

if numArgs < 1 then
	throwError("Please use on or off.")
end

local toggleArg = args[1]
local toggle = 0

if toggleArg == "on" then
	toggle = 15
elseif toggleArg == "off" then
	toggle = 0
else
	throwError("Please use on or off for first parameter.")
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

rs.setOutput(rsSide, toggle)

if toggleArg == "on" then
	print("Turning power ON for side " .. pSide)
elseif toggleArg == "off" then
	print("Turning power OFF for side " .. pSide)
else
    print("Invalid input.")
end