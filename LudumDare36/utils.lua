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