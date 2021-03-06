tabela = {}
tabuleiro = {}

function tabela.find(tab,i,j,v1,n,m)
    if v1 ~= 0 then
        return tabela.find2(tab,i,j,v1,n,m)
    end
    return 1
end

function tabela.find2(tab,i,j,v1,n,m)
    if tab[i][j] == v1 then
        tab[i][j] = 0
        if i + 1 <= n then
            tabela.find2(tab,i+1,j,v1,n,m)
        end
        if j + 1 <= m then
            tabela.find2(tab,i,j+1,v1,n,m)
        end
        if i - 1 > 0 then
            tabela.find2(tab,i-1,j,v1,n,m)
        end
        if j - 1 > 0 then
            tabela.find2(tab,i,j-1,v1,n,m)      
        end
        return 1
    else
        return 0
    end
end

function tabela.org(tab)
    for i,x in ipairs(tab) do
        for j,y in ipairs(x) do
            if tab[i][j+1] == 0 then
                tab[i][j+1] = tab[i][j]
                tab[i][j] = 0
            end
        end
    end
end

function tabela.add(tab)
    for i,x in ipairs(tab) do
        if tab[i][1] == 0 then
            tab[i][1] = math.random(3)
        end
    end
end

function tabela.load()
    n = 5
    m = 7
    math.randomseed(os.time())
    for i=1,n do
        tabuleiro[i] = {}
        for j=1,m do
            tabuleiro[i][j] = math.random(3)
        end
    end
    tabela.width = love.graphics.getWidth()/n
    tabela.height = love.graphics.getHeight()/m
    
    tabela.image = love.graphics.newImage("assets/icones.png")
    tabela.selimage = love.graphics.newImage("assets/selecao.png")
    tabela.imgWidth = 65
    tabela.imgHeight = 65
    
    tabela.quad = {
        [0] = love.graphics.newQuad(-32,-32,32,32,tabela.image:getDimensions()),
        [1] = love.graphics.newQuad(0,0,tabela.imgWidth,tabela.imgHeight,tabela.image:getDimensions()),
        [2] = love.graphics.newQuad(tabela.imgWidth,0,tabela.imgWidth,tabela.imgHeight,tabela.image:getDimensions()),
        [3] = love.graphics.newQuad(tabela.imgWidth*2,0,tabela.imgWidth,tabela.imgHeight,tabela.image:getDimensions())
    }
end

function tabela.update(dt)
    --tabela.add(tabuleiro)
    tabela.org(tabuleiro)
end

function tabela.draw()
    mousex = math.floor(love.mouse.getX()/tabela.width)
    mousey = math.floor(love.mouse.getY()/tabela.height)
    love.graphics.setColor(255,255,255)
    for i=1,n do
        for j=1,m do
            love.graphics.draw(tabela.image,tabela.quad[tabuleiro[i][j]],tabela.width*(i-1),tabela.height*(j-1))
        end
    end
    
    love.graphics.draw(tabela.selimage,mousex*tabela.width,mousey*tabela.height)
    
    love.graphics.print(mousex,0,0)
    love.graphics.print(mousey,0,20)
end

function tabela.mousepressed(x,y,bt)
    if bt == 1 then
        local mx = x
        local my = y
        local px = math.floor(mx/tabela.width)+1
        local py = math.floor(my/tabela.height)+1
        tabela.find(tabuleiro,px,py,tabuleiro[px][py],n,m)
    end
end