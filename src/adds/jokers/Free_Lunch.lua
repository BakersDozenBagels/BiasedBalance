SMODS.Joker {
    atlas = "Joker",
    key = "FreeLunch",
    pos = {
        x = 3,
        y = 3
    },
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { 30, 35 } }
    end
}

local unpack = table.unpack or unpack
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
end