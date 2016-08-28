utils = {}

function utils.check_solid(x,y)
	if x < 0 or x > (map.map.width)*8 or 
	   y < 0 or y > (map.map.height)*8 then
		return false
	end
	local test = true
	for i,v in ipairs(map.map.tilesets[1].tiles) do
		if map.tmap[math.floor((y)/8)][math.floor((x)/8)] == v.id+1 and v.properties["solid"]==1 then
			return true
		end
	end
	return false
end