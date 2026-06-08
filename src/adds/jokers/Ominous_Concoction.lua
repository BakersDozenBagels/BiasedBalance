SMODS.Joker {
    atlas = "Joker",
    key = "Ominous_Concoction",
    pos = {
        x = 10,
        y = 1
    },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = {
        xmult = 2,
        chips = 15,
        a_chips = 15
    } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.chips, card.ability.extra.chips * G.GAME.round_resets.ante } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            card.ability.extra.a_chips = card.ability.extra.chips * G.GAME.round_resets.ante
            while hand_chips - card.ability.extra.a_chips < 5 do
                card.ability.extra.a_chips = card.ability.extra.a_chips - 1
            end
            return {
                chips = -card.ability.extra.a_chips,
                xmult = card.ability.extra.xmult
            }
        end
    end
}