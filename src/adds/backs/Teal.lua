SMODS.Back {
    key = 'Teal',
    atlas = 'Backs',
    pos = {
        x = 3,
        y = 0
    },
    config = {
    },
    calculate = function(self, card, context) 
    if context.ending_shop then
        G.E_MANAGER:add_event(Event({
          func = function()
            local card = create_card('Tarot', G.jokers, nil, nil, nil, nil, nil, 'c_')
            card:add_to_deck()
            G.jokers:emplace(card)
            return true
          end
        }))
        end
    end
}