SMODS.Joker {
    atlas = "Joker",
    key = "End_Of_Days",
    pos = {
        x = 0,
        y = 0
    },
    rarity = 2,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {},
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
            
        } 
    }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if #G.playing_cards <= 10 then
                G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    local spectral = create_card("Spectral", G.consumeables, nil, nil, nil, nil, 'c_')
                    spectral:add_to_deck()
                    G.consumeables:emplace(spectral)
                    return true
                end
                }))
            end
        end
    end
}