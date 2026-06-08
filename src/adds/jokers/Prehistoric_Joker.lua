SMODS.Joker {
    atlas = "Joker",
    key = "Prehistoric_Joker",
    pos = {
        x = 2,
        y = 7
    },
    rarity = 3,
    cost = 9,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    config = { extra = { ante = 1, total_rounds = 3, rounds = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.ante, card.ability.extra.total_rounds, card.ability.extra.rounds } }
    end,
    in_pool = function(self, args) 
        return G.GAME.Biased_Balance.prehistoric_joker_in_pool
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.rounds = card.ability.extra.rounds + 1
            if card.ability.extra.rounds == card.ability.extra.total_rounds then
                G.GAME.Biased_Balance.prehistoric_joker_in_pool = false
                card:start_dissolve()
                ease_ante(-card.ability.extra.ante)
            end
            return {
                message = (card.ability.extra.rounds < card.ability.extra.total_rounds) and
                    (card.ability.extra.rounds .. '/' .. card.ability.extra.total_rounds) or
                    localize('k_biasedBalance_ante'),
                colour = G.C.FILTER
            }
        end
    end,
}