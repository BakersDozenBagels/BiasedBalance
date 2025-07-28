local rare_sticker_tags = { "negative", "foil", "holo", "polychrome" }
for _, tag_type in ipairs(rare_sticker_tags) do
    SMODS.Tag:take_ownership(tag_type, {
        apply = function(self, tag, context)
            if context.type == 'store_joker_modify' and not context.card.edition and not context.card.temp_edition and context.card.config.center.set == 'Joker' then
                if not G.GAME.modifiers.all_eternal then
                    context.card:set_eternal(false)
                end
                context.card:set_perishable(false)
                context.card:set_rental(false)

                local choice = pseudorandom("sticker_tag_" .. tag_type)
                if choice < 0.1 then
                    context.card:set_eternal(true)
                elseif choice < 0.2 and not G.GAME.modifiers.all_eternal then
                    context.card:set_perishable(false)
                end

                if pseudorandom("sticker_tag_" .. tag_type) < 0.1 then
                    context.card:set_rental(true)
                end
            end
        end
    })
end

SMODS.Tag:take_ownership("meteor", {
    loc_vars = function() return {} end,
    apply = function(self, tag, context)
        if not tag.triggered then
            tag:yep('+', G.C.SECONDARY_SET.Planet, function()
                update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
                    { handname = localize('k_all_hands'), chips = '...', mult = '...', level = '' })
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                        play_sound('tarot1')
                        G.TAROT_INTERRUPT_PULSE = true
                        return true
                    end
                }))
                update_hand_text({ delay = 0 }, { mult = '+', StatusText = true })
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.9,
                    func = function()
                        play_sound('tarot1')
                        return true
                    end
                }))
                update_hand_text({ delay = 0 }, { chips = '+', StatusText = true })
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.9,
                    func = function()
                        play_sound('tarot1')
                        G.TAROT_INTERRUPT_PULSE = nil
                        return true
                    end
                }))
                update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = '+1' })
                delay(1.3)
                for k in pairs(G.GAME.hands) do
                    level_up_hand(tag, k, true)
                end
                update_hand_text({ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
                    { mult = 0, chips = 0, handname = '', level = '' })
                return true
            end)
            tag.triggered = true
            return true
        end
    end
})