SMODS.Consumable {
    key = 'Teal',
    set = 'Spectral',
    --atlas = 'seals',
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
	use = function(self, card, area, copier)
        local used_consumable = copier or card
        local highlighted = G.hand and G.hand.highlighted and G.hand.highlighted[1]
    
        if highlighted then
            play_sound("tarot1")
            highlighted:set_seal("biasedBalance_Teal")  
            highlighted:juice_up(0.4, 0.5)
            G.hand:remove_from_highlighted(highlighted)
        else
            G.STATE_ARGS.selecting_card = true
            G:select_cards({
                amount = 1,
                prompt = "Add a Teal Seal!",
                must_have = true,
                filter = function(c)
                    return c:can_have_seal()
                end,
                callback = function(selected)
                    for _, c in ipairs(selected) do
                        c:set_seal("biasedBalance_Teal") 
                        c:juice_up(0.4, 0.5)
                    end
                end
            })
        end
    
        return true
    end,
}