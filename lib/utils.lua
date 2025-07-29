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

--Banned Jokers
local function ban()
    local banned_jokers = {
        { "8_ball", "smiley",  "superposition", "walkie_talkie" },
        { "ceremonial", "loyalty_card", "dusk", "seeing_double", "matador" },
        { "campfire",   "hit_the_road", "acrobat" }
    }

    local function ban_one(key, rarity)
        G.P_CENTERS[key] = nil
        SMODS.Centers[key] = nil
        for _, pool in pairs(G.P_CENTER_POOLS) do
            local ix = 1
            while ix < #pool do
                if pool[ix].key == key then
                    table.remove(pool, ix)
                else
                    ix = ix + 1
                end
            end
        end
        local ix = 1
        while ix < #SMODS.Center.obj_buffer do
            if SMODS.Center.obj_buffer[ix] == key then
                table.remove(SMODS.Center.obj_buffer, ix)
            else
                ix = ix + 1
            end
        end
        if rarity then
            ix = 1
            while ix < #G.P_JOKER_RARITY_POOLS[rarity] do
                if G.P_JOKER_RARITY_POOLS[rarity][ix].key == key then
                    table.remove(G.P_JOKER_RARITY_POOLS[rarity], ix)
                else
                    ix = ix + 1
                end
            end
        end
    end

    for i, row in pairs(banned_jokers) do
        for _, v in pairs(row) do
            ban_one("j_" .. v, i)
        end
    end

    -- Banned Consumables
    ban_one("c_grim")
    
end

local raw_Game_init_item_prototypes = Game.init_item_prototypes

function Game:init_item_prototypes()
    raw_Game_init_item_prototypes(self)
    ban()
end

ban()
--#endregion

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

    if G.GAME.selected_back and G.GAME.selected_back.effect and G.GAME.selected_back.effect.center and
        G.GAME.selected_back.effect.center.key == 'b_biasedBalance_White' and
        not blind.boss then
        local jokers_to_create = math.min(1, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
        G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
        G.E_MANAGER:add_event(Event({
            func = function()
                for i = 1, jokers_to_create do
                    local card = create_card('Joker', G.jokers, nil, 0, nil, nil, nil, 'b_biasedBalance_White')
                    card:add_to_deck()
                    G.jokers:emplace(card)
                    card:start_materialize()
                    G.GAME.joker_buffer = 0
                end
                return true
            end
        }))
    end
end

