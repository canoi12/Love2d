gameobject = {}

gameobject.state = nil
gameobject.x = 0
gameobject.y = 0
gameobject.width = 32
gameobject.height = 32
gameobject.gravity = 800
gameobject.speed = 200
gameobject.vspeed = 0
gameobject.hspeed = 0
gameobject.ativo = false
gameobject.image = nil
gameobject.type = ''
gameobject.life = 1

function gameobject:baseClass()
	return setmetatable{self,{__index=gameobject}}
end

function gameobject:new(o)
	o = o or {}
	return setmetatable(o,{__index=self})
end

function gameobject:setImage(image)
	self.image = love.graphics.setImage(image)
end
function gameobject:setState(state)
	self.state = state
end

function gameobject:load()
	-- body
end

function gameobject:update(dt)
	if self.state ~= nil then
		self:state(dt)
	end
end

function gameobject:draw()
	-- body
end