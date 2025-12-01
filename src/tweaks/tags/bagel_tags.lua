--[[

Copyright (C) 2025  BakersDozenBagels and Mills-44

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.

]] --






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

SMODS.Tag:take_ownership("double", {
    apply = function(self, tag, context)
        if context.type == 'tag_add' and context.tag.key == 'tag_boss' then return true end
    end
}, true)

SMODS.Tag:take_ownership("juggle", {
    config = {
        h_size = 2,
        rounds = 3,
        base_rounds = 2
    },
    loc_vars = function(self, info_queue, tag)
        return { vars = { self.config.h_size, self.config.base_rounds, tag.ability and tag.ability.rounds or self.config.rounds } }
    end,
    apply = function(self, tag, context)
        if context.type == 'round_start_bonus' and not tag.triggered and not tag.ability.cold then
            tag.ability = tag.ability or {}
            tag.ability.rounds = tag.ability.rounds or self.config.rounds

            if tag.ability.rounds > 0 then
                tag.ability.rounds = tag.ability.rounds - 1
                if tag.ability.rounds == 0 then
                    tag.triggered = true
                    tag:yep('+', G.C.BLUE, function()
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
                                cover_colour = G.C.BLUE,
                                align = 'cm',
                            })
                            play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                            play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                            return true
                        end)
                    }))
                end
            end

            G.hand:change_size(self.config.h_size)
            G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + self.config.h_size

            tag.ability.cold = true
        end

        if context.type == 'eval' then
            tag.ability.cold = false
        end
    end
})

local b_buf = SMODS.Booster {
    key = 'LowStickerBuffoon',
    no_collection = true,
    pos = { x = 2, y = 7 },
    config = {
        extra = 4,
        choose = 2
    },
    weight = 0,
    loc_vars = function()
        return { vars = { 4, 2 }, key = 'p_buffoon_mega' }
    end,
    create_card = function(self, pack, i)
        local card = G.P_CENTERS.p_buffoon_mega_1:create_card(pack, i)

        if type((_card_to_spawn or {}).is) ~= 'function' or not _card_to_spawn:is(Card) then
            card = SMODS.create_card(card)
        end

        if not G.GAME.modifiers.all_eternal then
            card:set_eternal(false)
        end
        card:set_perishable(false)
        card:set_rental(false)

        local choice = pseudorandom 'LowStickerBuffoon'
        if choice < 0.1 then
            card:set_eternal(true)
        elseif choice < 0.2 and not G.GAME.modifiers.all_eternal then
            card:set_perishable(false)
        end

        if pseudorandom 'LowStickerBuffoon' < 0.1 then
            card:set_rental(true)
        end
        return card
    end,
    in_pool = function() return false end
}

SMODS.Tag:take_ownership("buffoon", {
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            tag:yep('+', G.C.PURPLE, function()
                local booster = Card(G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
                    G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2, G.CARD_W * 1.27, G.CARD_H * 1.27, G.P_CARDS.empty,
                    b_buf, { bypass_discovery_center = true, bypass_discovery_ui = true })
                booster.cost = 0
                booster.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = booster } })
                booster:start_materialize()
                return true
            end)
            tag.triggered = true
            return true
        end
    end
})
