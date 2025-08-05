SMODS.Joker {
    atlas = "Joker",
    key = "Negative_Norman",
    pos = {
        x = 0,
        y = 0
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = {},
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 

        } 
    }
    end,
    calculate = function(self, card, context)
       if context.round_eval and G.GAME.last_blind and G.GAME.last_blind.boss then
            G.E_MANAGER:add_event(Event({
                func = function()
                    add_tag(Tag('tag_negative'))
                    return true
                end
            }))
        end
    end
}