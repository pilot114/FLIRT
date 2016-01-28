require "src/flirt"

-- animation examples

function love.load()
	F.init(false, "side")
	
	animations = {
		idle = F.createAnim("playerIdle", "player", 64, 96, "1-6:1", 0.1),
		-- run = F.createAnim("playerRun", "cat", 512, 256, "1-2:1:1-2:2:1-2:3:1-2:4", 0.1)
		-- walk<> run<> jump<> lookup<> stoop<> rise
	}
	spellRun = function()
		love.graphics.print("hello", 300, 300)
	end
	controls = {
		up = {"w", 4000},
		left = {"a", 4000},
		down = {"s", 4000},
		right = {"d", 4000},
		-- custom
		spell = {"q", spellRun}
	}
	F.createPlayer(animations, controls)
end

function love.update(dt)
	F.update(dt)
end

function love.draw()
	F.draw()
end

function love.keypressed(key)
	F.keypressed(key)
end
function love.keyreleased(key)
	F.keyreleased(key)
end
