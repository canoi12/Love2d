blocks = {}
bloco = {}

function bloco.load()
    limit = love.graphics.getWidth()/32
    --for i = 0,limit do
    --    newBlock = {x = i*32,y = love.graphics:getHeight()-32,width = 32,height = 32}
    --    table.insert(blocks,newBlock)
    --end
    newBlock = {x = 0,y = love.graphics:getHeight()-32,width = game.roomWidth,height = 32}
    table.insert(blocks,newBlock)
end

function bloco.update()
    
end

function bloco.draw()
    love.graphics.setColor(255,0,0)
    for i,block in ipairs(blocks) do
        love.graphics.rectangle("line",block.x,block.y,block.width,block.height)
    end
end