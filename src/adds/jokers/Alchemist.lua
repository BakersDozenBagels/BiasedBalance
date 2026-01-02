SMODS.Joker {
    atlas = "Joker",
    key = "Alchemist",
    pos = {
        x = 6,
        y = 2
    },
    rarity = 1,
    cost = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { hands = 1, discards = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.hands, card.ability.extra.discards } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            G.E_MANAGER:add_event(Event({
                func = function()
                    ease_discard(-card.ability.extra.discards)
                    ease_hands_played(card.ability.extra.hands)
                    SMODS.calculate_effect(
                        { message = localize { type = 'variable', key = 'a_hands', vars = { card.ability.extra.hands } } },
                        context.blueprint_card or card)
                    SMODS.calculate_effect(
                        { message = localize { type = 'variable', key = 'a_biasedBalance_m_discards', vars = { card.ability.extra.discards } } },
                        context.blueprint_card or card)
                    return true
                end
            }))
            return nil, true -- This is for Joker retrigger purposes
        end
    end
}