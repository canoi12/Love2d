utils = {}

function utils.sign(v1)
	if v1 < 0 then
		return -1
	elseif v1 > 0 then
		return 1
	else
		return 0
	end
end

function utils.iif(a,b,c)
	if a then
		return b
	end
	return c
end