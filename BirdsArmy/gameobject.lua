gameobject = {}

gameobject.image = love.graphics.newImage("assets/characters.png")
gameobject.quad = love.graphics.newQuad(0,33,32,32, gameobject.image:getDimensions())
gameobject.xscale = 1
gameobject.yscale = 1
gameobject.x = 0
gameobject.y = 0
gameobject.gravity = 800
gameobject.vspeed = 0
gameobject.flip = 1
gameobject.ground = false

gameobject.anim = {
    
}

function gameobject:new(o)
    local o = o or {}
    return setmetatable(o, {__index=self})
end

function gameobject:update(dt)
    if love.keyboard.isDown("up") and gameobject.ground then
        gameobject.xscale = 0.55
        gameobject.yscale = 1.45
        gameobject.vspeed = -400
        gameobject.ground = false
    end

    if love.keyboard.isDown("right") then
        gameobject.x = gameobject.x + (200 * dt)
        gameobject.flip = 1
    elseif love.keyboard.isDown("left") then
        gameobject.x = gameobject.x - (200 * dt)
        gameobject.flip = -1
    end

    gameobject.vspeed = gameobject.vspeed + (gameobject.gravity * dt)
    gameobject.y = gameobject.y + (gameobject.vspeed * dt)
    if gameobject.y > 240 then
        gameobject.y = 240
        if gameobject.ground == false then
            gameobject.ground = true
            gameobject.xscale = 1.45
            gameobject.yscale = 0.45
        end
    end
    gameobject.xscale = approach(gameobject.xscale, 1, 0.05)
    gameobject.yscale = approach(gameobject.yscale, 1, 0.05)
end

function gameobject:draw()
    love.graphics.draw(gameobject.image,gameobject.quad, gameobject.x, gameobject.y, 0, gameobject.flip * gameobject.xscale, gameobject.yscale, 16, 32)
    love.graphics.print(gameobject.xscale, 0, 0)
    love.graphics.print(gameobject.yscale, 0, 32)
end