SMODS.Joker {
    atlas = "Joker",
    key = "MelancholicJoker",
    pos = {
        x = 4,
        y = 5
    },
    rarity = 3,
    cost = 9,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    config = { extra = { rounds = 2, } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        return { vars = { card.ability.extra.rounds, card.ability.invis_rounds or 0 } }
    end,
    calculate = function(self, card, context)
        if context.selling_self and (card.ability.invis_rounds >= card.ability.extra.rounds) and not context.blueprint then
            local jokers = {}
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] ~= card and not G.jokers.cards[i].edition then
                    jokers[#jokers + 1] = G.jokers.cards[i]
                end
            end
            if #jokers > 0 then
                card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = localize('negative', 'labels') })
                local chosen_joker = pseudorandom_element(jokers, pseudoseed('melancholic'))
                chosen_joker:set_edition('e_negative', true)
                return nil, true
            else
                card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = localize('k_no_other_jokers') })
            end
        end

        if context.end_of_round and not context.blueprint and not context.individual and not context.repetition then
            card.ability.invis_rounds = (card.ability.invis_rounds or 0) + 1
            if card.ability.invis_rounds == card.ability.extra.rounds then
                juice_card_until(card, function(x) return not x.REMOVED end, true)
            end
            return {
                message = ((card.ability.invis_rounds or 0) < card.ability.extra.rounds) and
                    (card.ability.invis_rounds .. '/' .. card.ability.extra.rounds) or localize('k_active_ex'),
                colour = G.C.FILTER
            }
        end
    end,
    load = function(self, card, card_table, other_card)
        if card_table.ability.invis_rounds >= card_table.ability.extra.rounds then
            juice_card_until(card, function(x) return not x.REMOVED end, true)
        end
    end
}