---Registers a list of items in a custom order
---@param items table
---@param path string
function BiasedBalance.file_loader(items, path)
  for i = 1, #items do
    SMODS.load_file(path .. "/" .. items[i] .. ".lua")()
  end
end

---Returns true with probability `chance` (0.0 to 1.0)
---@param chance number
---@return boolean
function BiasedBalance.random_chance(chance)
  return math.random() < chance
end

function BiasedBalance.is_numbered(card)
    return card.base and card.base.value and not SMODS.Ranks[card.base.value].face and card:get_id() ~= 14
end

function BiasedBalance.is_odd(card)
    if not card.base then return false end
    return (BiasedBalance.is_numbered(card) and card.base.nominal%2 == 1) or card:get_id() == 14
end

function BiasedBalance.is_even(card)
    if not card.base then return false end
    return (BiasedBalance.is_numbered(card) and card.base.nominal%2 == 0) or card:get_id() == 14
end

function BiasedBalance.reroll_scale()
    return G.GAME.modifiers.reroll_scale or 1
end

function BiasedBalance.on_set_blind(blind)
    for i = 1, #G.GAME.tags do
        G.GAME.tags[i]:apply_to_run({
            type = 'biasedBalance_set_blind',
            blind = blind
        })
    end

  end
