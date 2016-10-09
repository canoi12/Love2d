local chip8 = {}

chip8.opcode = 0
chip8.memory = {}
chip8.V = {}
chip8.I = 0
chip8.pc = 0x200
chip8.gfx = {}

chip8.delay_timer = 0
chip8.sound_timer = 0

chip8.stack = {}
chip8.sp = 0

chip8.drawFlag = true

chip8.key = {}

opcodes = {}

chip8_fontset =
{ 
  0xF0, 0x90, 0x90, 0x90, 0xF0, -- 0
  0x20, 0x60, 0x20, 0x20, 0x70, -- 1
  0xF0, 0x10, 0xF0, 0x80, 0xF0, -- 2
  0xF0, 0x10, 0xF0, 0x10, 0xF0, -- 3
  0x90, 0x90, 0xF0, 0x10, 0x10, -- 4
  0xF0, 0x80, 0xF0, 0x10, 0xF0, -- 5
  0xF0, 0x80, 0xF0, 0x90, 0xF0, -- 6
  0xF0, 0x10, 0x20, 0x40, 0x40, -- 7
  0xF0, 0x90, 0xF0, 0x90, 0xF0, -- 8
  0xF0, 0x90, 0xF0, 0x10, 0xF0, -- 9
  0xF0, 0x90, 0xF0, 0x90, 0x90, -- A
  0xE0, 0x90, 0xE0, 0x90, 0xE0, -- B
  0xF0, 0x80, 0x80, 0x80, 0xF0, -- C
  0xE0, 0x90, 0x90, 0x90, 0xE0, -- D
  0xF0, 0x80, 0xF0, 0x80, 0xF0, -- E
  0xF0, 0x80, 0xF0, 0x80, 0x80  -- F
};

function opcodesConf()
	function func_0x0000()
		if bit.band(chip8.opcode, 0x00FF) == 0x00E0 then
			for i=0,4095 do
				chip8.gfx[i] = 0
			end
			chip8.pc = chip8.pc + 2
		elseif bit.band(chip8.opcode, 0x00FF) == 0x00EE then
			chip8.pc = chip8.stack[chip8.sp]
			chip8.sp = chip8.sp - 1
		end
	end

	function func_0x1000()
		chip8.pc = bit.band(chip8.opcode, 0x0FFF)
	end

	function func_0x2000()
		chip8.stack[chip8.sp] = chip8.pc
		chip8.sp = chip8.sp + 1
		chip8.pc = bit.band(chip8.opcode[chip8.pc], 0x0FFF)
	end

	function func_0x3000()
		if chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00),8)] == bit.band(chip8.opcode, 0x00FF) then
			chip8.pc = chip8.pc + 4
		else
			chip8.pc = chip8.pc + 2
		end
	end

	function func_0x4000()
		if chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00),8)] ~= bit.band(chip8.opcode, 0x00FF) then
			chip8.pc = chip8.pc + 4
		else
			chip8.pc = chip8.pc + 2
		end
	end

	function func_0x5000()
		if chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00),8)] == chip8.V[bit.rshift(bit.band(chip8.opcode, 0x00F0),4)] then
			chip8.pc = chip8.pc + 4
		else
			chip8.pc = chip8.pc + 2
		end
	end

	function func_0x6000()
		chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00),8)] = bit.band(chip8.opcode, 0x00FF)
	end

	function func_0x7000()
		chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00),8)] = chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00),8)] + bit.band(chip8.opcode, 0x00FF)
	end

	function func_0x8000()
		if bit.band(chip8.opcode, 0x000F) == 0x0000 then
			chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00),8)] = chip8.V[bit.rshift(bit.band(chip8.opcode, 0x00F0),4)]	
		elseif bit.band(chip8.opcode, 0x000F) == 0x0001 then
			chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00),8)] = bit.bor(chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00),8)], chip8.V[bit.rshift(bit.band(chip8.opcode, 0x00F0),4)])
		elseif bit.band(chip8.opcode, 0x000F) == 0x0002 then
			chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00),8)] = bit.band(chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00),8)], chip8.V[bit.rshift(bit.band(chip8.opcode, 0x00F0),4)])
		elseif bit.band(chip8.opcode, 0x000F) == 0x0003 then
			chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00),8)] = bit.bxor(chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00),8)], chip8.V[bit.rshift(bit.band(chip8.opcode, 0x00F0),4)])
		elseif bit.band(chip8.opcode, 0x000F) == 0x0004 then
			if chip8.V[bit.rshift(bit.band(chip8.opcode, 0x00F0),4)] > ( 0xFF - chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00),8)]) then
				chip8.V[0xF] = 1
			else
				chip8.V[0xF] = 0
			end
			chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00),8)] = chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00),8)] + chip8.V[bit.rshift(bit.band(chip8.opcode, 0x00F0),4)]
			chip8.pc = chip8.pc + 2
		elseif bit.band(chip8.opcode, 0x000F) == 0x0005 then
			if chip8.V[bit.rshift(bit.band(chip8.opcode, 0x00F0),4)] > (chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00),8)]) then
				chip8.V[0xF] = 0
			else
				chip8.V[0xF] = 1
			end
			chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00),8)] = chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00),8)] - chip8.V[bit.rshift(bit.band(chip8.opcode, 0x00F0),4)]
			chip8.pc = chip8.pc + 2
		elseif bit.band(chip8.opcode, 0x000F) == 0x0006 then
			chip8.V[0xF] = bit.band(chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00), 8)], 0x1)
			chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00), 8)] = bit.rshift(chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00), 8)], 1)
			chip8.pc = chip8.pc + 2
		elseif bit.band(chip8.opcode, 0x000F) == 0x0007 then
			if chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00),8)] > (chip8.V[bit.rshift(bit.band(chip8.opcode, 0x00F0),4)]) then
				chip8.V[0xF] = 0
			else
				chip8.V[0xF] = 1
			end
			chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00),8)] = chip8.V[bit.rshift(bit.band(chip8.opcode, 0x00F0),4)] - chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00),8)]
			chip8.pc = chip8.pc + 2
		elseif bit.band(chip8.opcode, 0x000F) == 0x000E then	
			chip8.V[0xF] = bit.rshift(chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00), 8)], 7)
			chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00), 8)] = bit.lshift(chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00), 8)], 1)
			chip8.pc = chip8.pc + 2
		end
	end

	function func_0x9000()
		if chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00), 8)] ~= chip8.V[bit.rshift(bit.band(chip8.opcode, 0x00F0), 4)] then
			chip8.pc = chip8.pc + 4
		else
			chip8.pc = chip8.pc + 2
		end
	end

	function func_0xA000()
		chip8.I = bit.band(chip8.opcode, 0x0FFF)
		chip8.pc = chip8.pc + 2
	end

	function func_0xB000()
		chip8.pc = bit.band(chip8.opcode, 0x0FFF) + chip8.V[0x0]
	end

	function func_0xC000()
		chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00), 8)] = bit.band(chip8.opcode, 0x00FF)
		chip8.pc = chip8.pc + 2
	end

	function func_0xD000()
		local x = chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00), 8)]
		local y = chip8.V[bit.rshift(bit.band(chip8.opcode, 0x00F0), 4)]
		local height = chip8.V[bit.band(chip8.opcode, 0x000F)]
		local pixel = 0

		chip8.V[0xF] = 0
		for yline=0, height-1 do
			pixel = chip8.memory[chip8.I + yline]
			for xline = 0, 7 do
				if ((bit.band(pixel, bit.rshift(0x80, xline))) ~= 0) then
					if chip8.gfx[(x+xline((y+yline)*64))] == 1 then
						chip8.V[0xF] = 1
					end
					chip8.gfx[x + xline + ((y + yline) * 64)] = bit.bxor(chip8.gfx[x + xline + ((y + yline) * 64)], 1)
				end
			end
		end

		chip8.drawFlag = true
		chip8.pc = chip8.pc + 2
	end

	function func_0xE000()
		if bit.band(chip8.opcode, 0x00FF) == 0x009E then
			if chip8.key[chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00), 8)]] ~= 0 then
				chip8.pc = chip8.pc + 4
			else
				chip8.pc = chip8.pc + 2
			end
		elseif bit.band(chip8.opcode, 0x00FF) == 0x00A1 then
			if chip8.key[chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00), 8)]] == 0 then
				chip8.pc = chip8.pc + 4
			else
				chip8.pc = chip8.pc + 2
			end
		end
	end

	function func_0xF000()
		if bit.band(chip8.opcode, 0x00FF) == 0x0007 then
			chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00), 8)] = chip8.delay_timer
			chip8.pc = chip8.pc + 2
		elseif bit.band(chip8.opcode, 0x00FF) == 0x000A then
			keyPress = false
            for i = 0,15 do
                if (chip8.key[i] ~= 0) then
                    chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00), 8)] = i;
                    keyPress = true;
                end
            end
            if not(keyPress) then
                return 1
            end
            chip8.pc = chip8.pc + 2
		elseif bit.band(chip8.opcode, 0x00FF) == 0x0015 then
			chip8.delay_timer = chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00), 8)]
			chip8.pc = chip8.pc + 2
		elseif bit.band(chip8.opcode, 0x00FF) == 0x0018 then
			chip8.sound_timer = chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00), 8)]
			chip8.pc = chip8.pc + 2
		elseif bit.band(chip8.opcode, 0x00FF) == 0x001E then
			chip8.I = chip8.I + chip8.V[bit.rshift(bit.band(chip8.opcde, 0x0F00), 8)]
			chip8.pc = chip8.pc + 2
		elseif bit.band(chip8.opcode, 0x00FF) == 0x0029 then
			chip8.I = chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00), 8)] * 0x5;
   			chip8.pc = chip8.pc + 2;
		elseif bit.band(chip8.opcode, 0x00FF) == 0x0033 then
			chip8.memory[chip8.I]     = chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00), 8)] / 100;
            chip8.memory[chip8.I + 1] = (chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00), 8)] / 10) % 10;
            chip8.memory[chip8.I + 2] = (chip8.V[bit.rshift(bit.band(chip8.opcode, 0x0F00), 8)] % 100) % 10;
            chip8.pc = chip8.pc + 2;
		elseif bit.band(chip8.opcode, 0x00FF) == 0x0055 then
			for i = 0, bit.rshift(bit.band(chip8.opcode, 0x0F00), 8) do
                chip8.memory[chip8.I + i] = chip8.V[i];
            end
            chip8.I = chip8.I + bit.rshift(bit.band(chip8.opcode, 0x0F00), 8) + 1;
            chip8.pc = chip8.pc + 2;
		elseif bit.band(chip8.opcode, 0x00FF) == 0x0065 then
			for i = 0, bit.rshift(bit.band(chip8.opcode, 0x0F00), 8) do
                chip8.V[i] = chip8.memory[chip8.I + i];
            end
            chip8.I = chip8.I + bit.rshift(bit.band(chip8.opcode, 0x0F00), 8) + 1;
            chip8.pc = chip8.pc + 2;
		end
	end

	opcodes[0x0000] = func_0x0000
	opcodes[0x1000] = func_0x1000
	opcodes[0x2000] = func_0x2000
	opcodes[0x3000] = func_0x3000
	opcodes[0x4000] = func_0x4000
	opcodes[0x5000] = func_0x5000
	opcodes[0x6000] = func_0x6000
	opcodes[0x7000] = func_0x7000
	opcodes[0x8000] = func_0x8000
	opcodes[0x9000] = func_0x9000
	opcodes[0xA000] = func_0xA000
	opcodes[0xB000] = func_0xB000
	opcodes[0xC000] = func_0xC000
	opcodes[0xD000] = func_0xD000
	opcodes[0xE000] = func_0xE000
	opcodes[0xF000] = func_0xF000
end

function chip8:emulateCycle()
	self.opcode = bit.bor(bit.lshift(self.memory[self.pc], 8), self.memory[self.pc + 1])

	io.write(string.format("%02X ", string.byte(self.opcode)))

	opcodes[bit.band(self.opcode, 0xF000)]()
	if self.delay_timer > 0 then
		self.delay_timer = self.delay_timer - 1
	end

	if self.sound_timer > 0 then
		if self.sound_timer == 1 then
			print("BEEP!\n")
			self.sound_timer = self.sound_timer - 1
		end
	end
end

function chip8:initialize()

	self.pc = 0x200
	self.opcode = 0
	self.I = 0
	self.sp = 0

	for i=0,(64*32)-1 do
		self.gfx[i] = 0
	end

	for i=0,4095 do
		self.memory[i] = 0
	end

	for i=0,15 do

	end

	for i=0,79 do
		--self.memory[i] = chip8_fontset[i];
	end

	opcodesConf()
end

function loadGame(name)
	print(name)
	local f = assert(io.open(name, "rb"))
	local block = 10
	local i = 0
	while true do
		local bytes = f:read(block)
      if not bytes then break end
      for b in string.gfind(bytes, ".") do
        io.write(string.format("%02X ", string.byte(b)))
        chip8.memory[i + 512] = string.byte(b)
      end
      --io.write(string.rep("   ", block - string.len(bytes) + 1))
      --io.write(string.gsub(bytes, "%c", "."), "\n")
      i = i + 1

	end
end

function love.load()
	chip8:initialize()
	loadGame(arg[2])
end

function love.update(dt)
	chip8:emulateCycle()
end

function love.draw()
	if chip8.drawFlag then
		love.graphics.clear()
		drawGraphics()
	end

	chip8.drawFlag = false
end

function drawGraphics()
    for y = 0, 31 do
        for x = 0, 63 do
            if (chip8.gfx[(y*64)+x] == 0) then
                --SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);
            	love.graphics.setColor(255, 0, 0, 255)
            else 
                --SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255);
            	love.graphics.setColor(255, 255, 255, 255)
            end
            love.graphics.rectangle("fill", x, y, 1, 1)
    	end
    end
end