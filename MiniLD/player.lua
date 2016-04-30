nave = {}

function nave.load()
    nave.piloto = 2
    nave.x = 0
    nave.y = 0
    
    nave.speed = 250
    
    nave.frameAtual = 0
    nave.frameTime = 0.10
    nave.frameTimeInit = 0.07
    
    nave.anim = {
        inicio = {
            
            
        },
        jogo = {
            
        }
    }
    nave.anim.inicio[0] = {
        image = love.graphics.newImage("assets/nave player/shot ship.png"),
    }
    nave.anim.inicio[0].frames = {
        [0] = love.graphics.newQuad(0,0,80,80,nave.anim.inicio[0].image:getDimensions()),
        [1] = love.graphics.newQuad(0,80,80,80,nave.anim.inicio[0].image:getDimensions()),
        [2] = love.graphics.newQuad(0,160,80,80,nave.anim.inicio[0].image:getDimensions()) 
    }
    
    
    nave.anim.inicio[1] = {
        image = love.graphics.newImage("assets/nave player/shot ship2.png"),
    }
    nave.anim.inicio[1].frames = {
        [0] = love.graphics.newQuad(0,0,80,80,nave.anim.inicio[1].image:getDimensions()),
        [1] = love.graphics.newQuad(0,80,80,80,nave.anim.inicio[1].image:getDimensions()),
        [2] = love.graphics.newQuad(0,160,80,80,nave.anim.inicio[1].image:getDimensions()) 
    }
    
    nave.anim.inicio[2] = {
        image = love.graphics.newImage("assets/nave player/shot ship3.png"),
    }
    nave.anim.inicio[2].frames = {
        [0] = love.graphics.newQuad(0,0,80,80,nave.anim.inicio[2].image:getDimensions()),
        [1] = love.graphics.newQuad(0,80,80,80,nave.anim.inicio[2].image:getDimensions()),
        [2] = love.graphics.newQuad(0,160,80,80,nave.anim.inicio[2].image:getDimensions()) 
    }
    
    nave.anim.jogo[0] = {
        image = love.graphics.newImage("assets/nave player/nave player.png"),
    }
    nave.anim.jogo[0].frames = {
        [0] = love.graphics.newQuad(0,0,80,80,nave.anim.jogo[0].image:getDimensions()),
        [1] = love.graphics.newQuad(0,80,80,80,nave.anim.jogo[0].image:getDimensions()),
        [2] = love.graphics.newQuad(0,160,80,80,nave.anim.jogo[0].image:getDimensions()) 
    }
    
    nave.anim.jogo[1] = {
        image = love.graphics.newImage("assets/nave player/nave player2.png"),
    }
    nave.anim.jogo[1].frames = {
        [0] = love.graphics.newQuad(0,0,80,80,nave.anim.jogo[1].image:getDimensions()),
        [1] = love.graphics.newQuad(0,80,80,80,nave.anim.jogo[1].image:getDimensions()),
        [2] = love.graphics.newQuad(0,160,80,80,nave.anim.jogo[1].image:getDimensions()) 
    }
    
    nave.anim.jogo[2] = {
        image = love.graphics.newImage("assets/nave player/nave player3(2).png"),
    }
    nave.anim.jogo[2].frames = {
        [0] = love.graphics.newQuad(0,0,80,80,nave.anim.jogo[2].image:getDimensions()),
        [1] = love.graphics.newQuad(0,80,80,80,nave.anim.jogo[2].image:getDimensions()),
        [2] = love.graphics.newQuad(0,160,80,80,nave.anim.jogo[2].image:getDimensions()) 
    }
    nave.animAtual = nave.anim.inicio[0].frames
    nave.imageAtual = nave.anim.inicio[0]
    nave.imageAtual.image:setFilter("nearest","nearest")
end

function nave.update(dt)
    if game.currentScreen == "canhao" then
        nave.frameTime = nave.frameTime - 0.01
        if nave.frameAtual < table.getn(nave.animAtual) and nave.frameTime <= 0 then
            nave.frameAtual = nave.frameAtual + 1
            nave.frameTime = nave.frameTimeInit
        elseif nave.frameAtual >= table.getn(nave.animAtual) and nave.frameTime <= 0 then
            nave.frameAtual = 0
            nave.frameTime = nave.frameTimeInit
        end
    end
    
    if game.currentScreen == "canhao" then
        nave.animAtual = nave.anim.inicio[nave.piloto].frames
    elseif game.currentScreen == "jogo" then
        nave.animAtual = nave.anim.jogo[nave.piloto].frames
        nave.imageAtual = nave.anim.jogo[nave.piloto]
        if love.keyboard.isDown("up") then
            nave.frameAtual = 0
        elseif love.keyboard.isDown("down") then
            nave.frameAtual = 2
        else
            nave.frameAtual = 1
        end
        
        nave.x = nave.x + ((nave.speed*dt)*(toint(love.keyboard.isDown("right"))-toint(love.keyboard.isDown("left"))))
        nave.y = nave.y + ((nave.speed*dt)*(toint(love.keyboard.isDown("down"))-toint(love.keyboard.isDown("up"))))
   
        nave.x = math.clamp(nave.x,0,game.roomWidth-80)
        nave.y = math.clamp(nave.y,50,game.roomHeight-80)
        
    end
    
end

function nave.draw()
    love.graphics.draw(nave.imageAtual.image,nave.animAtual[nave.frameAtual],nave.x,nave.y,0,1,1,
    40,40)
end