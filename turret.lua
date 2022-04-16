local comp = require("component")
local turret = comp.os_energyturret

local horizontalRotation = 180
local verticalRotation = 45

turret.powerOn()
turret.setArmed(true)

while(true) do
	turret.moveTo(horizontalRotation, verticalRotation)

	while turret.isOnTarget() == false do
		os.sleep(0.1)

		if(horizontalRotation < 300) then
			horizontalRotation = horizontalRotation + 5
		else
			horizontalRotation = 0
		end
		
		if(verticalRotation < 45) then
			verticalRotation = verticalRotation + 5
		else
			verticalRotation = 0
		end

		turret.moveTo(horizontalRotation, verticalRotation)
	end

	turret.fire()
end

--turret.powerOff()