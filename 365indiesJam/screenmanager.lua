screenmanager={}

screenmanager.currentScreen=nil
screenmanager.screens={}

function screenmanager:addScreen(name, table)
	screenmanager.screens[name]=table
	if screenmanager.currentScreen == nil then
		screenmanager.currentScreen = table
	end
end

function screenmanager:setScreen(name)
	screenmanager.currentScreen = screenmanager.screens[name]
end

function screenmanager:update(dt)
	if screenmanager.currentScreen ~= nil then
		screenmanager.currentScreen:update(dt)
	end
end

function screenmanager:draw()
	if screenmanager.currentScreen ~= nil then
		screenmanager.currentScreen:draw()
	end
end