SMODS.Joker {
    atlas = "Joker",
    key = "Peafowl",
    pos = {
        x = 6,
        y = 0
    },
    rarity = 1,
    cost = 3,
    pools = {
        Utility = true
    },
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = 0.5 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra * 100 } }
    end,
    add_to_deck = function(self, card)
        for _, v in pairs(G.playing_cards) do
            v:update(v.real_dt)
        end
    end,
    remove_from_deck = function(self, card)
        for _, v in pairs(G.playing_cards) do
            v:update(v.real_dt)
        end
    end
}

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
    end

    applied["j_biasedBalance_Peafowl"] = current_count
  end
  return ref
end

-- Borrowed code from All in Jest
peafowl_enhancement_calc = function(card, equation, extra_value, exclusions, inclusions, do_round, only, extra_search)
  -- Store original values before modification
  local keys, original_values = peafowl_original_values(card, "nil", 0, exclusions, inclusions, do_round, only, extra_search)

  local operators = {
    ["+"] = function(a, b) return a + b end,
    ["-"] = function(a, b) return a - b end,
    ["*"] = function(a, b) return a * b end,
    ["/"] = function(a, b) return a / b end,
    ["%"] = function(a, b) return a % b end,
    ["="] = function(a, b) return b end,
  }

  local function round_int(x)
    return x >= 0 and math.floor(x + 0.5) or math.ceil(x - 0.5)
  end

  local function round_hundredth(x)
    if x >= 0 then
      return math.floor(x * 100 + 0.5) / 100
    else
      return math.ceil(x * 100 - 0.5) / 100
    end
  end

  local function process_value(val, base_val)
    if type(val) == "number" then
      local delta = val - base_val
      local result = operators[equation](base_val, extra_value) + delta
      if do_round then
        if base_val % 1 ~= 0 then
          return round_hundredth(result)
        else
          return round_int(result)
        end
      else
        return result
      end
    else
      return val
    end
  end

  local function should_process(key, value)
    if type(key) ~= "string" then return true end
    if inclusions and next(inclusions) then
      local valid = false
      for _, prefix in ipairs(inclusions) do
        if (not only and key:sub(1, #prefix) == prefix) or (only and key == prefix) then
          valid = true; break
        end
      end
      if not valid then return false end
    end
    if exclusions and exclusions[key] ~= nil then
      if exclusions[key] == true or value == exclusions[key] then
        return false
      end
    end
    return true
  end

  local function process_table(t, base_table)
    for key, value in pairs(t) do
      if value ~= nil and should_process(key, value) then
        if type(value) == "number" then
          t[key] = process_value(value, base_table[key] or 0)
        elseif type(value) == "table" and type(base_table[key]) == "table" then
          process_table(value, base_table[key])
        end
      end
    end
  end

  local function nested_tables(temcard, index)
      local current = temcard
      for key in string.gmatch(index, "[^%.]+") do
          if type(current) ~= "table" then
              return current
          end
          current = current[key]
      end
      return current
  end

  local search_table = extra_search and nested_tables(card, extra_search) or card.ability

  if search_table then
    local _, base_values = peafowl_original_values(card, "nil", 0, exclusions, inclusions, do_round, only, extra_search)
    if type(search_table) == "number" then
      search_table = process_value(search_table, base_values[1] or 0)
    elseif type(search_table) == "table" then
      local base_map = {}
      for i, k in ipairs(keys) do base_map[k] = original_values[i] end
      process_table(search_table, base_map)
    end
  end
end

peafowl_original_values = function(card, equation, extra_value, exclusions, inclusions, do_round, only, extra_search)
  local keys = {}
  local values = {}

  local operators = {
    ["+"] = function(a, b) return a + b end,
    ["-"] = function(a, b) return a - b end,
    ["*"] = function(a, b) return a * b end,
    ["/"] = function(a, b) return a / b end,
    ["%"] = function(a, b) return a % b end,
    ["="] = function(a, b) return b end,
    ["nil"] = function(a, b) return a end,
  }

  local function round_int(x)
    return x >= 0 and math.floor(x + 0.5) or math.ceil(x - 0.5)
  end
  local function round_hundredth(x)
    if x >= 0 then
      return math.floor(x * 100 + 0.5) / 100
    else
      return math.ceil(x * 100 - 0.5) / 100
    end
  end

  local function process_value(val)
    if type(val) == "number" then
      local res = operators[equation](val, extra_value)
      if do_round then
        if val % 1 ~= 0 then
          return round_hundredth(res)
        else
          return round_int(res)
        end
      else
        return res
      end
    else
      return val
    end
  end

  local function should_process(key, value)
    if type(key) ~= "string" then return true end
    if inclusions and next(inclusions) then
      local valid = false
      for _, prefix in ipairs(inclusions) do
        if (not only and key:sub(1, #prefix) == prefix) or (only and key == prefix) then
          valid = true; break
        end
      end
      if not valid then return false end
    end
    if exclusions and exclusions[key] ~= nil then
      if exclusions[key] == true or value == exclusions[key] then
        return false
      end
    end
    return true
  end

  local function nested_tables(temcard, index)
      local current = temcard
      for key in string.gmatch(index, "[^%.]+") do
          if type(current) ~= "table" then
              return current
          end
          current = current[key]
      end
      return current
  end

  local search_table = extra_search and nested_tables(card, extra_search) or card.ability

  if search_table then
    if type(search_table) == "number" then
      table.insert(keys, extra_search or "ability")
      table.insert(values, process_value(search_table))
    elseif type(search_table) == "table" then
      for key, value in pairs(search_table) do
        if value ~= nil and should_process(key, value) then
          table.insert(keys, key)
          table.insert(values, process_value(value))
        end
      end
    end
  end

  return keys, values
end