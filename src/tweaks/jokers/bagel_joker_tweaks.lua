--[[

Copyright (C) 2025  BakersDozenBagels and Mills 44

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

--#region Banned Jokers
local function ban()
    local banned_jokers = {
        { "8_ball","smiley", "superposition", "walkie_talkie" },
        { "ceremonial", "loyalty_card", "dusk", "seeing_double", "matador", "acrobat" },
        { "campfire" }
    }

    local function ban_one(key, rarity)
        G.P_CENTERS[key] = nil
        SMODS.Centers[key] = nil
        for _, pool in pairs(G.P_CENTER_POOLS) do
            local ix = 1
            while ix < #pool do
                if pool[ix].key == key then
                    table.remove(pool, ix)
                else
                    ix = ix + 1
                end
            end
        end
        local ix = 1
        while ix < #SMODS.Center.obj_buffer do
            if SMODS.Center.obj_buffer[ix] == key then
                table.remove(SMODS.Center.obj_buffer, ix)
            else
                ix = ix + 1
            end
        end
        if rarity then
            ix = 1
            while ix < #G.P_JOKER_RARITY_POOLS[rarity] do
                if G.P_JOKER_RARITY_POOLS[rarity][ix].key == key then
                    table.remove(G.P_JOKER_RARITY_POOLS[rarity], ix)
                else
                    ix = ix + 1
                end
            end
        end
    end

    for i, row in pairs(banned_jokers) do
        for _, v in pairs(row) do
            ban_one("j_" .. v, i)
        end
    end
    ban_one("c_grim")
    
end
local raw_Game_init_item_prototypes = Game.init_item_prototypes
function Game:init_item_prototypes()
    raw_Game_init_item_prototypes(self)
    ban()
end

ban()
--#endregion

--#region Common Jokers
SMODS.Joker:take_ownership("egg", {  eternal_compat = false })
SMODS.Joker:take_ownership("scholar", { config = { extra = { mult = 6, chips = 30 } } })
SMODS.Joker:take_ownership("joker", { config = { mult = 5 } })
SMODS.Joker:take_ownership("greedy_joker", { config = { extra = { s_mult = 4, suit = 'Diamonds' } } })
SMODS.Joker:take_ownership("lusty_joker", { config = { extra = { s_mult = 4, suit = 'Hearts' } } })
SMODS.Joker:take_ownership("wrathful_joker", { config = { extra = { s_mult = 4, suit = 'Spades' } } })
SMODS.Joker:take_ownership("gluttenous_joker", { config = { extra = { s_mult = 4, suit = 'Clubs' } } })

SMODS.Joker:take_ownership("crazy", { config = { t_mult = 15, type = 'Straight' } })
SMODS.Joker:take_ownership("droll", { config = { t_mult = 12, type = 'Flush' } })
SMODS.Joker:take_ownership("devious", { config = { t_chips = 125, type = 'Straight' } })
SMODS.Joker:take_ownership("crafty", { config = { t_chips = 100, type = 'Flush' } })

SMODS.Joker:take_ownership("banner", { config = { extra = 40 } })
SMODS.Joker:take_ownership("scary_face", {
    config = { extra = { chips = 30, mult = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_face() then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult,
            }
        end
    end
})
SMODS.Joker:take_ownership("delayed_grat", {
    rarity = 2,
    blueprint_compat = true,
    config = { extra = { dollars = 3, cards = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars, card.ability.extra.cards } }
    end,
    calculate = function(self, card, context)
        if context.discard and #context.full_hand <= card.ability.extra.cards and context.other_card == context.full_hand[#context.full_hand] then
            return { dollars = card.ability.extra.dollars }
        end
    end,
    calc_dollar_bonus = function(self, card) end
})

SMODS.Joker:take_ownership("gift", { cost = 4 })
SMODS.Joker:take_ownership("ticket", { config = { extra = 5 } })
SMODS.Joker:take_ownership("space", { rarity = 1 })
SMODS.Joker:take_ownership("hiker", { rarity = 1,  config = {extra = 6} })
SMODS.Joker:take_ownership("erosion", { rarity = 1, cost = 4 })
SMODS.Joker:take_ownership("to_the_moon", { rarity = 1 })
SMODS.Joker:take_ownership("cloud_9", { rarity = 1 })
SMODS.Joker:take_ownership("flash", { rarity = 1})
SMODS.Joker:take_ownership("castle", { rarity = 1 })

SMODS.Joker:take_ownership("bootstraps", {
    cost = 6,
    rarity = 1,
    config = { extra = { mult = 18, dollars = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.dollars } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra_value = -2
        G.GAME.inflation = G.GAME.inflation + card.ability.extra.dollars
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.inflation = G.GAME.inflation - card.ability.extra.dollars
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end,
})

SMODS.Joker:take_ownership("flower_pot", {
    cost = 5,
    rarity = 1,
    -- calculate = function(self, card, context)
    --     if context.joker_main then
    --         local suits_l = { 'Hearts', 'Diamonds', 'Spades', 'Clubs' }
    --         local suits = {}
    --         local count = 0
    --         for i = 1, #context.full_hand do
    --             if not SMODS.has_any_suit(context.full_hand[i]) then
    --                 for _, v in ipairs(suits_l) do
    --                     if context.full_hand[i]:is_suit(v, true) and not suits[v] then
    --                         suits[v] = true
    --                         count = count + 1
    --                         break
    --                     end
    --                 end
    --             else
    --                 count = count + 1
    --             end
    --         end
    --         if count >= 4 then
    --             return {
    --                 message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra } },
    --                 Xmult_mod = card.ability.extra
    --             }
    --         end
    --     end
    -- end
})
--#endregion

--#region Uncommon Jokers
SMODS.Joker:take_ownership("steel_joker", { config = { extra = 0.25 } })
SMODS.Joker:take_ownership("arrowhead", { config = { extra = 60 } })
SMODS.Joker:take_ownership("onyx_agate", { config = { extra = 9 } })
SMODS.Joker:take_ownership("drivers_license", { rarity = 2, config = {extra = 2.5}})
SMODS.Joker:take_ownership("reduced_gratification", { rarity = 2, cost = 7 })
SMODS.Joker:take_ownership("hack", {
    calculate = function(self, card, context)
        if context.repetition and (
                context.other_card:get_id() == 2 or 
                context.other_card:get_id() == 3 or 
                context.other_card:get_id() == 4 or 
                context.other_card:get_id() == 5 or
                context.other_card:get_id() == 6) then
                    return {
                        repetitions = 1,
                    }
        end
    end
})

SMODS.Joker:take_ownership("trousers", {
    rarity = 2,
    config = { extra = { mult = 2, chips = 4 }, mult = 0, chips = 0 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.chips, localize('Two Pair', 'poker_hands'), card.ability.mult, card.ability.chips } }
    end,
    calculate = function(self, card, context)
        if context.before and (next(context.poker_hands['Two Pair']) or next(context.poker_hands['Full House'])) and not context.blueprint then
            card.ability.mult = card.ability.mult + card.ability.extra.mult
            card.ability.chips = card.ability.chips + card.ability.extra.chips
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.RED
            }
        end
        if context.joker_main and (next(context.poker_hands['Two Pair']) or next(context.poker_hands['Full House'])) then
            return {
                mult = card.ability.mult,
                extra = { chips = card.ability.chips }
            }
        end

        if context.joker_main then
            return {}
        end
    end
})

local seanced = {}
SMODS.Joker:take_ownership("seance", {
    config = { extra = { odds = 2, poker_hand = 'Straight Flush' } },
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal, card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.cardarea == G.jokers and not context.game_over then
            local found = {}
            for _, v in ipairs(G.consumeables.cards) do
                if (v.config.center.set == "Tarot") and not seanced[v] then
                    found[#found + 1] = v
                end
            end
            if #found == 0 then return end
            -- if #found == 0 or pseudorandom(pseudoseed('seance')) > G.GAME.probabilities.normal / card.ability.extra.odds then return end

            local card = pseudorandom_element(found, pseudoseed('seance2'))

            seanced[card] = true
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                blocking = false,
                delay = 0.0,
                func = (function()
                    card:start_dissolve()
                    local card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, nil, 'sea')
                    card:add_to_deck()
                    G.consumeables:emplace(card)
                    seanced = {}
                    return true
                end)
            }))
            return {
                message = localize('k_plus_spectral'),
                colour = G.C.SECONDARY_SET.Spectral
            }
        end
        if context.joker_main then return {} end
    end
})

local function two_pairs(a, b)
    local next, t, k = pairs(a)
    local done, v = false, nil
    return function()
        k, v = next(t, k)
        if k == nil and not done then
            done = true
            next, t, k = pairs(b)
            k, v = next(b)
        end
        return k, v
    end
end

local raw_G_FUNCS_can_discard = G.FUNCS.can_discard
function G.FUNCS.can_discard(e)
    for k, v in two_pairs(SMODS.find_card("j_troubadour"), SMODS.find_card("j_biasedBalance_Minstrel")) do
        if v.ability and #G.hand.highlighted > v.ability.extra.discard_size then
            e.config.colour = G.C.UI.BACKGROUND_INACTIVE
            e.config.button = nil
            return
        end
    end
    raw_G_FUNCS_can_discard(e)
end

SMODS.Joker:take_ownership("troubadour", {
    config = { extra = { h_size = 2, h_plays = 0, discard_size = 4 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.h_size, card.ability.extra.discard_size } }
    end
})

SMODS.Joker:take_ownership("rough_gem", {
    config = { extra = { odds = 2, dollars = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal, card.ability.extra.odds, card.ability.extra.dollars } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit("Diamonds") then
            local amount = (pseudorandom(pseudoseed('rough_gem')) < G.GAME.probabilities.normal / card.ability.extra.odds)
                and card.ability.extra.dollars or 0
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + amount
            if not Talisman or not Talisman.config_file.disable_anims then
                G.E_MANAGER:add_event(Event {
                    func = function()
                        G.GAME.dollar_buffer = 0; return true
                    end
                })
            else
                G.GAME.dollar_buffer = 0
            end
            if amount == 0 then return {} end
            return {
                dollars = amount
            }
        end
    end
})

local raw_Card_shatter = Card.shatter
function Card:shatter(...)
    if self.config.center.key == 'm_glass' then
        G.GAME.BiasedBalance_shattered = (G.GAME.BiasedBalance_shattered or 0) + 1
    end
    return raw_Card_shatter(self, ...)
end

SMODS.Joker:take_ownership("glass", {
    config = { extra = 0.5 },
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra, (G.GAME.BiasedBalance_shattered or 0) * card.ability.extra + 1 } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = (G.GAME.BiasedBalance_shattered or 0) * card.ability.extra + 1
            }
        end

        if context.cards_destroyed or context.remove_playing_cards or context.using_consumeable then return {} end
    end
})

SMODS.Joker:take_ownership("red_card", {
    rarity = 2,
    config = { extra = 0.05 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra, card.ability.x_mult } }
    end,
    calculate = function(self, card, context)
        if context.open_booster and not context.blueprint then
            card.ability.x_mult = card.ability.x_mult + card.ability.extra
            G.E_MANAGER:add_event(Event {
                func = function()
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.x_mult } },
                        colour = G.C.RED,
                        delay = 0.45,
                        card = card
                    })
                    return true
                end
            })
            return {}
        end
        if context.joker_main then
            return { x_mult = card.ability.x_mult }
        end
    end,
})

SMODS.Joker:take_ownership("todo_list", {
    rarity = 1,
    cost = 5,
    perishable_compat = false,
    config = { extra = { dollars = 4, poker_hand = 'High Card', dx_mult = 0.15, played = false } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dx_mult, localize(card.ability.to_do_poker_hand, 'poker_hands'), card.ability.x_mult } }
    end,
    calculate = function(self, card, context)
        if context.before and context.scoring_name == card.ability.to_do_poker_hand then
            if card.ability.extra.played then
                return {}
            end
            card.ability.x_mult = card.ability.x_mult + card.ability.extra.dx_mult
            card.ability.extra.played = true
            return {
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.x_mult } },
                colour = G.C.RED
            }
        end
        if context.end_of_round and not context.blueprint then
            card.ability.extra.played = false
        end
        if context.joker_main then
            return { x_mult = card.ability.x_mult }
        end
    end,
})

SMODS.Joker:take_ownership("photograph", { rarity = 2 })
--#endregion

--#region Rare Jokers
SMODS.Joker:take_ownership("stuntman", { config = { extra = {chip_mod = 300, h_size = 2} } })
SMODS.Joker:take_ownership("vagabond", { config = { extra = 5 } })
SMODS.Joker:take_ownership("tribe", { config = { Xmult = 2.5, type = 'Flush' } })
SMODS.Joker:take_ownership("card_sharp", { cost = 8, rarity = 3 })
SMODS.Joker:take_ownership("trio", { config = {Xmult = 2.5, type = 'Three of a Kind'} })
SMODS.Joker:take_ownership("hologram", {config = {extra = 0.175, Xmult = 1} })

SMODS.Joker:take_ownership("invisible", {
    cost = 10,
    config = { extra = 3 },
    calculate = function(self, card, context)
        if context.selling_self and (card.ability.invis_rounds >= card.ability.extra) and not context.blueprint then
            local eval = function(card) return (card.ability.loyalty_remaining == 0) and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
            local my_ix
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_ix = i
                end
            end

            if not my_ix then
                card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = "???" })
                return {}
            end

            if #G.jokers.cards > my_ix and G.jokers.cards[my_ix + 1] then
                if #G.jokers.cards <= G.jokers.config.card_limit then
                    card_eval_status_text(card, 'extra', nil, nil, nil,
                        { message = localize('k_duplicated_ex') })
                    local chosen_joker = G.jokers.cards[my_ix + 1]
                    local card = copy_card(chosen_joker, nil, nil, nil,
                        chosen_joker.edition and chosen_joker.edition.negative)
                    if card.ability.invis_rounds then card.ability.invis_rounds = 0 end
                    card:add_to_deck()
                    G.jokers:emplace(card)
                    return nil, true
                else
                    card_eval_status_text(card, 'extra', nil, nil, nil,
                        { message = localize('k_no_room_ex') })
                end
            else
                card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = localize('k_no_other_jokers') })
            end

            return {}
        end
    end
})
--#endregion
