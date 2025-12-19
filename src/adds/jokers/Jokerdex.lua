SMODS.Joker {
    atlas = "Joker",
    key = "Jokerdex",
    pos = {
        x = 0,
        y = 1
    },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { 
        extra = { 
            mult = 0,
            a_mult = 2,
            seen = {}
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { 
        vars = { 
            card.ability.extra.a_mult,
            card.ability.extra.mult,
        } 
    }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.buying_card and context.card.ability.set == "Joker" and context.card ~= card and not context.blueprint then
            if not card.ability.extra.seen[context.card.label] then
                card.ability.extra.seen[context.card.label] = true
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.a_mult
                return {
                    message = localize('k_upgrade_ex'),
                }
            end
        end
    end
}