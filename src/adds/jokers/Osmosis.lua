SMODS.Joker {
    atlas = "Joker",
    key = "Osmosis",
    pos = {
        x = 10,
        y = 3
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            mult = 5,
            minus = 2
        }
    },
    loc_vars = function(self, info_queue, card)
        local size = G.GAME.starting_deck_size - card.ability.extra.minus
        return { vars = { card.ability.extra.mult, size, card.ability.extra.mult * math.max(0, G.playing_cards and #G.playing_cards - size or 0) } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and not context.individual then
            local size = G.GAME.starting_deck_size - card.ability.extra.minus
            if #G.playing_cards > size then
                return { mult = card.ability.extra.mult * (#G.playing_cards - size) }
            end
        end
    end
}