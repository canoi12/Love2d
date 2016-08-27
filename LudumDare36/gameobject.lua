local gameobject = {}

gameobject.x = 0
gameobject.y = 0
gameobject.w = 16
gameobject.h = 32
gameobject.xscale = 1
gameobject.yscale = 1
gameobject.xorigin = 8
gameobject.yorigin = 16
gameobject.xske = 0
gameobject.yske = 0

gameobject.flip = 1

gameobject.dx = 0
gameobject.dy = 0

gameobject.angle = 0

gameobject.friction = 0.8
gameobject.bounce = 0
gameobject.gravity = 0

gameobject.anim={}

gameobject.frame = 1
gameobject.animTime = 1
gameobject.actualAnim = ''

gameobject.image = nil

gameobject.colbox = {
	left = 0,
	right = gameobject.w,
	top = 0,
	bottom = gameobject.h
}

function gameobject:new(o)
	o = o or {}
	return setmetatable(o, {__index=self})
end


function gameobject:createAnimation(name,x,y,frameWidth, frameHeight,numberImages)
	self.anim[name] = {}

	frameX = x/frameWidth

	for i=frameX,(numberImages+frameX) do
		table.insert(self.anim[name],love.graphics.newQuad(i*frameWidth,y,frameWidth,frameHeight,self.image:getDimensions()))
	end

	if self.actualAnim == "" then
		self.actualAnim = name
	end
end

function gameobject:changeAnim(name)
	if self.actualAnim ~= name then
		self.actualAnim = name
		self.frame = 1
	end
end

function gameobject:playAnim()
	if self.animTime >= 0 then
		self.animTime = self.animTime - 0.2
	else
		self.animTime = 1
		self.frame = self.frame + 1
	end

	if self.frame >= table.getn(self.anim[self.actualAnim]) then
		self.frame = 1
	end
end

function gameobject:collision(obj2)

end

function gameobject:load()

end

function gameobject:update(dt)

end

function gameobject:draw()
end

return gameobject