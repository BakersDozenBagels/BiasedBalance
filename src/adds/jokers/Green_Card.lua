SMODS.Joker {
    atlas = "Joker",
    key = "Green_Card",
    pos = {
        x = 0,
        y = 8
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = {  } },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end,
}

local card_set_cost_ref = Card.set_cost
function Card:set_cost()
    card_set_cost_ref(self)
    if next(SMODS.find_card("j_biasedBalance_Green_Card")) then
        if (self.ability.set == 'Booster') then self.cost = self.cost * 0.5 end
        self.sell_cost = math.max(1, math.floor(self.cost / 2)) + (self.ability.extra_value or 0)
        self.sell_cost_label = self.facing == 'back' and '?' or self.sell_cost
    end
end