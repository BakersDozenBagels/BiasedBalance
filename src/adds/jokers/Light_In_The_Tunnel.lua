SMODS.Joker {
    atlas = "Joker",
    key = "Light_In_The_Tunnel",
    pos = {
        x = 7,
        y = 7
    },
    pools = { Utility = true},
    rarity = 3,
    cost = 9,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { deduction = 5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.deduction } }
    end,
    add_to_deck = function(self, card, from_debuff)
         G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.round_resets.reroll_cost = math.max(0, G.GAME.round_resets.reroll_cost - card.ability.extra.deduction)
                G.GAME.current_round.reroll_cost = math.max(0,
                    G.GAME.current_round.reroll_cost - card.ability.extra.deduction)
                return true
            end
        }))
    end,
    remove_from_deck = function(self, card, from_debuff)
         G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.round_resets.reroll_cost = math.max(0, G.GAME.round_resets.reroll_cost + card.ability.extra.deduction)
                G.GAME.current_round.reroll_cost = math.max(0,
                    G.GAME.current_round.reroll_cost + card.ability.extra.deduction)
                return true
            end
        }))
    end
}