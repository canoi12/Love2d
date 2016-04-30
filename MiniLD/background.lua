background = {}

function background.load()
    background.ceu = 
    {
        image = love.graphics.newImage("assets/cenarios/céu/céu-dia.png"),
        xspeed = -2,
        x = 0,
        y = 0
    }
    background.ceu.width = background.ceu.image:getWidth()
    background.ceu.height = background.ceu.image:getHeight()
    
    background.ceu.image:setWrap("repeat","repeat")
    
    background.gun = {
        image = love.graphics.newImage("assets/cenarios/background/gun1.png"),
        x = 0,
        y = 0
    }
    
    background.nuvens_dia = 
    {
        {
            image = love.graphics.newImage("assets/cenarios/nuvens/nuvens dia 1.png"),
            x = 0,
            y = 0,
            xspeed = -1
        },
        {
            image = love.graphics.newImage("assets/cenarios/nuvens/nuvens dia 2.png"),
            x = 0,
            y = 0,
            xspeed = -2
        }
    }
    
    background.agua_dia = 
    {
        {
            image = love.graphics.newImage("assets/cenarios/agua/agua dia 1.png"),
            x = 0,
            y = 346,
            xspeed = -6
        },
        {
            image = love.graphics.newImage("assets/cenarios/agua/agua dia 2.png"),
            x = 0,
            y = 321,
            xspeed = -4
        },
        {
            image = love.graphics.newImage("assets/cenarios/agua/agua dia 3.png"),
            x = 0,
            y = 292,
            xspeed = -3
        },
        {
            image = love.graphics.newImage("assets/cenarios/agua/agua dia 4.png"),
            x = 0,
            y = 266,
            xspeed = -2
        }
    }
    
    for i, back in ipairs(background.nuvens_dia) do
        back.width = back.image:getWidth()
        back.height = back.image:getHeight()
        back.image:setWrap("repeat")
    end
    
    for i, back in ipairs(background.agua_dia) do
        back.width = back.image:getWidth()
        back.height = back.image:getHeight()
        back.bgquad = love.graphics.newQuad(0,0,game.roomWidth,game.roomHeight,back.image:getDimensions())
        back.image:setWrap("repeat","clampzero")
    end
    
    background.bgquad = love.graphics.newQuad(0,0,game.roomWidth,game.roomHeight,background.ceu.image:getDimensions())
    background.x = 0
end

function background.update(dt)
    background.ceu.x = background.ceu.x + background.ceu.xspeed
    if background.ceu.x < -background.ceu.width then
        background.ceu.x = 0
    end
    for i, back in ipairs(background.nuvens_dia) do
        back.x = back.x + back.xspeed
        if back.x < -back.width then
            back.x = 0
        end
    end
    
    for i, back in ipairs(background.agua_dia) do
        back.x = back.x + back.xspeed
        if back.x < -back.width then
            back.x = 0
        end
    end
end

function background.draw()
    love.graphics.draw(background.ceu.image,background.bgquad,background.ceu.x,0)
    love.graphics.draw(background.ceu.image,background.bgquad,background.ceu.x+720,0)
    
    for i, back in ipairs(background.nuvens_dia) do
        love.graphics.draw(back.image,back.x,back.y,0,1,1)
        love.graphics.draw(back.image,back.x+back.width,back.y,0,1,1)
    end
    
    for i, back in ipairs(background.agua_dia) do
        love.graphics.draw(back.image,back.bgquad,back.x,back.y,0,1,1)
        love.graphics.draw(back.image,back.bgquad,back.x+back.width,back.y,0,1,1)
    end
end