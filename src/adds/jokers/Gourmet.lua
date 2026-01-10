SMODS.Joker {
    atlas = "Joker",
    key = "Gourmet",
    pos = {
        x = 12,
        y = 3
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { 
        extra = { 
            mult = 0,
            mult_gain = 8,
            slots = 1
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.mult_gain,
                card.ability.extra.mult,
                card.ability.extra.slots
        } 
    }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.slots
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.slots
    end,
    calculate = function(self, card, context)
        if context.using_consumeable then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            return {
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
            }
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if G.GAME.blind.boss and card.ability.extra.mult > 0 then
                card.ability.extra.mult = 0
                return {
                    message = localize('k_reset'),
                    colour = G.C.RED
                }
            end
        end
    end
}