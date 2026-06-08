SMODS.Joker {
    atlas = "Joker",
    key = "Submarine_Joker",
    pos = {
        x = 1,
        y = 2
    },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { hands_played = {}, mult = 5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult * #card.ability.extra.hands_played } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.cardarea == G.jokers then
            card.ability.extra.hands_played = {}
        end
        if context.before and not context.blueprint then
            local hand_not_in_list = true
            --[[for _, hand_name in ipairs(card.ability.extra.hands_played) do
                if hand_name == context.scoring_name then
                    hand_not_in_list = false
                    break
                end
            end]]
            if hand_not_in_list then
                card.ability.extra.hands_played[#card.ability.extra.hands_played+1] = context.scoring_name
            end
        end
        if context.cardarea == G.jokers and context.joker_main then
            return {
                mult = card.ability.extra.mult * #card.ability.extra.hands_played,
                colour = G.C.RED
            }
        end
    end
}