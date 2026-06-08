--[[local b_ut = SMODS.Booster {
    key = 'UtilityPack_Mega',
    group_key = "k_booster_group_p_biasedBalance_Utility",
    atlas = 'Boosters',
    no_collection = true,
    pos = { x = 0, y = 0 },
    config = {
        extra = 4,
        choose = 2
    },
    cost = 5,
    weight = 1.5,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,
    create_card = function(self, pack, i)
        local card = create_card("Utility", G.pack_cards, nil, nil, true, false, nil, "Utility_Pack")

        if not G.GAME.modifiers.all_eternal then
            card:set_eternal(false)
        end
        card:set_perishable(false)
        card:set_rental(false)

        local choice = pseudorandom 'LowStickerBuffoon'
        if choice < 0.1 and G.GAME.modifiers.enable_eternals_in_shop then
                    card:set_eternal(true)
                elseif choice < 0.2 and G.GAME.modifiers.enable_perishables_in_shop and not card.ability.eternal then
                    card:set_perishable(true)
                end

        if pseudorandom 'LowStickerBuffoon' < 0.1 and G.GAME.modifiers.enable_rentals_in_shop then
            card:set_rental(true)
        end
        return card
    end
}]]

SMODS.Tag {
    key = 'Utility',
    atlas = 'Tags',
    pos = { x = 1, y = 0 },
    min_ante = 2,
    config = {
        choose = 2,
        from = 4,
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.p_biasedBalance_UtilityPackMega
        return { vars = { self.config.choose, self.config.from } }
    end,
    apply = function(self, card, context)
        if context.type == 'new_blind_choice' then
            card:yep('+', G.C.PURPLE, function()
                local booster = SMODS.create_card { key = 'p_biasedBalance_UtilityPackMega', area = G.play }
                booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
                booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
                booster.T.w = G.CARD_W * 1.27
                booster.T.h = G.CARD_H * 1.27
                booster.cost = 0
                booster.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = booster } })
                booster:start_materialize()
                --G.CONTROLLER.locks[lock] = nil
                return true
            end)
            card.triggered = true
            return true
        end
    end
}