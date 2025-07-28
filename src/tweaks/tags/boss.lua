SMODS.Tag:take_ownership("boss", {
    in_pool = function()
        return (G.GAME.round_resets.ante) % G.GAME.win_ante ~= 0
    end,
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then return true end

        if not tag.triggered and context.type == 'biasedBalance_set_blind' and context.blind.boss then
            G.E_MANAGER:add_event(Event {
                func = function()
                    if context.blind.disabled or not context.blind.disable then
                        tag.triggered = false
                        return true
                    end
                    tag:yep(localize('ph_boss_disabled'), G.C.RED, function()
                        return true
                    end)
                    context.blind:disable()
                    play_sound('timpani')
                    delay(0.4)
                    return true
                end
            })
            tag.triggered = true
        end
    end
})