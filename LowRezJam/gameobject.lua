gameobject = {}
gameobject.x = 0
gameobject.y = 0
gameobject.width = 0
gameobject.height = 0
gameobject.ox = self.width/2
gameobject.oy = self.height/2
gameobject.angle = 0
gameobject.object = ""
gameobject.image = nil
gameobject.anim = {}
gameobject.currentAnim = ''
gameobject.flipH = 1
gameobject.speed = 10
gameobject.frameAtual = 0
gameobject.frameTime = 0
gameobject.frameTimeInit = 0.10
gameobject.dx = 0
gameobject.dy = 0
gameobject.vida = 10
gameobject.image:setFilter("nearest","nearest")
gameobject.type = ''
gameobject.bbox = {
	left = 0,
	right = self.width,
	up = 0,
	down = self.height
}

function gameobject:new(o)
	o = o or {}
	return setmetatable(o,{__index=self})
end

function gameobject:load()

end

function gameobject:update(dt)

end

function gameobject:draw()

end