SMODS.Joker {
    atlas = "Joker",
    key = "Listless_Joker",
    pos = {
        x = 3,
        y = 2
    },
    rarity = 1,
    cost = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { mult = 12, active = true } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.buying_card and not context.blueprint and not (context.card == card) and card.ability.extra.active then
            if string.find(context.card.config.center.key, "j_") then
                card.ability.extra.active = false
                return {
                    message = localize('k_disabled')
                }
            end
        end
        if context.joker_main and card.ability.extra.active then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and not card.ability.extra.active then
            card.ability.extra.active = true
            return {
                message = localize('k_active_ex')
            }
        end
    end
}