local gameobject = {}

gameobject.image = nil
gameobject.x = 0;
gameobject.y = 0;
gameobject.quad = nil
gameobject.anim = {}
gameobject.currentAnimation = "idle"
gameobject.currentFrame = 0
gameobject.frameTimeInit = 0.5
gameobject.frameTime = 0.5
gameobject.dx = 0
gameobject.dy = 0
gameobject.xscale = 1
gameobject.yscale = 1
gameobject.isGround = false
gameobject.flip = -1
gameobject.angle = 0
gameobject.xorigin = 8
gameobject.yorigin = 8
gameobject.gravity = 0.2
gameobject.friction = 0


function gameobject:new(o)
  o = o or {}
  return setmetatable(o, {__index=self})
end

function gameobject:init()
end

function gameobject:setAnimation(name)
  if name ~= self.currentAnimation then
    self.currentAnimation = name
    self.currentFrame = 0
    self.frameTime = 1
  end
end

function gameobject:playAnim()
    self.frameTime = self.frameTime - 0.1
    if self.frameTime <= 0 then
        self.currentFrame = self.currentFrame + 1
        self.frameTime = self.frameTimeInit
    end
    if self.currentFrame > table.getn(self.anim[self.currentAnimation]) then
        self.currentFrame = 0
    end
end

function gameobject:newAnim(y,nImg, width, height, ImgWidth, ImgHeight)
    local anim = {}
    for i=0,nImg do
        anim[i] = love.graphics.newQuad(i*width,y,width,height,ImgWidth,ImgHeight)
    end
    return anim
end

function gameobject:update(dt)

end

function gameobject:draw()

end


return gameobject
