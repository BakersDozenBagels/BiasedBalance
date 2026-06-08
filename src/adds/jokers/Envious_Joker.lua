SMODS.Joker {
    atlas = "Joker",
    key = "Envious_Joker",
    pos = {
        x = 2,
        y = 2
    },
    rarity = 1,
    cost = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { mult = 16, a_mult = 3 } },
    loc_vars = function(self, info_queue, card)
        local num_non_common = 0
        if G.jokers and G.jokers.cards then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].config.center.rarity ~= 1 then num_non_common = num_non_common + 1 end
            end
        end
        return { vars = { card.ability.extra.mult, card.ability.extra.a_mult, math.max(card.ability.extra.mult - card.ability.extra.a_mult * num_non_common, 0) } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local num_non_common = 0
            if G.jokers and G.jokers.cards then
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i].config.center.rarity ~= 1 then num_non_common = num_non_common + 1 end
                end
            end
            return {
                mult = math.max(card.ability.extra.mult - card.ability.extra.a_mult * num_non_common, 0)
            }
        end
    end
}