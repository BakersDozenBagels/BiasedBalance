SMODS.Joker {
    atlas = "Joker",
    key = "ImpatientJoker",
    pos = {
        x = 4,
        y = 0
    },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    config = { extra = {
        money = 10,
        d_chips = 50,
        chips = 0
    } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money, card.ability.extra.d_chips, card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.skip_blind then
            if not context.blueprint then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.d_chips
            end
            return {
                dollars = card.ability.extra.money
            }
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}