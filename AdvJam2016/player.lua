player = gameobject:new()
player:setImage("assets/char.png")
player.anim = {}
player.currentAnimation = "walk"




function player:load()
    player.anim["idle"] = player:newAnim(0,5,32,32,256,64)
    player.anim["walk"] = player:newAnim(32,7,32,32,256,64)
end

function player:update(dt)
    self.frameTime = self.frameTime - 0.1
    if self.frameTime <= 0 then
        self.currentFrame = self.currentFrame + 1
        self.frameTime = self.frameTimeInit
    end
    if self.currentFrame > table.getn(player.anim[player.currentAnimation]) then
        self.currentFrame = 0
    end
    
    if love.keyboard.isDown("left") then
        self.x = self.x - (self.speed * dt)
    elseif love.keyboard.isDown("right") then
        self.x = self.x + (self.speed * dt)
    end
    
    self.vspeed = self.vspeed+ (self.gravity * dt)
    self.y = self.y + (self.vspeed * dt)
    
    if self.y + self.height > 128 then
        self.y = 128 - self.height
        self.vspeed = 0
    end
    
    if love.keyboard.isDown("up") and self.vspeed == 0 then
        self.vspeed = -200
    end
end

function player:draw()
    love.graphics.draw(self.image,self.anim[player.currentAnimation][self.currentFrame],self.x,self.y)
    love.graphics.print(self.currentFrame, 0,0)
end