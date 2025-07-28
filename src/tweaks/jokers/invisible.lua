SMODS.Joker:take_ownership("invisible", {
    cost = 10,
    config = { extra = 3 },
    calculate = function(self, card, context)
        if context.selling_self and (card.ability.invis_rounds >= card.ability.extra) and not context.blueprint then
            local eval = function(card) return (card.ability.loyalty_remaining == 0) and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
            local my_ix
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_ix = i
                end
            end

            if not my_ix then
                card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = "???" })
                return {}
            end

            if #G.jokers.cards > my_ix and G.jokers.cards[my_ix + 1] then
                if #G.jokers.cards <= G.jokers.config.card_limit then
                    card_eval_status_text(card, 'extra', nil, nil, nil,
                        { message = localize('k_duplicated_ex') })
                    local chosen_joker = G.jokers.cards[my_ix + 1]
                    local card = copy_card(chosen_joker, nil, nil, nil,
                        chosen_joker.edition and chosen_joker.edition.negative)
                    if card.ability.invis_rounds then card.ability.invis_rounds = 0 end
                    card:add_to_deck()
                    G.jokers:emplace(card)
                    return nil, true
                else
                    card_eval_status_text(card, 'extra', nil, nil, nil,
                        { message = localize('k_no_room_ex') })
                end
            else
                card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = localize('k_no_other_jokers') })
            end

            return {}
        end
    end
})