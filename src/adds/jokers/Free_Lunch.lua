SMODS.Joker {
    atlas = "Joker",
    key = "FreeLunch",
    pos = {
        x = 3,
        y = 3
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = { 36, 36 } }
    end,
    add_to_deck = function(self, card, from_debuff)
        ease_dollars(36)
        card.sell_cost = -36
    end,
}

local unpack = table.unpack or unpack--[[
local raw_Card_set_cost = Card.set_cost
function Card:set_cost(...)
    if self.config.center.key == 'j_biasedBalance_FreeLunch' then
        self.sell_cost = -35
        self.cost = -30
        self.sell_cost_label = self.facing == 'back' and '?' or self.sell_cost
        return
    end

    local ret = { raw_Card_set_cost(self, ...) }

    return unpack(ret)
end]]