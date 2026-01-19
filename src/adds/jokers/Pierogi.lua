SMODS.Joker {
    atlas = "Joker",
    key = "Pierogi",
    pos = {
        x = 9,
        y = 4
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    config = { 
        extra = { 
           xmult = 2,
           xmult_reroll = .05
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.xmult_reroll,
                card.ability.extra.xmult
        } 
    }
    end,
    calculate = function(self, card, context)
        if context.reroll_shop and not context.blueprint then
            card.ability.extra.xmult = math.max(0, card.ability.extra.xmult - card.ability.extra.xmult_reroll)
            if card.ability.extra.xmult <= 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                card:remove()
                                return true
                            end
                        }))
                        return true
                    end
                }))
                return {
                    message = localize('k_eaten_ex'),
                    colour = G.C.RED
                }
            end
            return {
                    message = localize { type = 'variable', key = 'a_mult_minus', vars = { card.ability.extra.xmult_reroll } },
                    colour = G.C.RED
                }
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}