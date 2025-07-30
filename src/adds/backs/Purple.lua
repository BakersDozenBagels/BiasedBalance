SMODS.Back {
    key = "Purple",
    name = "Purple",
    atlas = "Backs",
    pos = {
        x = 1,
        y = 0
    },
    config = { x_mult = 2 },
    loc_vars = function(self, info_queue, back)
        return {
            vars = { self.config.x_mult }
        }
    end,
    calculate = function(self, back, args)
        if args.context == 'final_scoring_step' then
            args.mult = args.mult * self.config.x_mult

            local skip = Talisman and Talisman.config_file and Talisman.config_file.disable_anims

            update_hand_text({
                delay = 0
            }, {
                mult = args.mult
            })
            if not skip then
                G.E_MANAGER:add_event(Event {
                    trigger = 'before',
                    delay = 0.8125,
                    func = function()
                        attention_text {
                            text = localize {
                                type = 'variable',
                                key = 'a_xmult',
                                vars = { self.config.x_mult }
                            },
                            scale = 1.4,
                            hold = 2,
                            offset = {
                                x = 0,
                                y = -2.7
                            },
                            major = G.play
                        }
                        play_sound('multhit2', 0.845 + 0.04 * math.random(), 0.7)
                        G.ROOM.jiggle = G.ROOM.jiggle + 0.7
                        return true
                    end
                })
            end

            return args.chips, args.mult
        end
    end
}

local raw_Blind_debuff_hand = Blind.debuff_hand
function Blind:debuff_hand(cards, hand, handname, check)
    if G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.center and
        G.GAME.selected_back.effect.center.key == 'b_biasedBalance_Purple'
    then
        G.GAME.biasedBalance_hand_types = G.GAME.biasedBalance_hand_types or {}
        if G.GAME.biasedBalance_hand_types[handname] then
            SMODS.debuff_text = localize 'k_biasedBalance_noRepeats'
            SMODS.hand_debuff_source = nil
            return true
        end
        if not check then
            G.GAME.biasedBalance_hand_types[handname] = true
        end
    end
    return raw_Blind_debuff_hand(self, cards, hand, handname, check)
end

local raw_ease_round = ease_round
function ease_round(...)
    G.GAME.biasedBalance_hand_types = {}
    return raw_ease_round(...)
end

local raw_in_pool = G.P_BLINDS.bl_mouth.in_pool
SMODS.Blind:take_ownership('bl_mouth', {
    in_pool = function(...)
        if G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.center and
            G.GAME.selected_back.effect.center.key == 'b_biasedBalance_Purple'
        then
            return false
        end
        if raw_in_pool then return raw_in_pool(...) end
        return true
    end
}, true)
