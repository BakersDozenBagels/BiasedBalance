local function get_level_five_hands()
    local count = 0
    for hand_name, hand in pairs(G.GAME.hands) do
        if hand.level >= 5 then
            count = count + 1
        end
    end
    return count
end

local function sync_hand_size(card, add)
    local target_hand_size = math.min(get_level_five_hands() * card.ability.extra.hand_size, card.ability.extra.max)
    local current_hand_size = card.ability.extra.current_hand_size or 0

    if add then
        local delta = target_hand_size - current_hand_size
        if delta ~= 0 then
            G.hand:change_size(delta)
            card.ability.extra.current_hand_size = target_hand_size
        end
    else
        if current_hand_size ~= 0 then
            G.hand:change_size(-current_hand_size)
            card.ability.extra.current_hand_size = 0
        end
    end
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
            sync_hand_size(card, true)
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        sync_hand_size(card, true)
    end,
    remove_from_deck = function(self, card, from_debuff)
        sync_hand_size(card, false)
    end,
}
