SMODS.Joker {
    atlas = "Joker",
    key = "Shapeshifter",
    pos = {
        x = 3,
        y = 7
    },
    pools = {
        Utility = true
    },
    rarity = 3,
    cost = 9,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = {  } },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.after and #context.full_hand >= 5 and not context.blueprint and G.GAME.current_round.hands_played == 0 then
            local left_card = context.full_hand[1]
            local right_card = context.full_hand[#context.full_hand]
            G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        play_sound('tarot1')
                        left_card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                local percent = 1.15 - (1 - 0.999) / (1 - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        left_card:flip()
                        play_sound('card1', percent)
                        left_card:juice_up(0.3, 0.3)
                        return true
                    end
                }))
                delay(0.2)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        copy_card(right_card, left_card)
                        return true
                    end
                }))
                local percent = 0.85 + (1 - 0.999) / (1 - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        left_card:flip()
                        play_sound('tarot2', percent, 0.6)
                        left_card:juice_up(0.3, 0.3)
                        return true
                    end
                }))
                delay(0.5)
            return {
                message = localize('k_copied_ex'),
                colour = G.C.RED
            }
        end
    end,
}