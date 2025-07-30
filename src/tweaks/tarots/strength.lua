SMODS.Consumable:take_ownership('c_strength', {
    config = {
        max_highlighted = 3,
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }  
    end,
    can_use = function(self)
        return #G.hand.highlighted <= self.config.max_highlighted
    end,
    use = function(self, card, area)   
        for i=1, #G.hand.highlighted do
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
            local card = G.hand.highlighted[i]
            card:flip()
            card:juice_up(0.3, 0.5)
            assert(SMODS.modify_rank(card, 1))
            card:flip()
            return true
        end
        }))
    end
end
})