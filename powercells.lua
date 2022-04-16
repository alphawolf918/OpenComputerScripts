local comp = require("component")

function getCells()
	local energyCells = component.list("energy_device")
	local countCells = 0
	local cellsID = {}
	
	for address, name in pairs(energyCells) do
		countCells = countCells + 1

		if countCells > 1 then
			cellsID[address] = "Thermal Expansion Power Cell".." "..countCells
		else
			cellsID[address] = "Thermal Expansion Power Cell"
		end
	end
	
	return cellsID
end

function getTotal()
	local totalPower = 0
	local totalMaxPower = 0	
	local cellID = getCells()
	
	for address, name in pairs(cellID) do
		local cell = component.proxy(address)
		totalPower = totalPower + cell.getEnergyStored()
		totalMaxPower = totalMaxPower + cell.getMaxEnergyStored()
	end
	return totalPower, totalMaxPower
end

print(getTotal())