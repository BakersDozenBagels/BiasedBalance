SMODS.Joker:take_ownership("troubadour", {
    config = { extra = { h_size = 2, h_plays = 0, discard_size = 4 } }, 
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.h_size, card.ability.extra.discard_size } }
    end
})