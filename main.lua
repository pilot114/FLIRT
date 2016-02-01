require "src/flirt"

-- animation examples

function love.load()
	F.init("side", false)

	F.debugAnimations = {
		player = F.createAnim("player", "player", 64, 96, "1-6:1", 0.1),
		explosion = F.createAnim("explosion", "explosion", 96, 96, "1-12:1", 0.1),
		protoman = F.createAnim("protoman", "protoman", 30, 40, "1-10:1:1-7:2", 0.1),
		cat = F.createAnim("cat", "cat", 512, 256, "1-2:1:1-2:2:1-2:3:1-2:4", 0.1),
	}
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
