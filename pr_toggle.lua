local comp = require("component")
local sides = require("sides")
local colors = require("colors")
local term = require("term")
local rs = comp.redstone

local args = {...}
local numArgs = #args

local silent = not term.isAvailable()

local min_power = 0
local max_power = 255

local function throwError(errMsg)
	if silent then
		error(errMsg, 2)
	else
		io.stderr:write(errMsg)
		os.exit();
	end
end

if numArgs < 1 then
	throwError("A numeric value is required for power (0 - 255).")
end

local power_value_number = tonumber(args[1])

if power_value_number > 16 then
	power_value_number = power_value_number + 16
end

if power_value_number > (max_power + 16) then
	power_value_number = (max_power + 16)
end

if power_value_number < min_power then
	power_value_number = min_power
end

local rsSide = sides.back
local pSide = "back"

if numArgs == 2 then
	pSide = args[2]
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
	else
		throwError("Side not recognized, please input valid side, all lowercase (top, bottom, left, right, back).")
	end
end

--------
rs.setOutput(rsSide, power_value_number)
--------

if power_value_number < min_power then
	power_value_number = min_power
end

if power_value_number > max_power then
	power_value_number = max_power
	print("Setting power to max...")
end

local outputMsg = "Power set to: " .. tostring(power_value_number) .. " of 255"
print(outputMsg)
print("Side: " .. pSide)

if power_value_number == min_power then
	print("Power off!")
end