--#region Banned Jokers
local function ban()
    local banned_jokers = {
        { "8_ball","smiley", "superposition", "walkie_talkie" },
        { "ceremonial", "loyalty_card", "dusk", "seeing_double", "matador", "acrobat" },
        { "campfire" }
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
    ban_one("c_grim")
    
end
local raw_Game_init_item_prototypes = Game.init_item_prototypes
function Game:init_item_prototypes()
    raw_Game_init_item_prototypes(self)
    ban()
end

ban()
--#endregion