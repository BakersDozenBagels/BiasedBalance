SMODS.Back {
    key = 'Engineer',
    atlas = 'Backs',
    pos = {
        x = 1,
        y = 1
    },
    config = { activated = false },
    loc_vars = function(self, info_queue, back)
        return { vars = {  } }
    end,
    apply = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				if G.jokers then
                    if pseudorandom('RareEngineer') <= 0.5 then
                        SMODS.add_card {
                                set = 'Utility',
                                rarity = 'Rare',
                                key_append = 'Mystery_Box'
                            }
                    else
                        SMODS.add_card {
                                set = 'Utility',
                                rarity = 'Uncommon',
                                key_append = 'Mystery_Box'
                            }
                    end
                    
				end
                return true
			end,
		}))
	end,
}