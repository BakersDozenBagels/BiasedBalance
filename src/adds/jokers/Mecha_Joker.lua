SMODS.Joker {
    atlas = "Joker",
    key = "Mecha_Joker",
    pos = {
        x = 0,
        y = 6
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { 
        extra = { 
            triggered = false
        } 
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'tag_biasedBalance_Utility', set = 'Tag' }
        return { vars = { localize { type = 'name_text', set = 'Tag', key = 'tag_biasedBalance_Utility', vars = { 2, 4 } } } 
    }
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and G.GAME.blind.boss and context.main_eval then
            card.ability.extra.triggered = false
        end
        if context.ending_shop and card.ability.extra.triggered == false then
            card.ability.extra.triggered = true
            G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag(Tag('tag_biasedBalance_Utility'))
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end)
            }))
        end
    end
}