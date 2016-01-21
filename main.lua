require "src/flirt"

function love.load()
	F.init()
	-- TODO: to entityWrapper (for players and other character)
	-- create and save in animation list
	F.createAnim("playerRun", "player2", 64, 96, "1-6", 1, 0.1)
end

function love.update(dt)
	F.update(dt)
end

function love.draw()
	F.draw()
end

-- or set F.debug = true in love.load()
function love.keypressed(key)
	if key == "`" then
		F.debug = not F.debug
	end
end