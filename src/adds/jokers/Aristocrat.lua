SMODS.Joker {
    atlas = "Joker",
    key = "Aristocrat",
    pos = {
        x = 8,
        y = 7
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { chips = 10 } },
    loc_vars = function(self, info_queue, card)
        if G.playing_cards then
            local face_count = 0
            for _, c in ipairs(G.playing_cards) do
                if c:is_face() then
                    face_count = face_count + 1
                end
            end
            return { vars = { card.ability.extra.chips, face_count * card.ability.extra.chips } }
        end
        return { vars = { card.ability.extra.chips, 0 } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local face_count = 0
            for _, c in ipairs(G.playing_cards) do
                if c:is_face() then
                    face_count = face_count + 1
                end
            end
            return {
                chips = math.max(0, card.ability.extra.chips * (face_count))
            }
        end
    end,
}