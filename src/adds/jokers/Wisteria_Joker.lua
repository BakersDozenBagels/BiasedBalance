SMODS.Joker {
    atlas = "Joker",
    key = "Wisteria_Joker",
    pos = {
        x = 10,
        y = 0
    },
    rarity = 1,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    config = {
        extra = {
            chips = 0,
            chip_gain = 15,
            chip_lose = 10,
            size = 5
        }
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.chip_gain,
                card.ability.extra.chip_lose,
                card.ability.extra.chips,
        } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if card.ability.extra.chips > 0 then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
        if context.before and not context.blueprint and context.main_eval and #context.scoring_hand >= card.ability.extra.size then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain
            return {
                message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chip_gain } },
                colour = G.C.BLUE
            }
        end
        if context.before and not context.blueprint and context.main_eval and #context.scoring_hand < card.ability.extra.size then
            card.ability.extra.chips = math.max(0, card.ability.extra.chips - card.ability.extra.chip_lose)
            return {
                message = localize { type = 'variable', key = 'a_chips_minus', vars = { card.ability.extra.chip_lose } },
                colour = G.C.BLUE
            }
        end
    end
}