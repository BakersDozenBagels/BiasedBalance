SMODS.Booster {
    key = 'UtilityPack',
    group_key = "k_booster_group_p_biasedBalance_Utility",
    atlas = 'Boosters',
    pos = { x = 0, y = 0 },
    config = {
        extra = 2,
        choose = 1
    },
    cost = 5,
    weight = 1.5,
    loc_vars = function()
        return { vars = { 1, 2 } }
    end,
    create_card = function(self, pack, i)
        return create_card("Utility", G.pack_cards, nil, nil, true, false, nil, "Utility_Pack")
    end
}