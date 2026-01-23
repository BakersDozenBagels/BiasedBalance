SMODS.Joker {
    atlas = "Joker",
    key = "Negative_Nancy",
    pos = {
        x = 2,
        y = 5
    },
    rarity = 2,
    cost = 8,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = {extra = {cards = 40, cards_scored = 40, negative_count = 0} },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.cards,
                card.ability.extra.cards_scored
        } 
    }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            card.ability.extra.cards_scored = card.ability.extra.cards_scored - 1
            if card.ability.extra.cards_scored <= 0 then
                card.ability.extra.cards_scored = card.ability.extra.cards
                card.ability.extra.negative_count = card.ability.extra.negative_count + 1
            end
        end
        if context.after and not context.blueprint then
            if card.ability.extra.negative_count > 0 then
                local editionless_cards = SMODS.Edition:get_edition_cards(G.play, true)
                if #editionless_cards == 0 then
                    return
                end
                for i = 1, card.ability.extra.negative_count do
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                local eligible_card = pseudorandom_element(editionless_cards, 'negative_nancy')
                                eligible_card:set_edition({ negative = true })
                                card:juice_up(0.3, 0.5)
                                delay(0.5)
                            return true
                        end
                    }))
                end
                card.ability.extra.negative_count = 0
                return {
                    message = localize('j_biasedBalance_Negative'),
                    colour = G.C.SECONDARY_SET.Edition
                }
            end
        end
    end
}