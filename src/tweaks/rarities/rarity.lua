local function count_awakenings()
    return G.GAME.biasedBalance_awakening or 0
end
local function has_pink_deck()
    return G.GAME.selected_back.effect.center.key == 'b_biasedBalance_Pink' and 1 or 0
end
local function count_caviar()
    return #SMODS.find_card('j_biasedBalance_Caviar')
end

SMODS.Rarity:take_ownership("Common", {
    default_weight = 0.67,
    get_weight = function(self, weight, object_type)
        return self.default_weight - 0.27 * (has_pink_deck() + count_caviar()) - 0.03 * count_awakenings()
    end
})
SMODS.Rarity:take_ownership("Uncommon", {
    default_weight = 0.27,
    get_weight = function(self, weight, object_type)
        return self.default_weight + 0.18 * (has_pink_deck() + count_caviar()) + 0.02 * count_awakenings()
    end
})
SMODS.Rarity:take_ownership("Rare", {
    default_weight = 0.06,
    get_weight = function(self, weight, object_type)
        return self.default_weight + 0.09 * (has_pink_deck() + count_caviar()) + 0.01 * count_awakenings()
    end
})
