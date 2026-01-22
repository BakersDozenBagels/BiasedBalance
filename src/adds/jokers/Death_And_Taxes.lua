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