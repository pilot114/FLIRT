require "src/flirt"

function love.load()
	F.init(false)
	
	animations = {
		-- TODO: fix both case
		idle = F.createAnim("playerIdle", "player", 64, 96, "1-6:1", 0.1)
		-- idle = F.createAnim("playerIdle", "cat", 512, 256, "1-2:1:1-2:2", 0.1)
		-- walk<> run<> jump<> lookup<> stoop<> rise
	}
	spellRun = function(F)
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
	F.createPlayer(animations, controls, 100, 200)
	-- F.createEnemy(aminations)
end

function love.update(dt)
	F.update(dt)
end

function love.draw()
	F.draw()
end

-- or set F.init(true)
function love.keypressed(key)
	if key == "`" then
		F.debug = not F.debug
	end
end