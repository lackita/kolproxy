function get_wanderer_turn(label)
	return ascension["wanderer: "..label]
end

local function make_lookup_table(tbl)
	local lookup = {}
	for _, x in ipairs(tbl) do
		lookup[x] = true
	end
	return lookup
end

-- TODO: turn ranges at ascension start
function add_wandering_monster_tracker(label, monster_list, min_offset, max_offset)
	local monster_table = make_lookup_table(monster_list)

	--- Add a fight processor to check if a monster is in the list
	add_processor("/fight.php", function()
		if monster_table[monstername()] then
			ascension["wanderer: "..label] = turnsthisrun() + min_offset
		end
	end)

	-- display the wandering monster window in the charpane
	add_charpane_line(function()
		local next_turn = ascension["wanderer: "..label]
		if next_turn then
			local turnmin = next_turn - turnsthisrun()
			local turnmax = turnmin + max_offset - min_offset
			if turnmax >= 0 then
				if turnmin < 0 then turnmin = 0 end
				return { name = label, value = turnmin .. " to " .. turnmax }
			end
		end
	end)
end

local bees = { "beebee gunners", "moneybee", "mumblebee", "beebee queue", "bee swarm", "buzzerker", "Beebee King", "bee thoven", "Queen Bee" }
add_wandering_monster_tracker("Bees", bees, 15, 20)
