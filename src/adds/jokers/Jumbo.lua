SMODS.Joker {
    atlas = "Joker",
    key = "Jumbo",
    pos = {
        x = 2,
        y = 0
    },
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { slots = 1, mult = 20 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.slots } }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.slots
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.slots
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return { mult = card.ability.extra.mult }
        end
    end
}