local anim8 = require "src/anim8"
local sti = require "src/sti"
local ac = require "src/actors"
local nh = require "src/noobHelpers"

gr = love.graphics
ph = love.physics
kb = love.keyboard
fs = love.filesystem

F = {
	version = "0.0.3",
	debug = false,
	-- camera mode. current only "side"
	mode = "side",
	-- only names (without preload)
	assets = {
		anim = {},
		font = {},
		img = {},
		map = {},
		music = {},
		sound = {},
	},
	-- obj cache for optimize load (one asset for many objects)
	cache = {
		anim = {},
		font = {},
		img = {},
		music = {},
		sound = {},
	},
	-- send print to draw callback
	toPrint = {},

	-- ACTORS incapsulate assets, linked with them

	-- (see createPlayer)
	player = {},

	-- global control of objects (activated, viewed etc)
	objPool = {},

	-- for objects beyond time and space ...
	pitfall = {}
}

function F.createPlayer( animations, controls, x, y )
	F.player = ac.createPlayer( animations, controls, x, y )
end

function F.init(mode, debug)
	F.mode  = mode
	F.debug = debug
	F.registerAssets()
end

function F.registerAssets()
	for k,v in pairs(F.assets) do
		F.assets[k] = fs.getDirectoryItems( "assets/"..k )
	end
end

function F.createAnim(aName, name, x, y, frames, speed )
	for k,fileName in pairs(F.assets.anim) do
	    for n,str in pairs(nh.split(fileName, ".")) do
			if str == name then
				imageName = fileName
				break
			end
	    end
	end
	-- check exist imageObj
	if F.cache.img[name] == nil then
	    F.cache.img[name] = gr.newImage("assets/anim/"..imageName)
	end
	i = F.cache.img[name]
	-- check exist animObj
	if F.cache.anim[aName] == nil then
		-- TODO: see https://github.com/kikito/anim8
	    g = anim8.newGrid(x, y, i:getWidth(), i:getHeight())

	    -- args generic with numeric rows
	    args = nh.split(frames, ":")
	    for k,v in pairs(args) do
	    	-- dirty
	    	if string.find(v, "-") then
			else
		    	args[k] = tonumber(v)
			end
	    end
	    F.cache.anim[aName] = anim8.newAnimation(g(unpack(args)), speed)
	end
	a = F.cache.anim[aName]

    return { a, i, g.frameWidth, g.frameHeight }
end

function F.update(dt)
	F.player.update(dt)
end

function F.draw()
	F.player.draw()

	for k,v in pairs(F.toPrint) do
		gr.print(v[1], v[2], v[3])
	end

	if F.debug then
		gr.print("Flirt "..F.version, 10, 10)

		drawBlock = F.drawBlock("Assets: ", 10, 30)
		drawBlock( "Animations: ", F.assets.anim)
		drawBlock( "Images: ", 	 F.assets.img)
		drawBlock( "Fonts: ", 	 F.assets.font)
		drawBlock( "Music: ", 	 F.assets.music)
		drawBlock( "Sound: ", 	 F.assets.sound)
		
		drawBlock = F.drawBlock("Cache: ", 10, 130)
		drawBlock( "Animations: ", F.cache.anim)
		drawBlock( "Images: ", 	 F.cache.img)
		drawBlock( "Fonts: ", 	 F.cache.font)
		drawBlock( "Music: ", 	 F.cache.music)
		drawBlock( "Sound: ", 	 F.cache.sound)
	end
end

function F.keypressed(key)

	F.player.keypressed(key)

	-- debug
	if key == "`" then
		F.debug = not F.debug
	end
end

function F.keyreleased(key)

	F.player.keyreleased(key)
end

function F.print( text, x, y )
	table.insert(F.toPrint, {text, x, y})
end

function F.drawBlock(blockTitle, px, py, block)
	gr.print(blockTitle, px, py)
	local px = px
	local py = py
	local block = 1
	local blockWidth = 130
	local blockHeight = 12
	function iter(text, table)
		-- table maybe object or array
    	if nh.isArray(table) > -1 then
	    	-- its array
			if #table > 0 then
				gr.print(text..#table, px + block*blockWidth, py)
				for k,v in pairs(table) do
					gr.print(v, px + block*blockWidth, py + (k+1)*blockHeight)
				end
				block = block + 1
			end
		else
	    	-- its object
			gr.print(text..nh.tableCount(table), px + block*blockWidth, py)
			n = 1
			for k,v in pairs(table) do
				gr.print(k, px + block*blockWidth, py + (n+1)*blockHeight)
				n = n + 1
			end
			block = block + 1
		end
	end
	return iter
end
