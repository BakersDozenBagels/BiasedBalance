SMODS.Joker {
    atlas = "Joker",
    key = "Discounted_Joker",
    pos = {
        x = 12,
        y = 0
    },
    rarity = 1,
    cost = 6,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = { 
        extra = { 
            shop_spend = 20,
            current_amount = 0,
            active = false
        } 
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.shop_spend,
                card.ability.extra.current_amount
        } 
    }
    end,
    calculate = function(self, card, context)
        if context.end_of_round then 
            card.ability.extra.active = true
        end

        if context.ending_shop then
                card.ability.extra.current_amount = 0
                card.ability.extra.active = false
        end

        if context.money_altered and context.from_shop and card.ability.extra.active and not context.blueprint then
            if context.amount < 0 then
                card.ability.extra.current_amount = card.ability.extra.current_amount - context.amount
            end
        end

        if context.money_altered and context.from_shop and card.ability.extra.active then
            if card.ability.extra.active and card.ability.extra.current_amount >= card.ability.extra.shop_spend then
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    card.ability.extra.current_amount = card.ability.extra.shop_spend
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                            SMODS.add_card {
                                set = 'Tarot',
                                key_append = 'Discounted_Joker'
                            }
                            return true
                        end
                    }))
                    SMODS.calculate_effect({ message = localize('k_plus_tarot'), colour = G.C.PURPLE },
                        context.blueprint_card or card)
                end
                card.ability.extra.active = false
            end
        end
    end,
}