local anim8 = require "src/anim8"
local sti = require "src/sti"

gr = love.graphics
ph = love.physics
kb = love.keyboard

F = {
	version = "0.0.1",
	debug = false,
	assets = {
		anim = {},
		font = {},
		img = {},
		map = {},
		music = {},
		sound = {},
	},
	anim = {},
	img = {},
}

function F.init()
	F.registerAssets()
end

function F.registerAssets()
	for k,v in pairs(F.assets) do
		F.assets[k] = love.filesystem.getDirectoryItems( "assets/"..k )
	end
end

function F.createAnim( name, fname, x, y, frames, row, speed )
	for k,fileName in pairs(F.assets.anim) do
	    for str in string.gmatch(fileName, "([^"..".".."]+)") do
			if str == fname then
				imageName = fileName
				break
			end
	    end
	end
    i = gr.newImage("assets/anim/"..imageName)
    g = anim8.newGrid(x, y, i:getWidth(), i:getHeight())

    F.img[name] = i
    F.anim[name] = anim8.newAnimation(g(frames, row), speed)
end

function F.update(dt)
	for k,v in pairs(F.anim) do
		v:update(dt)
	end
end

function F.draw()
	if F.debug then
		local py = 15
		local px = 13
		love.graphics.print("Flirt "..F.version, px, py)

		F.assetsPrint( "Animations: ", F.assets.anim, py, px, 1 )
		F.assetsPrint( "Images: ", 	   F.assets.img, py, px, 2 )
		F.assetsPrint( "Fonts: ", 	   F.assets.font, py, px, 3 )
		F.assetsPrint( "Music: ", 	   F.assets.music, py, px, 4 )
		F.assetsPrint( "Sound: ", 	   F.assets.sound, py, px, 5 )
	end

	for k,v in pairs(F.anim) do
		-- dirt
		v:draw(F.img[k], 200, 200)
	end
end

function F.assetsPrint( text, table, py, px, column )
	love.graphics.print(text..#table, column*px*10, py*1)
	for k,v in pairs(table) do
		love.graphics.print(v, column*px*10, py*(k+1))
	end
end

