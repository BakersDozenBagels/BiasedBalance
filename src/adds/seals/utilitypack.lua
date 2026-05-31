SMODS.Booster {
    key = 'UtilityPack',
    group_key = "k_booster_group_p_biasedBalance_Utility",
    atlas = 'Boosters',
    pos = { x = 0, y = 0 },
    config = {
        extra = 2,
        choose = 1
    },
    cost = 4,
    weight = 0.3,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,
    create_card = function(self, pack, i)
        return create_card("Utility", G.pack_cards, nil, nil, true, false, nil, "Utility_Pack")
    end
}
SMODS.Booster {
    key = 'UtilityPack2',
    group_key = "k_booster_group_p_biasedBalance_Utility",
    atlas = 'Boosters',
    pos = { x = 0, y = 1 },
    config = {
        extra = 2,
        choose = 1
    },
    cost = 4,
    weight = 0.3,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,
    create_card = function(self, pack, i)
        return create_card("Utility", G.pack_cards, nil, nil, true, false, nil, "Utility_Pack")
    end
}
SMODS.Booster {
    key = 'UtilityPackJumbo',
    group_key = "k_booster_group_p_biasedBalance_JumboUtility",
    atlas = 'Boosters',
    pos = { x = 1, y = 1 },
    config = {
        extra = 4,
        choose = 1
    },
    cost = 6,
    weight = 0.3,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,
    create_card = function(self, pack, i)
        return create_card("Utility", G.pack_cards, nil, nil, true, false, nil, "Utility_Pack")
    end
}
SMODS.Booster {
    key = 'UtilityPackMega',
    group_key = "k_booster_group_p_biasedBalance_MegaUtility",
    atlas = 'Boosters',
    pos = { x = 2, y = 1 },
    config = {
        extra = 4,
        choose = 2
    },
    cost = 8,
    weight = 0.07,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,
    create_card = function(self, pack, i)
        return create_card("Utility", G.pack_cards, nil, nil, true, false, nil, "Utility_Pack")
    end
}