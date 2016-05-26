gameobject = {}
gameobject.image = nil
gameobject.x = 0
gameobject.y = 0
gameobject.width = 32
gameobject.height = 32
gameobject.speed = 50
gameobject.gravity = 500
gameobject.vspeed = 0
gameobject.anim = {}
gameobject.currentAnimation = nil
gameobject.currentFrame = 0
gameobject.frameTimeInit = 0.5
gameobject.frameTime = gameobject.frameTimeInit


function gameobject:newAnim(y,nImg, width, height, ImgWidth, ImgHeight)
    local anim = {}
    for i=0,nImg do
        anim[i] = love.graphics.newQuad(i*width,y,width,height,ImgWidth,ImgHeight)
    end
    print(anim[0])
    return anim
end

function gameobject:new(o)
    o = o or {}
    self:load()
    return setmetatable(o,{__index = self})
end
function gameobject:setImage(image)
    self.image = love.graphics.newImage(image)
end

function gameobject:load()

end

function gameobject:update(dt)

end

function gameobject:draw()
    
end