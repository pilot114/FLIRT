local anim8 = require "src/anim8"
local sti = require "src/sti"
local actors = require "src/actors"
local nh = require "src/noobHelpers"

gr = love.graphics
ph = love.physics
kb = love.keyboard
fs = love.filesystem

F = {
	version = "0.0.2",
	debug = false,
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

	-- OBJECTS incapsulate assets, linked with them

	-- (see createPlayer)
	player = {},
}

function F.createPlayer( animations, controls, x, y )
	F.player = {
		-- array {animObj, imageObj}
		anim = animations,
		-- ?
		-- array {key, speed/callback, assets( anim/sound etc.)}
		ctrl = controls,
		x = x,
		y = y,
		dir = 1,
	}
	if F.player.anim.idle ~= nil then
		F.player.animState = "idle"
	end
end

function F.init(debug)
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

    return { a, i }
end

function F.update(dt)
	if F.player.animState ~= nil then
		curAnim = F.player.anim[F.player.animState]
		curAnim[1]:update(dt)
	end
end

function F.draw()
	if F.player.animState ~= nil then
		curAnim = F.player.anim[F.player.animState]
		curAnim[1]:draw(curAnim[2], F.player.x, F.player.y)
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
	
	if key == F.player.ctrl.left[1]
	or key == F.player.ctrl.right[1]
	or key == F.player.ctrl.up[1]
	or key == F.player.ctrl.down[1] then
        F.player.animState = "run"
    end

	if key == F.player.ctrl.spell[1] then
		-- TODO: in draw?
        F.player.ctrl.spell[2]()
    end

	-- debug
	if key == "`" then
		F.debug = not F.debug
	end
end

function F.keyreleased(key)
	if key == F.player.ctrl.left[1]
	or key == F.player.ctrl.right[1]
	or key == F.player.ctrl.up[1]
	or key == F.player.ctrl.down[1] then
        F.player.animState = "idle"
    end
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
