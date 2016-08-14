gamescreen={}
gamescreen.map={}
gamescreen.objects={}


function gamescreen:new(o)
	o = o or {}
	self:load()
	return setmetatable(o, {__index=self})
end

function gamescreen:load()
	self.map = map:new()
	self.objects={}
end

function gamescreen:reset()
end

function gamescreen:update(dt)
end

function gamescreen:draw()
end