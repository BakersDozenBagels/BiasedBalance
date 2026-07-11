SMODS.Joker {
    atlas = "Joker",
    key = "Peafowl",
    pos = {
        x = 6,
        y = 0
    },
    rarity = 1,
    cost = 6,
    pools = {
        Utility = true
    },
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = { },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    add_to_deck = function(self, card)
        for _, v in pairs(G.playing_cards) do
            G.GAME.Biased_Balance.has_peafowl = true
        end
    end,
    remove_from_deck = function(self, card)
        for _, v in pairs(G.playing_cards) do
            G.GAME.Biased_Balance.has_peafowl = false
        end
    end
}

--[[
local updateref = Card.update
function Card:update(dt)
  local ref = updateref(self, dt)
  if self.config.center == G.P_CENTERS.c_base then
    return ref
  end
  if not G.pack_cards and ((self.area == G.play and G.play) or (self.area == G.hand and G.hand) or (self.area == G.deck and G.deck)) then
    local applied = self.ability.peafowl_applied or {}
    self.ability.peafowl_applied = applied

    local current_count = #SMODS.find_card("j_biasedBalance_Peafowl")

    local prev_count = applied["j_biasedBalance_Peafowl"] or 0
    local diff = current_count - prev_count

    if diff > 0 then
      for i = 1, diff do
        peafowl_enhancement_calc(
          self, -- card
          "*", -- equation
          1.5, -- extra_value
          -- exclusions VVVh_x_chips = 1, h_x_mult = 1, Xmult = 1, Xchips = 1, x_chips = 1, x_mult = 1, xchips = 1, xmult = 1,
          {  extra_value=true, card_limit=true },
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
          "/", -- equation
          1.5, -- extra_value
          -- exclusions VVVh_x_chips = 1, h_x_mult = 1, Xmult = 1, Xchips = 1, x_chips = 1, x_mult = 1, xchips = 1, xmult = 1,
          {  extra_value=true, card_limit=true },
          nil, -- inclusions
          true, -- do_round
          false, -- only
          "ability" -- extra_search
        )
      end
    end

    applied["j_biasedBalance_Peafowl"] = current_count
  end
  return ref
end

]]