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


function gameobject:new(o)
  o = o or {}
  return setmetatable(o, {__index=self})
end

function gameobject:init()
end

function gameobject:playAnim(name)
    self.frameTime = self.frameTime - 0.1
    if self.frameTime <= 0 then
        self.currentFrame = self.currentFrame + 1
        self.frameTime = self.frameTimeInit
    end
    if self.currentFrame > table.getn(player.anim[name]) then
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
