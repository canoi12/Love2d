player = {}

function bool2int(valor)
    if valor then
        return 1
    end
    return 0
end

function player.load()
    player.x = 320
    player.y = 240
    player.speed = 250
    player.width = 56
    player.height = 56
    image = love.graphics.newImage("assets/arshes13.png")
    --quad = love.graphics.newQuad(0,0,player.width,player.height,image:getDimensions())
    player.anim = {
        idle = {
            up = {
                [0] = love.graphics.newQuad(0,3*56,player.width,player.height,image:getDimensions()),
                [1] = love.graphics.newQuad(56,3*56,player.width,player.height,image:getDimensions()),
                [2] = love.graphics.newQuad(2*56,3*56,player.width,player.height,image:getDimensions()),
                [3] = love.graphics.newQuad(3*56,3*56,player.width,player.height,image:getDimensions())
            },
            down = {},
            left = {},
            right = {}
        },
        walk = {
            up = {},
            down = {},
            left = {},
            right = {}
        }
    }
    player.animAtual = player.anim.idle.up
    player.frameAtual = 0
    player.frameTime = 0.10
end

function player.update(dt)
    player.x = player.x + ((bool2int(love.keyboard.isDown("right"))-bool2int(love.keyboard.isDown("left")))*(player.speed*dt))
    player.y = player.y + ((bool2int(love.keyboard.isDown("down"))-bool2int(love.keyboard.isDown("up")))*(player.speed*dt))
    player.frameTime = player.frameTime - 0.01
    if player.frameAtual < table.getn(player.animAtual) and player.frameTime <= 0 then
        player.frameAtual = player.frameAtual + 1
        player.frameTime = 0.10
    elseif player.frameAtual >= table.getn(player.animAtual) and player.frameTime <= 0 then
        player.frameAtual = 0
        player.frameTime = 0.10
    end
end

function player.draw()
    love.graphics.draw(image,player.animAtual[player.frameAtual],player.x,player.y)
end