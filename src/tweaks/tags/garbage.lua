SMODS.Tag:take_ownership("garbage", {
    config = {
        discards = 3,
        rounds = 2,
        type = '',
        dollars_per_discard = 0
    },
    loc_vars = function(self, info_queue, tag)
        return { vars = { self.config.discards, tag.ability and tag.ability.rounds or self.config.rounds } }
    end,
    apply = function(self, tag, context)
        if context.type == 'round_start_bonus' and not tag.triggered and not tag.ability.cold then
            tag.ability = tag.ability or {}
            tag.ability.rounds = tag.ability.rounds or self.config.rounds

            if tag.ability.rounds > 0 then
                tag.ability.rounds = tag.ability.rounds - 1
                if tag.ability.rounds == 0 then
                    tag.triggered = true
                    tag:yep('+', G.C.RED, function()
                        return true
                    end)
                else
                    G.E_MANAGER:add_event(Event({
                        delay = 0.4,
                        trigger = 'after',
                        func = (function()
                            attention_text({
                                text = '+',
                                colour = G.C.WHITE,
                                scale = 1,
                                hold = 0.3 / G.SETTINGS.GAMESPEED,
                                cover = tag.HUD_tag,
                                cover_colour = G.C.RED,
                                align = 'cm',
                            })
                            play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                            play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                            return true
                        end)
                    }))
                end
            end

            ease_discard(self.config.discards, nil, true)

            tag.ability.cold = true
        end

        if context.type == 'eval' then
            tag.ability.cold = false
        end
    end
})