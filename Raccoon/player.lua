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
    player.speed = 150
    player.width = 32
    player.height = 32
    image = love.graphics.newImage("assets/6Actor_5.png")
    player.frameAtual = 0
    player.frameTime = 0.10
    player.frameTimeInit = 0.07
    --quad = love.graphics.newQuad(0,0,player.width,player.height,image:getDimensions())
    player.anim = {
        idle = {
            up = {},
            down = {},
            left = {},
            right = {}
        },
        walk = {
            up = {
                [0] = love.graphics.newQuad(0,3*player.height,player.width,player.height,image:getDimensions()),
                [1] = love.graphics.newQuad(32,3*player.height,player.width,player.height,image:getDimensions()),
                [2] = love.graphics.newQuad(2*32,3*player.height,player.width,player.height,image:getDimensions()),
                [3] = love.graphics.newQuad(3*32,3*player.height,player.width,player.height,image:getDimensions()),
                [4] = love.graphics.newQuad(4*32,3*player.height,player.width,player.height,image:getDimensions()),
                [5] = love.graphics.newQuad(5*32,3*player.height,player.width,player.height,image:getDimensions())
            },
            upleft = {
                [0] = love.graphics.newQuad(0,6*player.height,player.width,player.height,image:getDimensions()),
                [1] = love.graphics.newQuad(32,6*player.height,player.width,player.height,image:getDimensions()),
                [2] = love.graphics.newQuad(2*32,6*player.height,player.width,player.height,image:getDimensions()),
                [3] = love.graphics.newQuad(3*32,6*player.height,player.width,player.height,image:getDimensions()),
                [4] = love.graphics.newQuad(4*32,6*player.height,player.width,player.height,image:getDimensions()),
                [5] = love.graphics.newQuad(5*32,6*player.height,player.width,player.height,image:getDimensions())
            },
            upright = {
                [0] = love.graphics.newQuad(0,7*player.height,player.width,player.height,image:getDimensions()),
                [1] = love.graphics.newQuad(32,7*player.height,player.width,player.height,image:getDimensions()),
                [2] = love.graphics.newQuad(2*32,7*player.height,player.width,player.height,image:getDimensions()),
                [3] = love.graphics.newQuad(3*32,7*player.height,player.width,player.height,image:getDimensions()),
                [4] = love.graphics.newQuad(4*32,7*player.height,player.width,player.height,image:getDimensions()),
                [5] = love.graphics.newQuad(5*32,7*player.height,player.width,player.height,image:getDimensions())
            },
            down = {
                [0] = love.graphics.newQuad(0,0*player.height,player.width,player.height,image:getDimensions()),
                [1] = love.graphics.newQuad(32,0*player.height,player.width,player.height,image:getDimensions()),
                [2] = love.graphics.newQuad(2*32,0*player.height,player.width,player.height,image:getDimensions()),
                [3] = love.graphics.newQuad(3*32,0*player.height,player.width,player.height,image:getDimensions()),
                [4] = love.graphics.newQuad(4*32,0*player.height,player.width,player.height,image:getDimensions()),
                [5] = love.graphics.newQuad(5*32,0*player.height,player.width,player.height,image:getDimensions())
            },
            downleft = {
               [0] = love.graphics.newQuad(0,4*player.height,player.width,player.height,image:getDimensions()),
                [1] = love.graphics.newQuad(32,4*player.height,player.width,player.height,image:getDimensions()),
                [2] = love.graphics.newQuad(2*32,4*player.height,player.width,player.height,image:getDimensions()),
                [3] = love.graphics.newQuad(3*32,4*player.height,player.width,player.height,image:getDimensions()),
                [4] = love.graphics.newQuad(4*32,4*player.height,player.width,player.height,image:getDimensions()),
                [5] = love.graphics.newQuad(5*32,4*player.height,player.width,player.height,image:getDimensions()) 
            },
            downright = {
               [0] = love.graphics.newQuad(0,5*player.height,player.width,player.height,image:getDimensions()),
                [1] = love.graphics.newQuad(32,5*player.height,player.width,player.height,image:getDimensions()),
                [2] = love.graphics.newQuad(2*32,5*player.height,player.width,player.height,image:getDimensions()),
                [3] = love.graphics.newQuad(3*32,5*player.height,player.width,player.height,image:getDimensions()),
                [4] = love.graphics.newQuad(4*32,5*player.height,player.width,player.height,image:getDimensions()),
                [5] = love.graphics.newQuad(5*32,5*player.height,player.width,player.height,image:getDimensions()) 
            },
            left = {
                [0] = love.graphics.newQuad(0,1*player.height,player.width,player.height,image:getDimensions()),
                [1] = love.graphics.newQuad(32,1*player.height,player.width,player.height,image:getDimensions()),
                [2] = love.graphics.newQuad(2*32,1*player.height,player.width,player.height,image:getDimensions()),
                [3] = love.graphics.newQuad(3*32,1*player.height,player.width,player.height,image:getDimensions()),
                [4] = love.graphics.newQuad(4*32,1*player.height,player.width,player.height,image:getDimensions()),
                [5] = love.graphics.newQuad(5*32,1*player.height,player.width,player.height,image:getDimensions())
            },
            right = {
                [0] = love.graphics.newQuad(0,2*player.height,player.width,player.height,image:getDimensions()),
                [1] = love.graphics.newQuad(32,2*player.height,player.width,player.height,image:getDimensions()),
                [2] = love.graphics.newQuad(2*32,2*player.height,player.width,player.height,image:getDimensions()),
                [3] = love.graphics.newQuad(3*32,2*player.height,player.width,player.height,image:getDimensions()),
                [4] = love.graphics.newQuad(4*32,2*player.height,player.width,player.height,image:getDimensions()),
                [5] = love.graphics.newQuad(5*32,2*player.height,player.width,player.height,image:getDimensions())
            }
        }
    }
    player.animAtual = player.anim.walk.up
end

function player.update(dt)
    player.x = player.x + ((bool2int(love.keyboard.isDown("right"))-bool2int(love.keyboard.isDown("left")))*(player.speed*dt))
    player.y = player.y + ((bool2int(love.keyboard.isDown("down"))-bool2int(love.keyboard.isDown("up")))*(player.speed*dt))
    player.frameTime = player.frameTime - 0.01
    if player.frameAtual < table.getn(player.animAtual) and player.frameTime <= 0 then
        player.frameAtual = player.frameAtual + 1
        player.frameTime = player.frameTimeInit
    elseif player.frameAtual >= table.getn(player.animAtual) and player.frameTime <= 0 then
        player.frameAtual = 0
        player.frameTime = player.frameTimeInit
    end
    if love.keyboard.isDown("down") then
        if love.keyboard.isDown("left") then
            player.animAtual = player.anim.walk.downleft
        elseif love.keyboard.isDown("right") then
            player.animAtual = player.anim.walk.downright
        else
            player.animAtual = player.anim.walk.down
        end
    elseif love.keyboard.isDown("up") then
        if love.keyboard.isDown("left") then
            player.animAtual = player.anim.walk.upleft
        elseif love.keyboard.isDown("right") then
            player.animAtual = player.anim.walk.upright
        else
            player.animAtual = player.anim.walk.up
        end
    elseif love.keyboard.isDown("left") then
        player.animAtual = player.anim.walk.left
    elseif love.keyboard.isDown("right") then
        player.animAtual = player.anim.walk.right
    else
        player.frameAtual = 0    
    end
end

function player.draw()
    love.graphics.draw(image,player.animAtual[player.frameAtual],player.x,player.y)
    love.graphics.print(player.frameAtual,0,0)
end