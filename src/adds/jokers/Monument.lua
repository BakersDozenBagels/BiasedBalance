SMODS.Joker {
    atlas = "Joker",
    key = "Monument",
    pos = {
        x = 7,
        y = 2
    },
    rarity = 1,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { mult = 0, mult_gain = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_gain, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            local faces = false
            for _, playing_card in ipairs(context.scoring_hand) do
                if playing_card:is_face() then
                    card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                    break
                end
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}