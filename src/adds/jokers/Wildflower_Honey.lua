SMODS.Joker {
    atlas = "Joker",
    key = "Wildflower_Honey",
    pos = {
        x = 10,
        y = 4
    },
    rarity = 2,
    cost = 8,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    config = { 
        extra = { 
           money = 10,
           money_mod = 1
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.money,
                card.ability.extra.money_mod
        } 
    }
    end,
    calculate = function(self, card, context)
        if context.skip_blind then
            ease_dollars(card.ability.extra.money)
            G.E_MANAGER:add_event(Event({
                    func = function()
                        card.ability.extra.money = math.max(card.ability.extra.money - card.ability.extra.money_mod,0)
                        card:juice_up()
                        return true
                    end
                }))
            if card.ability.extra.money <= 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        -- This replicates the food destruction effect
                        -- If you want a simpler way to destroy Jokers, you can do card:start_dissolve() for a dissolving animation
                        -- or just card:remove() for no animation
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
                    message = localize('k_drank_ex'),
                    colour = G.C.FILTER
                }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval then 
            G.E_MANAGER:add_event(Event({
                    func = function()
                        ease_dollars(card.ability.extra.money)
                        card.ability.extra.money = math.max(card.ability.extra.money - card.ability.extra.money_mod,0)
                        card:juice_up()
                        return true
                    end
                }))
            if card.ability.extra.money <= 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        -- This replicates the food destruction effect
                        -- If you want a simpler way to destroy Jokers, you can do card:start_dissolve() for a dissolving animation
                        -- or just card:remove() for no animation
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
                    message = localize('k_drank_ex'),
                    colour = G.C.FILTER
                }
            end
        end
    end
}