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

local poker_hands = {
    -- ["High Card"] = { 1, 15 }, -- Pluto
    -- ["Pair"] = { 1, 20 }, --Mercury
    ["Two Pair"] = { 2, 15 }, -- Uranus
    ["Three of a Kind"] = { 2, 20 }, -- Venus
    ["Straight"] = { 3, 35 }, -- Saturn
    ["Flush"] = { 2, 20 }, -- Jupiter
    ["Full House"] = { 3, 25 }, -- Earth
    ["Four of a Kind"] = { 3, 40 }, -- Mars
    ["Straight Flush"] = { 5, 50 }, -- Neptune
    ["Five of a Kind"] = { 4, 50, 16, 160 }, --Planet X
    ["Flush House"] = { 5, 40, 18, 175 }, -- Ceres
    ["Flush Five"] = { 5, 60, 22, 220 }, -- Eris
}

local raw_Game_init_game_object = Game.init_game_object
function Game:init_game_object()
    local ret = raw_Game_init_game_object(self)
    for k, v in pairs(poker_hands) do
        ret.hands[k].l_mult = v[1]
        ret.hands[k].l_chips = v[2]
        if v[3] then
            ret.hands[k].mult = v[3]
            ret.hands[k].s_mult = v[3]
            ret.hands[k].chips = v[4]
            ret.hands[k].s_chips = v[4]
        end
    end
    return ret
end

SMODS.Consumable:take_ownership('c_aura', {
    use = function(self, card)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                local over = false
                local edition = poll_edition('aura', nil, nil, true, {
                    { name = 'e_foil',       weight = 30 },
                    { name = 'e_holo',       weight = 22.5 },
                    { name = 'e_negative',   weight = 32.5 },
                    { name = 'e_polychrome', weight = 15 },
                })
                local aura_card = G.hand.highlighted[1]
                aura_card:set_edition(edition, true)
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
    end
})

local function destroy_highlighted(used_tarot)
    local destroyed_cards = {}
    for _, v in ipairs(G.hand.highlighted) do
        destroyed_cards[#destroyed_cards + 1] = v
    end
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
            play_sound('tarot1')
            used_tarot:juice_up(0.3, 0.5)
            return true
        end
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = function()
            for i = #destroyed_cards, 1, -1 do
                local card = destroyed_cards[i]
                if card.ability.name == 'Glass Card' then
                    card:shatter()
                else
                    card:start_dissolve(nil, i ~= #destroyed_cards)
                end
            end
            return true
        end
    }))
    return destroyed_cards
end

SMODS.Consumable:take_ownership('c_familiar', {
    config = {
        extra = {
            destroy = 1,
            create = 3,
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.destroy, card.ability.extra.create } }
    end,
    can_use = function(self, card)
        return #G.hand.highlighted == card.ability.extra.destroy
    end,
    use = function(self, card, area, copier)
        local used_tarot = copier or card
        local destroyed_cards = destroy_highlighted(used_tarot)
        G.E_MANAGER:add_event(Event {
            trigger = 'after',
            delay = 0.7,
            func = function()
                local cards = {}
                for i = 1, card.ability.extra.create do
                    local faces = {}
                    for _, v in ipairs(SMODS.Rank.obj_buffer) do
                        local r = SMODS.Ranks[v]
                        if r.face then table.insert(faces, r) end
                    end
                    local _suit, _rank =
                        pseudorandom_element(SMODS.Suits, pseudoseed('familiar_create')).card_key,
                        pseudorandom_element(faces, pseudoseed('familiar_create')).card_key
                    local cen_pool = {}
                    for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                        if v.key ~= 'm_stone' and not v.overrides_base_rank then
                            cen_pool[#cen_pool + 1] = v
                        end
                    end
                    cards[i] = create_playing_card({
                        front = G.P_CARDS[_suit .. '_' .. _rank],
                        center = pseudorandom_element(cen_pool, pseudoseed('spe_card'))
                    }, G.hand, nil, i ~= 1, { G.C.SECONDARY_SET.Spectral })
                end
                playing_card_joker_effects(cards)
                return true
            end
        })
        delay(0.3)
        SMODS.calculate_context { remove_playing_cards = true, removed = destroyed_cards }
    end
})

SMODS.Consumable:take_ownership('c_incantation', {
    config = {
        extra = {
            destroy = 1,
            create = 4,
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.destroy, card.ability.extra.create } }
    end,
    can_use = function(self, card)
        return #G.hand.highlighted == card.ability.extra.destroy
    end,
    use = function(self, card, area, copier)
        local used_tarot = copier or card
        local destroyed_cards = destroy_highlighted(used_tarot)
        G.E_MANAGER:add_event(Event {
            trigger = 'after',
            delay = 0.7,
            func = function()
                local cards = {}
                for i = 1, card.ability.extra.create do
                    local numbers = {}
                    for _, v in ipairs(SMODS.Rank.obj_buffer) do
                        local r = SMODS.Ranks[v]
                        if v ~= 'Ace' and not r.face then table.insert(numbers, r) end
                    end
                    local _suit, _rank =
                        pseudorandom_element(SMODS.Suits, pseudoseed('incantation_create')).card_key,
                        pseudorandom_element(numbers, pseudoseed('incantation_create')).card_key
                    local cen_pool = {}
                    for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                        if v.key ~= 'm_stone' and not v.overrides_base_rank then
                            cen_pool[#cen_pool + 1] = v
                        end
                    end
                    cards[i] = create_playing_card({
                        front = G.P_CARDS[_suit .. '_' .. _rank],
                        center = pseudorandom_element(cen_pool, pseudoseed('spe_card'))
                    }, G.hand, nil, i ~= 1, { G.C.SECONDARY_SET.Spectral })
                end
                playing_card_joker_effects(cards)
                return true
            end
        })
        delay(0.3)
        SMODS.calculate_context { remove_playing_cards = true, removed = destroyed_cards }
    end
})

local function lose_up_to(dollars)
    local lose = math.max(0, math.min(G.GAME.dollars - G.GAME.bankrupt_at, dollars))
    if lose ~= 0 then
        ease_dollars(-lose, true)
    end
end

SMODS.Consumable:take_ownership('c_wraith', {
    config = { extra = { pay = 10 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.pay } }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event {
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound 'timpani'
                local new_card = create_card('Joker', G.jokers, nil, 0.99, nil, nil, nil, 'wra')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                card:juice_up(0.3, 0.5)
                lose_up_to(card.ability.extra.pay)
                return true
            end
        })
        delay(0.6)
    end
})

local function juice_flip(used_tarot)
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
            play_sound('tarot1')
            used_tarot:juice_up(0.3, 0.5)
            return true
        end
    }))
    for i = 1, #G.hand.cards do
        local percent = 1.15 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
                G.hand.cards[i]:flip(); play_sound('card1', percent); G.hand.cards[i]:juice_up(0.3, 0.3); return true
            end
        }))
    end
end
SMODS.Consumable:take_ownership('c_sigil', {
    config = { extra = { pay = 5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.pay } }
    end,
    can_use = function(self, card)
        return #G.hand.highlighted == 1
    end,
    use = function(self, card, area, copier)
        local used_tarot = copier or card
        juice_flip(used_tarot)
        local _suit = G.hand.highlighted[1].base.suit
        for i = 1, #G.hand.cards do
            G.E_MANAGER:add_event(Event {
                func = function()
                    local _card = G.hand.cards[i]
                    assert(SMODS.change_base(_card, _suit))
                    return true
                end
            })
        end
        G.E_MANAGER:add_event(Event {
            func = function()
                lose_up_to(card.ability.extra.pay)
                return true
            end
        })
        for i = 1, #G.hand.cards do
            local percent = 0.85 + (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
            G.E_MANAGER:add_event(Event {
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.cards[i]:flip(); play_sound('tarot2', percent, 0.6); G.hand.cards[i]:juice_up(0.3, 0.3); return true
                end
            })
        end
        delay(0.5)
    end
})

SMODS.Consumable:take_ownership('c_ouija', {
    config = { extra = { select = 4, pay = 10 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.select, card.ability.extra.select - 1, card.ability.extra.pay } }
    end,
    can_use = function(self, card)
        return #G.hand.highlighted >= 2 and #G.hand.highlighted <= card.ability.extra.select
    end,
    use = function(self, card, area, copier)
        local rightmost = G.hand.highlighted[1]
        for i = 1, #G.hand.highlighted do
            if G.hand.highlighted[i].T.x > rightmost.T.x then
                rightmost = G.hand
                    .highlighted[i]
            end
        end

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip(); play_sound('card1', percent); G.hand.highlighted[i]:juice_up(0.3, 0.3); return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    if G.hand.highlighted[i] ~= rightmost then
                        copy_card(rightmost, G.hand.highlighted[i])
                    end
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event {
            func = function()
                lose_up_to(card.ability.extra.pay)
                return true
            end
        })
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip(); play_sound('tarot2', percent, 0.6); G.hand.highlighted[i]:juice_up(0.3,
                        0.3); return true
                end
            }))
        end
    end
})

SMODS.Consumable:take_ownership('c_immolate', {
    config = { extra = { select = 5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.select } }
    end,
    can_use = function(self, card)
        return #G.hand.highlighted >= 1 and #G.hand.highlighted <= card.ability.extra.select
    end,
    use = function(self, card, area, copier)
        local destroyed_cards = {}
        for i = #G.hand.highlighted, 1, -1 do
            destroyed_cards[#destroyed_cards + 1] = G.hand.highlighted[i]
        end
        G.E_MANAGER:add_event(Event {
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        })
        G.E_MANAGER:add_event(Event {
            trigger = 'after',
            delay = 0.2,
            func = function()
                for i = #G.hand.highlighted, 1, -1 do
                    local card = G.hand.highlighted[i]
                    if SMODS.shatters(card) then
                        card:shatter()
                    else
                        card:start_dissolve(nil, i == #G.hand.highlighted)
                    end
                end
                return true
            end
        })
        delay(0.3)
        SMODS.calculate_context { remove_playing_cards = true, removed = destroyed_cards }
    end
})

SMODS.Consumable:take_ownership('c_hex', {
    config = { extra = { pay = 10 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.pay } }
    end,
    use = function(self, card, area, copier)
        local temp_pool = card.eligible_editionless_jokers
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                local eligible_card = pseudorandom_element(temp_pool, pseudoseed 'hex')
                eligible_card:set_edition({ polychrome = true }, true)
                check_for_unlock { type = 'have_edition' }
                card:juice_up(0.3, 0.5)
                lose_up_to(card.ability.extra.pay)
                return true
            end
        }))
        delay(0.6)
    end
})

SMODS.Consumable:take_ownership('c_ankh', {
    loc_vars = function(self, info_queue, card)
        local main_end = nil
        if G.jokers and G.jokers.cards then
            for k, v in ipairs(G.jokers.cards) do
                if (v.edition and v.edition.negative) and (G.localization.descriptions.Other.remove_negative) then
                    info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
                    main_end = {}
                    localize { type = 'other', key = 'remove_negative', nodes = main_end, vars = {} }
                    main_end = main_end[1]
                    break
                end
            end
        end
        return { main_end = main_end }
    end,
    use = function(self, card, area, copier)
        local deletable_jokers = {}
        for k, v in pairs(G.jokers.cards) do
            if not v.ability.eternal then deletable_jokers[#deletable_jokers + 1] = v end
        end
        local chosen_joker = G.jokers.cards[1]
        local _first_dissolve = nil
        G.E_MANAGER:add_event(Event {
            trigger = 'before',
            delay = 0.75,
            func = function()
                for k, v in pairs(deletable_jokers) do
                    if v ~= chosen_joker then
                        v:start_dissolve(nil, _first_dissolve)
                        _first_dissolve = true
                    end
                end
                return true
            end
        })
        G.E_MANAGER:add_event(Event {
            trigger = 'before',
            delay = 0.4,
            func = function()
                local card = copy_card(chosen_joker, nil, nil, nil,
                    chosen_joker.edition and chosen_joker.edition.negative)
                card:start_materialize()
                card:add_to_deck()
                if card.edition and card.edition.negative then
                    card:set_edition(nil, true)
                end
                G.jokers:emplace(card)
                return true
            end
        })
    end
})
