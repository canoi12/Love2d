utils = {}

function utils.check_solid(x, y)
	for i,v in ipairs(map.map.tilesets[1].tiles) do
		if map.tmap[math.floor(y/8)][math.floor(x/8)] == v.id+1 and v.properties["solid"] then
			return true
		end
	end
	return false
end