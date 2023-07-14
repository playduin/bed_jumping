local collision = { }

minetest.register_globalstep(function(dtime)
	local players = minetest.get_connected_players()
	for i = 1, #players do
		if not players[i] then return end

		local pos = players[i]:get_pos()
		local node = minetest.get_node(vector.new(math.floor(pos.x + 0.75), math.floor(pos.y + 0.5), math.floor(pos.z + 0.75)))

		if pos ~= nil then
			if node.name == "beds:bed_top" or node.name == "beds:bed_bottom" or
				node.name == "beds:fancy_bed_top" or node.name == "beds:fancy_bed_bottom" then
				if not collision[players[i]:get_player_name()] then
					if players[i]:get_player_control().jump then
						local old_velocity = players[i]:get_velocity()
						players[i]:add_velocity(vector.new(old_velocity.x, 15.0, old_velocity.z))
					else
						local old_velocity = players[i]:get_velocity()
						players[i]:add_velocity(vector.new(old_velocity.x, 10.0, old_velocity.z))
					end

					collision[players[i]:get_player_name()] = true
				end
			else
				collision[players[i]:get_player_name()] = false
			end
		end
	end
end)
