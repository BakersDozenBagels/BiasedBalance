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

--#region Uncommon Jokers


SMODS.Joker:take_ownership("drivers_license", { rarity = 2, config = {extra = 2.5}})
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
--#endregion

--#region Rare Jokers
SMODS.Joker:take_ownership("stuntman", { config = { extra = {chip_mod = 300, h_size = 2} } })
SMODS.Joker:take_ownership("vagabond", { config = { extra = 5 } })
SMODS.Joker:take_ownership("tribe", { config = { Xmult = 2.5, type = 'Flush' } })
SMODS.Joker:take_ownership("card_sharp", { cost = 8, rarity = 3 })
SMODS.Joker:take_ownership("trio", { config = {Xmult = 2.5, type = 'Three of a Kind'} })

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
