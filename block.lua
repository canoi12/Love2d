blocks = {}
bloco = {}

function bloco.load()
    for i = 0,10 do
        newBlock = {x = i*32,y = love.graphics:getHeight()-32,width = 32,height = 32}
        table.insert(blocks,newBlock)
    end
end

function bloco.update()
    
end

function bloco.draw()
    love.graphics.setColor(255,0,0)
    for i,block in ipairs(blocks) do
        love.graphics.rectangle("line",block.x,block.y,block.width,block.height)
    end
end