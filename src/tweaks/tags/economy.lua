SMODS.Tag:take_ownership("economy", {
    config = {
        max = 50,
        min = 6,
    },
    loc_vars = function(self, info_queue, tag)
        return { vars = { self.config.max, self.config.min } }
    end,
    apply = function(self, tag, context)
        if context.type == 'immediate' and not tag.triggered then
            tag:yep('+', G.C.MONEY, function()
                return true
            end)
            G.E_MANAGER:add_event(Event {
                trigger = 'immediate',
                func = function()
                    ease_dollars(math.max(self.config.min, math.min(self.config.max, math.max(0, G.GAME.dollars))), true)
                    return true
                end
            })
            tag.triggered = true
            return true
        end
    end
})