SMODS.Back {
    key = "White",
    name = "White",
    atlas = "Backs",
    pos = {
        x = 0,
        y = 0
    },
    calculate = function(self, card, context)
        if context.setting_blind then 
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    local chosen_joker = pseudorandom_element(BiasedBalance.Common_Jokers, pseudoseed('choice'))
                    local card = create_card("Joker", G.jokers, nil, nil, nil, nil, 'j_'.. chosen_joker)
                    card:add_to_deck()
                    G.jokers:emplace(card)
                    card:juice_up(0.3, 0.5)
                    return true
                end
                }))
        end
    end
}
