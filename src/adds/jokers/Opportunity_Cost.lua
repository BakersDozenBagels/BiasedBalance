SMODS.Joker {
    atlas = "Joker",
    key = "Opportunity_Cost",
    pos = {
        x = 5,
        y = 7
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = {  } },
    loc_vars = function(self, q, card)
        if card.area and card.area == G.jokers then
            local jokers = {}
            if G.jokers then
                for i, v in pairs(G.jokers.cards) do
                    if v ~= card then jokers[#jokers+1] = v end
                end
                table.sort(jokers, function(a, b)
                    return a.ability.timelapse_order < b.ability.timelapse_order
                end)
            end
            local other_joker = G.jokers and jokers[#jokers]
            local compatible = other_joker and other_joker ~= card and (other_joker.config.center.blueprint_compat)
            local none = not jokers[1]
            local main_end = {
                    {
                        n = G.UIT.C,
                        config = { align = "bm", minh = 0.4 },
                        nodes = {
                            {
                                n = G.UIT.C,
                                config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                                nodes = {
                                    { n = G.UIT.T, config = { text = ' ' .. localize('k_' .. (compatible and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                                }
                            }
                        }
                    }
                }
            return {
                main_end = main_end
            }
        end
    end,
    calculate = function(self, card, context)
        local jokers = {}
        for i, v in pairs(G.jokers.cards) do
            if v ~= card then jokers[#jokers+1] = v end
        end
        table.sort(jokers, function(a, b)
            return a.ability.timelapse_order < b.ability.timelapse_order
        end)
        return SMODS.blueprint_effect(card, jokers[#jokers], context) or {}
    end,
}

-- Thank you horsechicot for the code
local emplace_ref = CardArea.emplace
function CardArea:emplace(card, ...)
    emplace_ref(self, card, ...)
    if self == G.jokers then
        G.GAME.timelapse_order = (G.GAME.timelapse_order or 0) + 1
        card.ability.timelapse_order = G.GAME.timelapse_order
    end
end