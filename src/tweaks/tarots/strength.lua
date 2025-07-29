SMODS.Consumable:take_ownership('c_strength', {
    config = {
        max_highlighted = 3,
        extra = {
            uses = 2
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.uses,
            }
        }  
    end,
    can_use = function(self)
        return #G.hand.highlighted == self.config.max_highlighted
    end,
    use = function(self, card, area)
        if card.ability.extra.uses == 2 then
            G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                local newcard = create_card("Tarot", G.consumeables, nil, nil, nil, nil, 'c_strength')
                newcard.ability.extra.uses = newcard.ability.extra.uses - 1
                newcard:add_to_deck()
                G.consumeables:emplace(newcard)
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        end
        local selected = G.hand.highlighted
        if #selected ~= 2 then return end
        
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