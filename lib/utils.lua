---Registers a list of items in a custom order
---@param items table
---@param path string
function BiasedBalance.file_loader(items, path)
  for i = 1, #items do
    SMODS.load_file(path .. "/" .. items[i] .. ".lua")()
  end
end

-- Iterates over two tables in sequence
local function two_pairs(a, b)
    local next, t, k = pairs(a)
    local done, v = false, nil
    return function()
        k, v = next(t, k)
        if k == nil and not done then
            done = true
            next, t, k = pairs(b)
            k, v = next(b)
        end
        return k, v
    end
end

-- Used for Troubadour and Minstrel
local raw_G_FUNCS_can_discard = G.FUNCS.can_discard
function G.FUNCS.can_discard(e)
    for k, v in two_pairs(SMODS.find_card("j_troubadour"), SMODS.find_card("j_biasedBalance_Minstrel")) do
        if v.ability and #G.hand.highlighted > v.ability.extra.discard_size then
            e.config.colour = G.C.UI.BACKGROUND_INACTIVE
            e.config.button = nil
            return
        end
    end
    raw_G_FUNCS_can_discard(e)
end

-- Lose up to `dollars` amount of money, without going below 0
---@param dollars number
function BiasedBalance.lose_up_to(dollars)
    local lose = math.max(0, math.min(G.GAME.dollars - G.GAME.bankrupt_at, dollars))
    if lose ~= 0 then
        ease_dollars(-lose, true)
    end
end

-- Destroys highlighted cards and returns a list of them
---@param used_tarot any
function BiasedBalance.destroy_highlighted(used_tarot)
    local destroyed_cards = {}
    for _, v in ipairs(G.hand.highlighted) do
        destroyed_cards[#destroyed_cards + 1] = v
    end
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
            play_sound('tarot1')
            used_tarot:juice_up(0.3, 0.5)
            return true
        end
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = function()
            for i = #destroyed_cards, 1, -1 do
                local card = destroyed_cards[i]
                if card.ability.name == 'Glass Card' then
                    card:shatter()
                else
                    card:start_dissolve(nil, i ~= #destroyed_cards)
                end
            end
            return true
        end
    }))
    return destroyed_cards
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
