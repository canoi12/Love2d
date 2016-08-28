local screenmanager = {}

screenmanager.actualScreen = nil
screenmanager.screens={}

function screenmanager:addScreen(name,screen)
	self.screens[name] = screen
	if self.actualScreen == nil then
		self.actualScreen = screen
		screen:load()
	end
end

function screenmanager:changeLoading(name)
	self.actualScreen = self.screens[name]
	self.actualScreen:load()
end

function screenmanager:changeScreen(name)
	self.actualScreen = self.screens[name]
end

function screenmanager:update(dt)
	if self.actualScreen ~=  nil then
		self.actualScreen:update(dt)
	end
end

function screenmanager:draw()
	if self.actualScreen ~=  nil then
		self.actualScreen:draw()
	end
end

return screenmanager