gamescreen = {}

function gamescreen:new(o)
	o = o or {}
	return setmetatable(o, {__index=self})
end

function gamescreen:load()

end

function gamescreen:update(dt)

end

function gamescreen:draw()

end