ac = {}

-- constructor always return actor object

function ac.createPlayer( animations, controls, x, y )
	-- set default user position
	if x == nil and y == nil then
		x = gr.getWidth()/2
		y = gr.getHeight()/2
	end

	player = {
		-- array {animObj, imageObj, frameWidth, frameHeight}
		anim = animations,
		-- ?
		-- array {key, speed/callback, assets( anim/sound etc.)}
		ctrl = controls,
		-- player center position
		x = x,
		y = y,
		dir = 1, -- left 0, right 1, up 1.5, down 2
		flipH = function()
			if player.dir == 1 then
				player.dir = 0
			else
				player.dir = 1
			end
			for k,animation in pairs(player.anim) do
		    	animation[1]:flipH()
			end
		end,
		flipV = function()
			if player.dir == 1.5 then
				player.dir = 2
			else
				player.dir = 1.5
			end
			for k,animation in pairs(player.anim) do
		    	animation[1]:flipV()
			end
		end
	}


	-- START INTERFACE FOR ANY ACTORS
	function player.update(dt)
		if player.animState ~= nil then
			curAnim = player.anim[player.animState]
			curAnim[1]:update(dt)
		end
	end

	function player.draw()
		if player.animState ~= nil then
			curAnim = player.anim[player.animState]
			curAnim[1]:draw(curAnim[2], player.x, player.y)
		end
	end

	function player.keypressed(key)
		-- running player
		if key == player.ctrl.left[1]
		or key == player.ctrl.right[1] then
	        player.animState = "run"
	    end

	    -- change dir for player
	    if key == player.ctrl.left[1]
	    and player.dir == 1 then
	    	player.flipH()
		end
	    if key == player.ctrl.right[1]
	    and player.dir == 0 then
	    	player.flipH()
		end

		if key == player.ctrl.spell[1] then
			-- TODO: in draw?
	        player.ctrl.spell[2]()
	    end
	end

	function player.keyreleased(key)
		-- stopping player
		if key == player.ctrl.left[1]
		or key == player.ctrl.right[1] then
			-- and switch to idle
		    player.animState = "idle"
		end
	end
	-- END INTERFACE FOR ANY ACTORS


	-- try get user size from first animation and centrize
	for k,animation in pairs(animations) do
		if animation ~= nil then
			player.width  = animation[3]
			player.height = animation[4]
			player.x = player.x - player.width/2
			player.y = player.y - player.height/2
		end
		break
	end

	if player.anim.idle ~= nil then
		player.animState = "idle"
	end

	return player
end

return ac