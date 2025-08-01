SMODS.Joker {
    atlas = "Joker",
    key = "Wysteria_Joker",
    pos = {
        x = 0,
        y = 0
    },
    rarity = 1,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    config = {
        extra = {
            chips = 0,
            chip_gain = 15,
            chip_lose = 10,
            size = 5
        }
    },
    loc_vars = function(self, info_queue, card)
        return { 
            vars = { 
                card.ability.extra.chip_gain,
                card.ability.extra.chip_lose,
                card.ability.extra.chips,
        } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and #context.full_hand == card.ability.extra.size then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain
        else
            local prev_chips = card.ability.extra.chips
            card.ability.extra.chips = math.max(0, card.ability.extra.chips - card.ability.extra.chip_lose)
            if card.ability.extra.chips ~= prev_chips then
                return {
                   chips = card.ability.extra.chips
                    }
            end
        end
    end
}