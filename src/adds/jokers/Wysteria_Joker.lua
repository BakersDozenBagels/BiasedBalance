SMODS.Joker {
    atlas = "Joker",
    key = "Wysteria_Joker",
    pos = {
        x = 1,
        y = 0
    },
    rarity = 1,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            chips = 0,
            chip_gain = 15,
            chip_lose = 10,
            count = 0
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
        -- Reset count at start of scoring
        if context.first_card then
            card.ability.extra.count = 0
        end

        -- Count how many cards are in scoring hand
        if context.individual and context.cardarea == G.play then
            card.ability.extra.count = (card.ability.extra.count or 0) + 1
            if card.ability.extra.count == 5 then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain
            else 
                card.ability.extra.chips = card.ability.extra.chips - card.ability.extra.chip_lose
                if card.ability.extra.chips < 0 then
                    card.ability.extra.chips = 0
                end
            end
        end

        if context.joker_main then
            return {
                   chips = card.ability.extra.chips
                }

         end
end
}