SMODS.Joker {
    atlas = "Joker",
    key = "StageFright",
    pos = {
        x = 2,
        y = 4
    },
    rarity = 2,
    cost = 7,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { a_chips = 5, chips = 0, active = true } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.a_chips, card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.first_hand_drawn and not context.blueprint then
            local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        if context.before and context.main_eval and G.GAME.current_round.hands_played == 0 and not context.blueprint then
            local full_hand_set = {}
                for _, c in ipairs(context.full_hand) do
                    full_hand_set[c] = true
                end
            for  _, playing_card in ipairs(G.hand.cards) do
                if playing_card:is_face() and not full_hand_set[playing_card] then
                    card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.a_chips
                end
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}