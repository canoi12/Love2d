go = require "gameobject"
local player = go:new({anim={},   image = love.graphics.newImage("assets/image/Protagonist-sheet.png"),  currentAnimation = "idle"})

function player:new(o)
  o = o or {}
  self:init()
  return setmetatable(o, {__index=self})
end

function player:init()
  self.anim["idle"] = self:newAnim(0,4,16,16,player.image:getDimensions())
end

function player:update(dt)
  self:playAnim(self.currentAnimation)
  if love.keyboard.isDown("left") then
    self.x = self.x - 2
  end
  if love.keyboard.isDown("right") then
    self.x = self.x + 2
  end

  if self.y < (144-32) then
    self.y = self.y + 2
  end
end

function player:draw()
  love.graphics.draw(self.image,self.anim[self.currentAnimation][self.currentFrame],self.x,self.y)
end

return player
