require "gameobject"
--require("utf8")
require "player"
require "utils"
require "map"
require "guardian"
require "gamescreen"
require "checkpoint"
require "powerup"
require "enemy"
require "dolphin"
require "boss"
require "shit"
require "particles"
require "chest"
require "bullet"
require "water"
require "coelho"
require "swordcol"
require "transition"
require "textbox"
require "sword"
require "screenmanager"
require "Screens/menuscreen"
require "Screens/level1screen"
require "Screens/level2screen"
require "Screens/creditsscreen"
require "Screens/languagescreen"
require "365indies"


camera={}
camera.x=0
camera.y=0

global = {}

global.width = 128
global.height = 128
global.language = "pt"

global.write = false
global.senha = ""

scaleX = 4
scaleY = 4

objects={}

finalCutscene = true
global.activeFinalCustscene = false
global.finalBossDialogue = false
global.finalFinalCutscene = false
global.finalFinalCutsceneStart = false
global.finalGuardianDialogue = false
global.finalFinalCutsceneEnd = false

function global:save()
	local file = love.filesystem.newFile("save.sav","w")
	file:write("return { \n")
	file:write("showFirstDialogue = "..tostring(firstDialogue)..",\n")
	file:write("checkpointx = ".. screenmanager.currentScreen.activeSpawn.x..",\n")
	file:write("checkpointy = ".. screenmanager.currentScreen.activeSpawn.y..",\n")
	file:write("candoublejump = ".. tostring(screenmanager.currentScreen.player.candoublejump)..",\n")
	file:write("candash = "..tostring(screenmanager.currentScreen.player.candash)..",\n")
	file:write("firesword = "..tostring(screenmanager.currentScreen.player.firesword)..",\n")
	file:write("nil}")

	--print(screenmanager.currentScreen.activeSpawn.x, screenmanager.currentScreen.activeSpawn.y)
	file:close()
end

function global:loadSave()
	if love.filesystem.exists("save.sav") then
		local file = love.filesystem.load("save.sav")
		local File = file()

		firstDialogue = File.showFirstDialogue
		screenmanager.screens["level1"].activeSpawn.x = File.checkpointx
		screenmanager.screens["level1"].activeSpawn.y = File.checkpointy
		screenmanager.screens["level1"].player.candoublejump = File.candoublejump
		screenmanager.screens["level1"].player.candash = File.candash
		screenmanager.screens["level1"].player.firesword = File.firesword
		screenmanager.screens["level1"].player.x = File.checkpointx
		screenmanager.screens["level1"].player.y = File.checkpointy
	end
end

function global:resetSave()
	if love.filesystem.exists("save.sav") then
		love.filesystem.remove("save.sav")
	end
end

function love.load()
	screenmanager:addScreen("language",language:new())
	screenmanager:addScreen("menu",menu:new())
	screenmanager:addScreen("level1",level1:new())
	screenmanager:addScreen("credits",credits:new())

	love.window.setMode(scaleX*global.width, scaleY*global.height,{resizable = true})

	--[[font = love.graphics.newImageFont("Assets/font-2-love.png"," abcdefghijklmnopqrstuvwxyz" ..
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
    "123456789.,!?-+/():;%&`'*#=[]\"")]]
    font = love.graphics.newFont("Assets/TinyUnicode.ttf",16)
    font:setFilter("nearest","nearest")
    font:setLineHeight(0.6)

	canvas = love.graphics.newCanvas(global.width, global.height)
	canvas:setFilter("nearest","nearest")
	--screenmanager:addScreen("level2",level2:new())
	--print(love.filesystem.getSaveDirectory())
end

function love.update(dt)

	screenmanager:update(dt)
	if screenmanager.currentScreen.map.test ~= nil then
		--camera.x = math.min(0,math.max(camera.x,-(screenmanager.currentScreen.map.test.width*16)+global.width))
		--camera.y = math.min(0,math.max(camera.y,-(screenmanager.currentScreen.map.test.height*16)+global.height))
	end

	scaleX = math.floor(love.graphics:getWidth()/global.width)
	scaleY = math.floor(love.graphics:getHeight()/global.height)

	if scaleX < scaleY then
		scaleY = scaleX
	else
		scaleX = scaleY
	end

	if love.keyboard.isDown("r") then
		global:resetSave()
	end
	if global.write and love.keyboard.isDown("escape") then
		global.write = false
		global.senha = ""
	end
end

function love.draw()
	love.graphics.setCanvas(canvas)
	love.graphics.clear()
	love.graphics.setFont(font)
	love.graphics.push()
	--love.graphics.scale(1/scaleX,1/scaleY)
	screenmanager:draw()
	love.graphics.pop()
	love.graphics.setCanvas()
	love.graphics.draw(canvas,0,0,0,scaleX, scaleY)
end

function love.keypressed(key)
	screenmanager:keypressed(key)
end

function love.textinput(t)
	screenmanager.screens["level1"]:textinput(t)
end