SMODS.Blind {
    key = "Kappa",
    atlas = "blinds",
    pos = {
        x = 0,
        y = 9
    },
    boss = {
		min = 4,
	},
    boss_colour = HEX("e5c563"),
    
}
-- Thank you All In Jest for the code
local kappa_half = function(card)
    if card.ability.set == 'Joker' then
        card.ability.gamma_applied = card.ability.gamma_applied or {}

        local current_count = (not G.GAME.blind.disabled and G.GAME.blind.name == 'bl_biasedBalance_Kappa' and 1) or 0

        local prev_count = card.ability.gamma_applied["bl_biasedBalance_Kappa"] or 0
        local diff = current_count - prev_count

        card.ability.gamma_applied["bl_biasedBalance_Kappa"] = current_count

        if diff > 0 then
            card:remove_from_deck(true)
            for _ = 1, math.abs(diff) do
                peafowl_enhancement_calc(
                    card,
                    "/", 
                    2,
                    { x_chips = 1, x_mult = 1, extra_value = true, rarity = true, card_limit = true },
                    nil, false, nil, "ability"
                )
            end
            card:add_to_deck(true)
        elseif diff < 0 then
            card:remove_from_deck(true)
            for _ = 1, math.abs(diff) do
                peafowl_enhancement_calc(
                    card,
                    "*", 2,
                    { x_chips = 1, x_mult = 1, extra_value = true, rarity = true, card_limit = true },
                    nil, false, nil, "ability"
                )
            end
            card:add_to_deck(true)
        end
    end
end

local function contains_number(table, exclusions)
    for k, v in pairs(table) do
        if exclusions and exclusions[k] ~= nil and (exclusions[k] == true or exclusions[k] == v) then
        else
            if type(v) == "number" and v ~= 0 then
                return true
            elseif type(v) == "table" and contains_number(v, exclusions) then
                return true
            end
        end
    end
    return false
end

local contains = function(tbl, item)
    for k, v in pairs(tbl) do
        if v == item then
            return true
        end
    end
    return false
end

local updateref = Card.update
function Card:update(dt)
    local ref = updateref(self, dt)
    if G.jokers and self.ability.set == 'Joker'
    and contains_number(self.config.center.config, { x_chips = 1, x_mult = 1, extra_value = true, rarity = true, card_limit = true }) 
    and contains(SMODS.get_card_areas('jokers'), self.area) then
        kappa_half(self)
    end
    return ref
end


--[[
local updateref = Card.update
function Card:update(dt)
  local ref = updateref(self, dt)
  if self.config.center == G.P_CENTERS.c_base then
    return ref
  end
  if not G.pack_cards and ((self.area == G.play and G.play) or (self.area == G.hand and G.hand) or (self.area == G.deck and G.deck)) then
    local applied = self.ability.gamma_applied or {}
    self.ability.gamma_applied = applied

    local current_count = (not G.GAME.blind.disabled and G.GAME.blind.name == 'bl_biasedBalance_Kappa' and 1) or 0

    local prev_count = applied["bl_biasedBalance_Kappa"] or 0
    local diff = current_count - prev_count

    if diff > 0 then
      for i = 1, diff do
        peafowl_enhancement_calc(
          self, -- card
          "/", -- equation
          1.5, -- extra_value
          -- exclusions VVV
          { h_x_chips = 1, Xmult = 1, x_chips = 1, x_mult = 1, extra_value=true, card_limit=true },
          nil, -- inclusions
          true, -- do_round
          false, -- only
          "ability" -- extra_search
        )
      end
    elseif diff < 0 then
      for i = 1, -diff do
        peafowl_enhancement_calc(
          self, -- card
          "*", -- equation
          1.5, -- extra_value
          -- exclusions VVV
          { h_x_chips = 1, Xmult = 1, x_chips = 1, x_mult = 1, extra_value=true, card_limit=true },
          nil, -- inclusions
          true, -- do_round
          false, -- only
          "ability" -- extra_search
        )
      end
    end

    applied["bl_biasedBalance_Kappa"] = current_count
  end
  return ref
end]]