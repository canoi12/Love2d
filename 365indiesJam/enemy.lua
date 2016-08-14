enemy=gameobject:new()
enemy.kind=2

function enemy:new(o)
	o = o or {}
	return setmetatable(o, {__index=self})
end