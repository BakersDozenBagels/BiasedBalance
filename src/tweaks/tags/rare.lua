SMODS.Tag:take_ownership("rare", {
    loc_vars = function(self, info_queue, card)
        local vars = { vars = { } }
        if G.GAME.modifiers.enable_eternals_in_shop then
            vars.key = 'tag_rare_sticker'
        end
        return vars
    end,
    apply = function(self, tag, context)
        if context.type ~= 'store_joker_create' or tag.triggered then return end
        tag.triggered = true

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
    end
})