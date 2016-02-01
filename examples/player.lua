require "src/flirt"

-- player animation examples

function love.load()
	F.init("side", false)

	animations = {
		-- one frame for static
		idle = F.createAnim("playerRun", "player", 64, 96, "4:1", 0.1),
		run = F.createAnim("playerIdle", "player", 64, 96, "1-6:1", 0.1),
		-- walk<> run<> jump<> lookup<> stoop<> rise
	}
	spellRun = function()
		F.print("spellRun!", 300, 300)
	end
	controls = {
		up = {"w", 4000},
		left = {"a", 4000},
		down = {"s", 4000},
		right = {"d", 4000},
		-- custom
		spell = {"q", spellRun}
	}
	F.createPlayer(animations, controls, 100, 100)
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
