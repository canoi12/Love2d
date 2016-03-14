camera = {}

camera.x = 0
camera.y = 0
camera.xscale = 1
camera.yscale = 1
camera.rotation = 0

function camera.set()
    love.graphics.push()
    love.graphics.rotate(-camera.rotation)
    love.graphics.scale(1/camera.xscale,camera.yscale)
    love.graphics.translate(-camera.x,-camera.y)
end

function camera.unset()
    love.graphics.pop()
end