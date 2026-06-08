SMODS.Joker {
    atlas = "Joker",
    key = "Outdated_Meme",
    pos = {
        x = 6,
        y = 8
    },
    rarity = 2,
    cost = 7,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { hands = 2, chips = 15 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.hands, card.ability.extra.chips } }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
        ease_hands_played(card.ability.extra.hands)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
        ease_hands_played(-card.ability.extra.hands)
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local subtract = 15 * G.GAME.round_resets.ante
            print(hand_chips)
            print(subtract)
            if hand_chips - subtract <= 5 then
                subtract = hand_chips - 5
            end
            return {chip_mod = -1 * subtract,
                    message = tostring(-1 * subtract) .. " Chips",
                    colour = G.C.BLUE
                }
        end
    end
}