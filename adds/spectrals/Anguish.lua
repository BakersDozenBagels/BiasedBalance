SMODS.Consumable {
    object_type = "Consumable",
    key = 'Anguish',
    set = 'Spectral',
    atlas = 'Anguish',
	config = {
		max_highlighted = 1
	},
    pos = {
        x = 0,
        y = 0
    },
    cost = 4,
    discovered = true,
    unlocked = true,
	can_use = function(self)
        return #G.hand.highlighted == self.config.max_highlighted
    end,
	use = function(self, card, area)
        local highlighted = G.hand.highlighted[1]
    
        if highlighted then
            highlighted:set_seal("BiasedBalance_Tangerine")  
            highlighted:juice_up(0.4, 0.5)
            G.hand:remove_from_highlighted(highlighted)
        else
            G.STATE_ARGS.selecting_card = true
            G:select_cards({
                amount = 1,
                prompt = "Adds Tangerine Seal!",
                must_have = true,
                filter = function(c)
                    return c:can_have_seal()
                end,
                callback = function(selected)
                    for _, c in ipairs(selected) do
                        c:set_seal("BiasedBalance_Tangerine") 
                        c:juice_up(0.4, 0.5)
                    end
                end
            })
        end
    
        return true
    end,
}
