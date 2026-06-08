SMODS.Joker {
    atlas = "Joker",
    key = "Terrace_Garden",
    pos = {
        x = 5,
        y = 0
    },
    rarity = 1,
    cost = 4,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = {
        money = 1
    } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money, card.ability.extra.money * (G.jokers and #G.jokers.cards or 0) } }
    end,
    calc_dollar_bonus = function(self, card)
        local bonus = card.ability.extra.money * #G.jokers.cards
        if bonus > 0 then return bonus end
    end
}