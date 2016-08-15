utils={}
function utils.sign(x)
	if x < 0 then
		return -1
	elseif x > 0 then
		return 1
	end
	return 0
end

-- check if a position on the grid is solid
function utils.check_solid(x,y)
	if x < 0 or x >= (screenmanager.currentScreen.map.test.width)*16 or 
	   y < 0 or y >= (screenmanager.currentScreen.map.test.height)*16 then
		return false
	end
	local test = true
	for i,v in ipairs(screenmanager.currentScreen.map.test.tilesets[1].tiles) do
		if screenmanager.currentScreen.map.tmap[math.floor((y)/16)][math.floor((x)/16)] == v.id+1 and v.properties["solid"]==1 then
			return true
		end
	end
	return false
end

function utils.approach(v1,v2,variation)
	if v1 < (v2 + 0.001) and v1 > (v2 - 0.001) then
		return v2
	end

	if v1 < v2 then
		v1 = v1 + variation
	elseif v1 > (v2) then
		v1 = v1 - variation
	end

	return v1
end