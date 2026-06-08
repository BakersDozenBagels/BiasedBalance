local function add_unique_value(tbl, value)
  for _, v in pairs(tbl) do
    if v == value then
      return
    end
  end

  table.insert(tbl, value)
end

local function check_enhancements()
    local enhancements = {}
  if G.playing_cards then
    for _, v in pairs(G.playing_cards) do
        for k, _ in pairs(SMODS.get_enhancements(v)) do
          add_unique_value(enhancements, k)
        end
    end
  end

  local total =
      (enhancements and #enhancements or 0)

  return total
end

SMODS.Joker {
    atlas = "Joker",
    key = "Cietrzew",
    pos = {
        x = 10,
        y = 5
    },
    rarity = 2,
    cost = 7,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { money = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money, card.ability.extra.money * check_enhancements() } }
    end,
    calc_dollar_bonus = function(self, card)
        local enhancement_count = check_enhancements()
        if enhancement_count > 0 then
            return card.ability.extra.money * enhancement_count
        end
    end
}