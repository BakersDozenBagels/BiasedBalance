SMODS.Joker:take_ownership("bootstraps", {
    cost = 6,
    rarity = 1,
    config = { extra = { mult = 18, dollars = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.dollars } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra_value = -2
        G.GAME.inflation = G.GAME.inflation + card.ability.extra.dollars
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.inflation = G.GAME.inflation - card.ability.extra.dollars
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end,
})