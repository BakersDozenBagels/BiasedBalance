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
                local jokers = {}
                for k, v in pairs(get_current_pool('Utility')) do
                    if G.P_CENTERS[v] then
                        if pseudorandom('rare') <= 0.5 then
                            if G.P_CENTERS[v].set == 'Joker' and Card.is_rarity({ability = {set = 'Joker'}, config = {center = G.P_CENTERS[v]}}, 'Uncommon') then
                                table.insert(jokers, G.P_CENTERS[v].key)
                            end
                        else
                            if G.P_CENTERS[v].set == 'Joker' and Card.is_rarity({ability = {set = 'Joker'}, config = {center = G.P_CENTERS[v]}}, 'Rare') then
                                table.insert(jokers, G.P_CENTERS[v].key)
                            end
                        end
                    end
                end
                local key = pseudorandom_element(jokers, 'engineer')
                SMODS.add_card({key = key})
                return true
        end})) 
	end,
}