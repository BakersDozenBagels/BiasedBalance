SMODS.Joker {
    atlas = "Joker",
    key = "Mystery_Box",
    pos = {
        x = 0,
        y = 0
    },
    rarity = 1,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { 
        extra = { 
        
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 

        } 
    }
    end,
    calculate = function(self, card, context)
        if context.skip_blind then
            G.E_MANAGER:add_event(Event({
                func = function()
                    for i, c in ipairs(G.jokers.cards) do
                        if c == card then
                            SMODS.destroy_card(G.jokers.cards, i) -- Removes This Joker
                        break
                        end
                    end
                return true
                end}))
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    local chosen_joker = pseudorandom_element(BiasedBalance.Rare_Jokers, pseudoseed('choice'))
                    local rare = create_card("Joker", G.jokers, nil, nil, nil, nil, 'j_'.. chosen_joker)
                    rare:add_to_deck()
                    G.jokers:emplace(rare)
                    return true
                end
                }))
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    local tarot1 = create_card("Tarot", G.consumeables, nil, nil, nil, nil, 'c_')
                    local tarot2 = create_card("Tarot", G.consumeables, nil, nil, nil, nil, 'c_')
                    tarot1:add_to_deck()
                    tarot2:add_to_deck()
                    G.consumeables:emplace(tarot1)
                    G.consumeables:emplace(tarot2)
                    return true
                end
                }))
        end
    end,
}