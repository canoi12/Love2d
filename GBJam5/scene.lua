local scene = {}
require "map"
player = require "player"
char = {}

scene.objects = {}
scene.chao = {}
scene.map = map:new()
scene.tilewidth = 16
scene.tileheight = 16


function scene:new(o)
  o = o or {}
  return setmetatable(o, {__index=self})
end

function scene:init()
  self.map:loadMap("assets/maps/level1.lua")

  for i,v in ipairs(self.map.objects) do
    if v.name == "Player" then
      char = player:new{anim={}, x=v.x, y = v.y}
      char:init()
      table.insert(self.objects, char)
    end
  end

  for i,v in ipairs(self.map.chao) do
    table.insert(self.chao, v)
  end
end

function scene:update(dt)
  for i,obj in ipairs(self.objects) do
    obj:update(dt)
  end
end

function scene:draw()
  love.graphics.translate(-char.x + 80, -char.y + 72)
  love.graphics.print(table.getn(self.objects), 0, 0)
  self.map:draw()
  for i,v in ipairs(self.chao) do
    love.graphics.rectangle("fill", v.x, v.y, v.width, v.height)
  end

  for i,obj in ipairs(self.objects) do
    obj:draw()
  end

end

return scene
