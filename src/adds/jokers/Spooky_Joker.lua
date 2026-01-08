SMODS.Joker {
    atlas = "Joker",
    key = "Spooky",
    pos = {
        x = 9,
        y = 2
    },
    pools = {
        Utility = true
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = {odds = 4} },
    loc_vars = function(self, info_queue, card)
        return { vars = { SMODS.get_probability_vars(
                    card,
                    1,
                    card.ability.extra.odds,
                    'j_biasedBalance_Spooky',
                    false)} }
    end,
    calculate = function(self, card, context)
        if context.before then
            if SMODS.pseudorandom_probability(
                            card,
                            'j_biasedBalance_Spooky',
                            1,
                            card.ability.extra.odds,
                            'j_biasedBalance_Spooky'
                        )then
                    local cards = {}
                    local edition = poll_edition('j_biasedBalance_Spooky', nil, nil, true, {
                        { name = 'e_foil',       weight = 30 },
                        { name = 'e_holo',       weight = 22.5 },
                        { name = 'e_negative',   weight = 32.5 },
                        { name = 'e_polychrome', weight = 15 },
                    })
                    for i = 1, #context.scoring_hand do
                        if context.scoring_hand[i]:get_edition() == nil then
                            table.insert(cards, context.scoring_hand[i])
                        end
                    end
                    G.E_MANAGER:add_event(Event({trigger = 'after', func = function()
                        if cards and #cards > 0 then
                            --card:juice_up(0.7)
                            cards[math.random(#cards)]:set_edition(edition, true)
                        end
                    return true end}))
                end
            return {}, true
        end
    end
}