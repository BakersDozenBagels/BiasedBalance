SMODS.Tag:take_ownership("uncommon", {
    apply = function(self, tag, context)
        if context.type ~= 'store_joker_create' or tag.triggered then return end
        tag.triggered = true
        local card = create_card('Joker', context.area, nil, 0.9, nil, nil, nil, 'uta')
        create_shop_card_ui(card, 'Joker', context.area)
        card.states.visible = false
        if not G.GAME.modifiers.all_eternal then
            card:set_eternal(false)
        end
        card:set_perishable(false)
        card:set_rental(false)
        tag:yep('+', G.C.GREEN, function()
            card:start_materialize()
            card.ability.couponed = true
            card:set_cost()
            return true
        end)
        return card
    end
})