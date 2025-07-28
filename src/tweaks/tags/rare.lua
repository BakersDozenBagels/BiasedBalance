SMODS.Tag:take_ownership("rare", {
    apply = function(self, tag, context)
        if context.type ~= 'store_joker_create' or tag.triggered then return end
        tag.triggered = true
        local rares_in_possession = { 0 }
        for k, v in ipairs(G.jokers.cards) do
            if v.config.center.rarity == 3 and not rares_in_possession[v.config.center.key] then
                rares_in_possession[1] = rares_in_possession[1] + 1
                rares_in_possession[v.config.center.key] = true
            end
        end

        if #G.P_JOKER_RARITY_POOLS[3] > rares_in_possession[1] then
            local card = create_card('Joker', context.area, nil, 1, nil, nil, nil, 'rta')
            create_shop_card_ui(card, 'Joker', context.area)
            card.states.visible = false
            if not G.GAME.modifiers.all_eternal then
                card:set_eternal(false)
            end
            card:set_perishable(false)
            card:set_rental(false)
            tag:yep('+', G.C.RED, function()
                card:start_materialize()
                card.ability.couponed = true
                card:set_cost()
                return true
            end)
            return card
        else
            tag:nope()
        end
    end
})