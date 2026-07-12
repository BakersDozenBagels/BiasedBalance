-- Borrowed code from All in Jest
local peafowl_original_values = function(card, equation, extra_value, exclusions, inclusions, do_round, only, extra_search)
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

local peafowl_enhancement_calc = function(card, equation, extra_value, exclusions, inclusions, do_round, only, extra_search)
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

  local function process_value(val, base_val, key)
    if type(val) == "number" then
      local delta = val - base_val
      local operator_base = base_val
      --h_x_chips = 1, h_x_mult = 1, Xmult = 1, Xchips = 1, x_chips = 1, x_mult = 1, xchips = 1, xmult = 1,
      local special = (key == "x_mult" or key == "x_chips" or key == "h_x_chips" or key == "h_x_mult" or key == "Xmult" or key == "Xchips"
      or key == "xmult" or key == "xchips") and base_val >= 1

      if special then
        operator_base = operator_base - 1
      end

      local result = operators[equation](operator_base, extra_value)

      if special then
        result = result + 1
      end

      result = result + delta

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
          t[key] = process_value(value, base_table[key] or 0, key)
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
    mult = 2,
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
                    {extra_value = true, rarity = true, card_limit = true },
                    nil, false, nil, "ability"
                )
            end
            card:add_to_deck(true)
        elseif diff < 0 then
            --h_x_chips = 1, h_x_mult = 1, Xmult = 1, Xchips = 1, x_chips = 1, x_mult = 1, xchips = 1, xmult = 1,
            card:remove_from_deck(true)
            for _ = 1, math.abs(diff) do
                peafowl_enhancement_calc(
                    card,
                    "*", 2,
                    { extra_value = true, rarity = true, card_limit = true },
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

