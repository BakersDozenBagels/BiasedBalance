
SMODS.Tag:take_ownership("skip", {
     config = { type = 'immediate', skip_bonus = 8, initial_skip = 6 }, 
     loc_vars = function(self, info_queue, tag)
        local cur_money = tag.config.initial_skip + (tag.config.skip_bonus * (G.GAME.skips or 0))
        return {vars = {tag.config.skip_bonus, tag.config.initial_skip, cur_money}}
    end,
     apply = function(self, tag, context)
        if context.type == 'immediate' then
            tag:yep('+', G.C.MONEY,function() 
                return true
            end)
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    if G.GAME.skips > 1 then
                        ease_dollars((G.GAME.skips - 1 or 0)*self.config.skip_bonus + self.config.initial_skip)
                    else
                        ease_dollars(self.config.initial_skip)
                    end
                    return true
                end
            }))
            tag.triggered = true
            return true
        end
    end,
    })