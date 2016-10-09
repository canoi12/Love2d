go = require "gameobject"

plant = go:new{anim = {}, image = love.graphics.newImage("assets/image/plant-sheet.png"), xorigin = 0, yorigin = 0}


function plant:init()
  self.anim["idle"] = self:newAnim(0,2,8,8,self.image:getDimensions())
  self.image:setFilter("nearest", "nearest")
  self.frameTimeInit = 0.8
end

function plant:update(dt)
  self:playAnim()
end

function plant:draw()
  love.graphics.draw(self.image,self.anim[self.currentAnimation][self.currentFrame],self.x, self.y, self.angle, self.flip*self.xscale, self.yscale, self.xorigin, self.yorigin)
end
