require "player"
require "camera"
require "bullet"
require "enemy"

game = {}
game.roomWidth = 1280
game.roomHeight = 960
game.windowWidth = 640
game.windowHeight = 480

function math.clamp(v1,v2,v3)
    if v1 < v2 then
        return v2
    elseif v1 > v3 then
        return v3
    end
    return v1
end

function math.lerp(v1,v2,v3)
    return v1 + v3*(v2-v1)
end

function distance(x1,y1,x2,y2)
    return math.sqrt(((x1-x2)*(x1-x2))+((y1-y2)*(y1-y2)))
end


function love.load()
    player.load()
    
    game.background = love.graphics.newImage("assets/background.png")
    game.background:setWrap("repeat","repeat")
    
    game.bgquad = love.graphics.newQuad(0,0,game.roomWidth,game.roomHeight,game.background:getDimensions())
    
    i = 0
    
    shader = love.graphics.newShader[[
        extern number i;
        vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords){
            texture_coords.x = texture_coords.x + sin(texture_coords.y*20.0+i)/30.0;
            texture_coords.y = texture_coords.y + cos(texture_coords.x*20.0+i)/30.0;
            vec4 pixel = Texel(texture, texture_coords);
            return pixel*color;
        }
    ]]
    
    local img = love.graphics.newImage("assets/circle.png")
    
    psystem = love.graphics.newParticleSystem(img,32)
    
    psystem:setParticleLifetime(2,5)
    psystem:setEmissionRate(5)
    psystem:setSizeVariation(1)
    psystem:setLinearAcceleration(10,10,12,12)
    psystem:setColors(255,255,255,255,255,255,255,0)
    psystem:setSpeed(2,3)
    
    
    bullet.load()
    enemy.load()
end

function love.update(dt)
    player.update(dt)
    camera.x = math.lerp(camera.x,math.clamp(player.x - (game.windowWidth/2),0,game.roomWidth-game.windowWidth),0.1)
    camera.y = math.lerp(camera.y,math.clamp(player.y - (game.windowHeight/2),0,game.roomHeight-game.windowHeight),0.1)
    bullet.update(dt)
    enemy.update(dt)
    i = i + 0.1
    if i%(math.pi*2) == 0 then
        i = 0
    end
    shader:send("i",i)
    psystem:update(dt)
end

function love.draw()
    camera.set()
    love.graphics.setShader(shader)
    love.graphics.draw(game.background,game.bgquad,0,0)
    love.graphics.setShader()
    for i, b in ipairs(bullets) do
        love.graphics.draw(psystem,b.x,b.y)
        psystem:setLinearAcceleration(-b.dx,-b.dy,-b.dx,-b.dy)
    end
    player.draw()
    love.graphics.print(player.x,0,0)
    bullet.draw()
    enemy.draw()
    camera.unset()
end

function love.keypressed(key)
    bullet.keypressed(key)
end