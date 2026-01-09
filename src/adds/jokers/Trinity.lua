
SMODS.Joker {
    atlas = "Joker",
    key = "Trinity",
    pos = {
        x = 12,
        y = 2
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { x_mult = 2, suits = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult, card.ability.extra.suits } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local t = 0
            local suits = {}
            for _, v in pairs(context.scoring_hand) do
                if SMODS.has_any_suit(v) then
                    t = t + 1
                elseif not suits[v.base.suit] then
                    suits[v.base.suit] = true
                    t = t + 1
                end
            end
            if t >= card.ability.extra.suits then
                return {
                    x_mult = card.ability.extra.x_mult
                }
            end
        end
    end
}
