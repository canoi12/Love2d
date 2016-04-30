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
    player.width = 32
    player.height = 32
    player.image = love.graphics.newImage("assets/6Actor_5.png")
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
                [0] = love.graphics.newQuad(0,3*player.height,player.width,player.height,player.image:getDimensions()),
                [1] = love.graphics.newQuad(32,3*player.height,player.width,player.height,player.image:getDimensions()),
                [2] = love.graphics.newQuad(2*player.width,3*player.height,player.width,player.height,player.image:getDimensions()),
                [3] = love.graphics.newQuad(3*player.width,3*player.height,player.width,player.height,player.image:getDimensions()),
                [4] = love.graphics.newQuad(4*player.width,3*player.height,player.width,player.height,player.image:getDimensions()),
                [5] = love.graphics.newQuad(5*player.width,3*player.height,player.width,player.height,player.image:getDimensions())
            },
            upleft = {
                [0] = love.graphics.newQuad(0,6*player.height,player.width,player.height,player.image:getDimensions()),
                [1] = love.graphics.newQuad(32,6*player.height,player.width,player.height,player.image:getDimensions()),
                [2] = love.graphics.newQuad(2*player.width,6*player.height,player.width,player.height,player.image:getDimensions()),
                [3] = love.graphics.newQuad(3*player.width,6*player.height,player.width,player.height,player.image:getDimensions()),
                [4] = love.graphics.newQuad(4*player.width,6*player.height,player.width,player.height,player.image:getDimensions()),
                [5] = love.graphics.newQuad(5*player.width,6*player.height,player.width,player.height,player.image:getDimensions())
            },
            upright = {
                [0] = love.graphics.newQuad(0,7*player.height,player.width,player.height,player.image:getDimensions()),
                [1] = love.graphics.newQuad(32,7*player.height,player.width,player.height,player.image:getDimensions()),
                [2] = love.graphics.newQuad(2*player.width,7*player.height,player.width,player.height,player.image:getDimensions()),
                [3] = love.graphics.newQuad(3*player.width,7*player.height,player.width,player.height,player.image:getDimensions()),
                [4] = love.graphics.newQuad(4*player.width,7*player.height,player.width,player.height,player.image:getDimensions()),
                [5] = love.graphics.newQuad(5*player.width,7*player.height,player.width,player.height,player.image:getDimensions())
            },
            down = {
                [0] = love.graphics.newQuad(0,0*player.height,player.width,player.height,player.image:getDimensions()),
                [1] = love.graphics.newQuad(32,0*player.height,player.width,player.height,player.image:getDimensions()),
                [2] = love.graphics.newQuad(2*player.width,0*player.height,player.width,player.height,player.image:getDimensions()),
                [3] = love.graphics.newQuad(3*player.width,0*player.height,player.width,player.height,player.image:getDimensions()),
                [4] = love.graphics.newQuad(4*player.width,0*player.height,player.width,player.height,player.image:getDimensions()),
                [5] = love.graphics.newQuad(5*player.width,0*player.height,player.width,player.height,player.image:getDimensions())
            },
            downleft = {
               [0] = love.graphics.newQuad(0,4*player.height,player.width,player.height,player.image:getDimensions()),
                [1] = love.graphics.newQuad(32,4*player.height,player.width,player.height,player.image:getDimensions()),
                [2] = love.graphics.newQuad(2*player.width,4*player.height,player.width,player.height,player.image:getDimensions()),
                [3] = love.graphics.newQuad(3*player.width,4*player.height,player.width,player.height,player.image:getDimensions()),
                [4] = love.graphics.newQuad(4*player.width,4*player.height,player.width,player.height,player.image:getDimensions()),
                [5] = love.graphics.newQuad(5*player.width,4*player.height,player.width,player.height,player.image:getDimensions()) 
            },
            downright = {
               [0] = love.graphics.newQuad(0,5*player.height,player.width,player.height,player.image:getDimensions()),
                [1] = love.graphics.newQuad(32,5*player.height,player.width,player.height,player.image:getDimensions()),
                [2] = love.graphics.newQuad(2*player.width,5*player.height,player.width,player.height,player.image:getDimensions()),
                [3] = love.graphics.newQuad(3*player.width,5*player.height,player.width,player.height,player.image:getDimensions()),
                [4] = love.graphics.newQuad(4*player.width,5*player.height,player.width,player.height,player.image:getDimensions()),
                [5] = love.graphics.newQuad(5*player.width,5*player.height,player.width,player.height,player.image:getDimensions()) 
            },
            left = {
                [0] = love.graphics.newQuad(0,1*player.height,player.width,player.height,player.image:getDimensions()),
                [1] = love.graphics.newQuad(32,1*player.height,player.width,player.height,player.image:getDimensions()),
                [2] = love.graphics.newQuad(2*player.width,1*player.height,player.width,player.height,player.image:getDimensions()),
                [3] = love.graphics.newQuad(3*player.width,1*player.height,player.width,player.height,player.image:getDimensions()),
                [4] = love.graphics.newQuad(4*player.width,1*player.height,player.width,player.height,player.image:getDimensions()),
                [5] = love.graphics.newQuad(5*player.width,1*player.height,player.width,player.height,player.image:getDimensions())
            },
            right = {
                [0] = love.graphics.newQuad(0,2*player.height,player.width,player.height,player.image:getDimensions()),
                [1] = love.graphics.newQuad(32,2*player.height,player.width,player.height,player.image:getDimensions()),
                [2] = love.graphics.newQuad(2*player.width,2*player.height,player.width,player.height,player.image:getDimensions()),
                [3] = love.graphics.newQuad(3*player.width,2*player.height,player.width,player.height,player.image:getDimensions()),
                [4] = love.graphics.newQuad(4*player.width,2*player.height,player.width,player.height,player.image:getDimensions()),
                [5] = love.graphics.newQuad(5*player.width,2*player.height,player.width,player.height,player.image:getDimensions())
            }
        }
    }
    player.animAtual = player.anim.walk.up
    player.angle = 0
end

function player.update(dt)
    player.x = player.x + ((bool2int(love.keyboard.isDown("d"))-bool2int(love.keyboard.isDown("a")))*(player.speed*dt))
    player.y = player.y + ((bool2int(love.keyboard.isDown("s"))-bool2int(love.keyboard.isDown("w")))*(player.speed*dt))
    player.x = math.clamp(player.x,0,game.roomWidth-player.width)
    player.y = math.clamp(player.y,0,game.roomHeight-player.height)
    player.frameTime = player.frameTime - 0.01
    if player.frameAtual < table.getn(player.animAtual) and player.frameTime <= 0 then
        player.frameAtual = player.frameAtual + 1
        player.frameTime = player.frameTimeInit
    elseif player.frameAtual >= table.getn(player.animAtual) and player.frameTime <= 0 then
        player.frameAtual = 0
        player.frameTime = player.frameTimeInit
    end
    if love.keyboard.isDown("s") then
        if love.keyboard.isDown("a") then
            player.animAtual = player.anim.walk.downleft
        elseif love.keyboard.isDown("d") then
            player.animAtual = player.anim.walk.downright
        else
            player.animAtual = player.anim.walk.down
        end
    elseif love.keyboard.isDown("w") then
        if love.keyboard.isDown("a") then
            player.animAtual = player.anim.walk.upleft
        elseif love.keyboard.isDown("d") then
            player.animAtual = player.anim.walk.upright
        else
            player.animAtual = player.anim.walk.up
        end
    elseif love.keyboard.isDown("a") then
        player.animAtual = player.anim.walk.left
    elseif love.keyboard.isDown("d") then
        player.animAtual = player.anim.walk.right
    else
        player.frameAtual = 0    
    end
    
    if love.keyboard.isDown("left") or love.keyboard.isDown("right") then
        player.angle = 180*(bool2int(love.keyboard.isDown("left")))*math.pi/180
    end    
    
    if love.keyboard.isDown("down") or love.keyboard.isDown("up") then
        player.angle = (90+(180*(bool2int(love.keyboard.isDown("up")))))*math.pi/180
    end
    
    angle = math.atan2(player.y-love.mouse.getY() - camera.y,player.x-love.mouse.getX() - camera.x)+1.3
    
    player.dx = 2 * math.cos(angle)
    player.dy = 2 * math.sin(angle)
end

function player.draw()
    love.graphics.draw(player.image,player.animAtual[player.frameAtual],player.x,player.y,0,1,1,16,16)
    love.graphics.print(table.getn(bullets),player.x,player.y)
end