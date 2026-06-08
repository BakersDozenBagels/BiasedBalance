local function get_level_five_hands()
    local count = 0
    for hand_name, hand in pairs(G.GAME.hands) do
        if hand.level >= 5 then
            count = count + 1
        end
    end
    return count
end

SMODS.Joker {
    atlas = "Joker",
    key = "Yodeller",
    pos = {
        x = 0,
        y = 7
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { hand_size = 1, current_hand_size = 0, max = 3, previous_hand_size = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.hand_size, card.ability.extra.current_hand_size, card.ability.extra.max } }
    end,
    update = function(self, card, dt)
        if card.area == G.jokers then
            local level_five_hands = get_level_five_hands()
            local new_hand_size = math.min(level_five_hands * card.ability.extra.hand_size, card.ability.extra.max)
            if new_hand_size ~= card.ability.extra.current_hand_size then
                card.ability.extra.current_hand_size = new_hand_size
            end
            if card.ability.extra.previous_hand_size ~= card.ability.extra.current_hand_size then
                card.ability.extra.previous_hand_size = card.ability.extra.current_hand_size
                G.hand:change_size(1)
            end
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        local level_five_hands = get_level_five_hands()
        local new_hand_size = math.min(level_five_hands * card.ability.extra.hand_size, card.ability.extra.max)
        if new_hand_size ~= card.ability.extra.current_hand_size then
            G.hand:change_size(new_hand_size - card.ability.extra.current_hand_size)
            card.ability.extra.current_hand_size = new_hand_size
        end
        G.hand:change_size(card.ability.extra.current_hand_size)
    end,
    remove_from_deck = function(self, card, from_debuff)
        local level_five_hands = get_level_five_hands()
        local new_hand_size = math.min(level_five_hands * card.ability.extra.hand_size, card.ability.extra.max)
        if new_hand_size ~= card.ability.extra.current_hand_size then
            G.hand:change_size(new_hand_size - card.ability.extra.current_hand_size)
            card.ability.extra.current_hand_size = new_hand_size
        end
        G.hand:change_size(-card.ability.extra.current_hand_size)
    end,
}
