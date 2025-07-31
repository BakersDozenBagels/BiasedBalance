SMODS.Joker {
    atlas = "Joker",
    key = "Velvet_Choker",
    pos = {
        x = 0,
        y = 0
    },
    rarity = 2,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { 
        extra = { 
            xmult = 3,
            d_size = 1
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.xmult
        } 
    }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.d_size
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.d_size
        ease_discard(card.ability.extra.d_size)
        ease_hands_played(card.ability.extra.d_size)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.d_size
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.d_size
        ease_discard(-card.ability.extra.d_size)
        ease_hands_played(card.ability.extra.d_size)
    end,
    calculate = function(self, card, context)
        if context.joker_main then 
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
}

