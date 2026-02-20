SMODS.Joker {
    atlas = "Joker",
    key = "Risotto",
    pos = {
        x = 3,
        y = 8
    },
    rarity = 2,
    cost = 7,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    config = { extra = { tags = 4, tagpool = {'tag_uncommon', 'tag_rare', 'tag_foil', 'tag_holo', 'tag_polychrome', 'tag_negative'} } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.tags } }
    end,
    calculate = function(self, card, context)
        if context.ending_shop then
            G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag(Tag(pseudorandom_element(card.ability.extra.tagpool, pseudoseed('risotto'))))
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end)
            }))

            card.ability.extra.tags = card.ability.extra.tags - 1
            card:juice_up()

            if card.ability.extra.tags <= 0 then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize('k_eaten_ex'),
                    colour = G.C.RED
                }
            end
        end
    end
}