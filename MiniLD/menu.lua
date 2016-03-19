menu = {}
text = {}

function menu.load()
    i = 0
    text.x = game.windowWidth/2
    text.y = game.windowHeight/2
    menu.opcoes = {
        "Iniciar",
        "Sair"
    }
    opcao = 0
    love.graphics.newFont()
end

function menu.update(dt)
    i = i + 0.05
    if i%(math.pi*2) == 0 then
        i = 0
    end
    text.y = text.y + math.sin(i)
    
    if love.keyboard.isDown("space") then
        game.currentScreen = "canhao"
    end
end

function menu.draw()
    love.graphics.print("Game Title",game.windowWidth/2,text.y,0,2,2)
    for i, op in ipairs(menu.opcoes) do
        love.graphics.print(op,game.windowWidth/2,game.windowHeight/2+50+(50*i))
    end
end