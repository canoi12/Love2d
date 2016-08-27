utils = {}

function utils.check_solid(x, y)
	for i,v in ipairs(map.map.tilesets[1].tiles) do
		if map.tmap[math.floor(y/8)][math.floor(x/8)] == v.id+1 and v.properties["solid"] then
			return true
		end
	end
	return false
end

function utils.approach(v1,v2,delta)
	if v1 < v2 then
		v1 = v1 + delta
		if v1-v2 < 0.001 and v1-v2 > -0.001 then
			v1 = v2
		end
	elseif v1 > v2 then
		v1 = v1 - delta
		if v2-v1 < 0.001 and v2-v1 > -0.001 then
			v1 = v2
		end
	end

	return v1
end