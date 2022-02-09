local collision = {}

local function update(player)
	if not player then
		return
	end
	
	local pos = player:get_pos()
	if pos ~= Nil then
		local node_name = minetest.get_node({x=math.floor(pos.x + 0.5), y=pos.y, z=math.floor(pos.z + 0.5)}).name
		if node_name == "beds:bed_top" or node_name == "beds:bed_bottom" or
			node_name == "beds:fancy_bed_top" or node_name == "beds:fancy_bed_bottom" then
			if not collision[player:get_player_name()] then
				if player:get_player_control().jump then
					player:add_velocity({x=0.0, y=20.0, z=0.0})
				else
					player:add_velocity({x=0.0, y=10.0, z=0.0})
				end
				collision[player:get_player_name()] = true
			end
		else
			collision[player:get_player_name()] = false
		end
		minetest.after(0.02, function() update(player) end)
	end
end

minetest.register_on_joinplayer(function(player)
	update(player)
end)
