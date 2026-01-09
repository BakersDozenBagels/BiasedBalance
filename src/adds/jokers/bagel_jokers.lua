
SMODS.Joker {
    atlas = "Joker",
    key = "Poacher",
    pos = {
        x = 6,
        y = 3
    },
    rarity = 2,
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = 7 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
        return { vars = { G.GAME.probabilities.normal, card.ability.extra } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if not context.other_card.biasedBalance_buffer and pseudorandom 'j_biasedBalance_Poacher' < G.GAME.probabilities.normal / card.ability.extra then
                local other_card = context.other_card
                other_card.biasedBalance_buffer = true
                card = context.blueprint_card or card
                G.E_MANAGER:add_event(Event {
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        play_sound('tarot1')
                        card:juice_up(0.3, 0.5)
                        other_card.biasedBalance_buffer = nil
                        return true
                    end
                })
                G.E_MANAGER:add_event(Event {
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        other_card:flip()
                        play_sound('card1', 0.85)
                        other_card:juice_up(0.3, 0.3)
                        return true
                    end
                })
                delay(0.2)
                G.E_MANAGER:add_event(Event {
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        other_card:set_ability(G.P_CENTERS.m_wild)
                        return true
                    end
                })
                G.E_MANAGER:add_event(Event {
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        other_card:flip()
                        play_sound('tarot2', 0.85, 0.6)
                        other_card:juice_up(0.3, 0.3)
                        return true
                    end
                })
                delay(0.5)
            end
            return nil, true
        end
    end
}


--#endregion

--#region Rare Jokers
SMODS.Joker {
    atlas = "Joker",
    key = "Rivals",
    pos = {
        x = 1,
        y = 6
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            x_mult = 2.25,
            hand = 'Two Pair'
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult, localize(card.ability.extra.hand, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and not context.individual and next(context.poker_hands[card.ability.extra.hand]) then
            return { x_mult = card.ability.extra.x_mult }
        end
    end
}

SMODS.Joker {
    atlas = "Joker",
    key = "BluntedImpact",
    pos = {
        x = 2,
        y = 6
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            x_mult = 3,
        }
    },
    loc_vars = function(self, info_queue, card)
        local name
        if G.GAME.biasedBalance_priorHand == nil then
            name = localize('biasedBalance_none', 'text')
        else
            name = localize(G.GAME.biasedBalance_priorHand, 'poker_hands')
        end
        return { vars = { card.ability.extra.x_mult, name } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and not context.individual and G.GAME.biasedBalance_priorHand and context.scoring_name ~= G.GAME.biasedBalance_priorHand then
            return { x_mult = card.ability.extra.x_mult }
        end
    end
}

local raw_evaluate_play_after = evaluate_play_after
function evaluate_play_after(name, ...)
    local ret = { raw_evaluate_play_after(name, ...) }
    G.GAME.biasedBalance_priorHand = name
    return unpack(ret)
end

local raw_ease_round = ease_round
function ease_round(...)
    G.GAME.biasedBalance_priorHand = nil
    return raw_ease_round(...)
end

SMODS.Joker {
    atlas = "Joker",
    key = "DeathAndTaxes",
    pos = {
        x = 3,
        y = 6
    },
    rarity = 3,
    cost = 7,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { x_mult = 3, } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and not context.individual and card.ability.extra.active then
            return { x_mult = card.ability.extra.x_mult }
        end

        if context.selling_card and context.card.config.center.set == 'Joker' and not card.ability.extra.active then
            card.ability.extra.active = true
            juice_card_until(card, function() return card.ability.extra.active end, true)
            return {
                message = localize 'k_active'
            }
        end

        if context.end_of_round then
            card.ability.extra.active = false
        end
    end,
    load = function(self, card, card_table, other_card)
        if card_table.ability.extra.active then
            juice_card_until(card, function() return card.ability.extra.active end, true)
        end
    end,
    add_to_deck = function(self, card, from_debuff)
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
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end
}

SMODS.Joker {
    atlas = "Joker",
    key = "FlavourfulJoker",
    pos = {
        x = 4,
        y = 6
    },
    rarity = 3,
    cost = 9,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { chips = 75 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local count = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].edition then count = count + 1 end
            end
            if count >= 0 then
                return { chips = card.ability.extra.chips * count }
            end
        end
    end,
}

SMODS.Joker {
    atlas = "Joker",
    key = "BrashGambler",
    pos = {
        x = 0,
        y = 6
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { odds1 = 2, odds2 = 4, mult1 = 2, mult2 = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal, card.ability.extra.odds1, card.ability.extra.mult1, card.ability.extra.odds2, card.ability.extra.mult2 } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local res = nil
            if pseudorandom('j_biasedBalance_BrashGambler') * card.ability.extra.odds2 < G.GAME.probabilities.normal then
                res = {
                    x_mult = card.ability.extra.mult2
                }
            end
            if pseudorandom('j_biasedBalance_BrashGambler') * card.ability.extra.odds1 < G.GAME.probabilities.normal then
                res = {
                    x_mult = card.ability.extra.mult1,
                    extra = res
                }
            end
            return res, true
        end
    end
}

SMODS.Joker {
    atlas = "Joker",
    key = "Bookworm",
    pos = {
        x = 7,
        y = 6
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { chips = 200 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local highest = true
            local play_more_than = (G.GAME.hands[context.scoring_name].played or 0)
            for k, v in pairs(G.GAME.hands) do
                if k ~= context.scoring_name and v.played >= play_more_than and v.visible then
                    highest = false
                end
            end
            if not highest then
                return { chips = card.ability.extra.chips }
            end
        end
    end
}

SMODS.Joker {
    atlas = "Joker",
    key = "Court",
    pos = {
        x = 8,
        y = 6
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { xmult = 3.5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            for k, v in pairs(context.scoring_hand) do
                if not v:is_face() then return end
            end
            return { x_mult = card.ability.extra.xmult }
        end
    end
}

SMODS.Joker {
    atlas = "Joker",
    key = "Parvenu",
    pos = {
        x = 9,
        y = 6
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { xmult = 2.5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            for k, v in pairs(context.scoring_hand) do
                if v:is_face() then return end
            end
            return { x_mult = card.ability.extra.xmult }
        end
    end
}

SMODS.Joker {
    atlas = "Joker",
    key = "Skipper",
    pos = {
        x = 10,
        y = 6
    },
    rarity = 3,
    cost = 7,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { xmult = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            for _, v in pairs(G.GAME.round_resets.blind_states) do
                if v == 'Skipped' then
                    return { x_mult = card.ability.extra.xmult }
                end
            end
        end
    end
}

SMODS.Joker {
    atlas = "Joker",
    key = "Minstrel",
    pos = {
        x = 11,
        y = 6
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = { d_size = 2, extra = { discard_size = 4 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.d_size, card.ability.extra.discard_size } }
    end
}
--#endregion
