local rare_sticker_tags = { "negative", "foil", "holo", "polychrome" }
for _, tag_type in ipairs(rare_sticker_tags) do
    SMODS.Tag:take_ownership(tag_type, {
        loc_vars = function(self, info_queue, card)
            local vars = { vars = { } }
            if G.GAME.modifiers.enable_eternals_in_shop then
                if tag_type == "negative" then
                    vars.key = 'tag_negative_sticker'
                elseif tag_type == "foil" then
                    vars.key = 'tag_foil_sticker'
                elseif tag_type == "holo" then
                    vars.key = 'tag_holo_sticker'
                elseif tag_type == "polychrome" then
                    vars.key = 'tag_polychrome_sticker'
                end
            end
            return vars
        end,
        apply = function(self, tag, context)
            if context.type == 'store_joker_modify' and not context.card.edition and not context.card.temp_edition and context.card.config.center.set == 'Joker' then
                if not G.GAME.modifiers.all_eternal then
                    context.card:set_eternal(false)
                end
                context.card:set_perishable(false)
                context.card:set_rental(false)

                local choice = pseudorandom("sticker_tag_" .. tag_type)
                if choice < 0.1 and G.GAME.modifiers.enable_eternals_in_shop then
                    context.card:set_eternal(true)
                elseif choice < 0.2 and G.GAME.modifiers.enable_perishables_in_shop and not context.card.ability.eternal then
                    context.card:set_perishable(true)
                end

                if pseudorandom("sticker_tag_" .. tag_type) < 0.1 and G.GAME.modifiers.enable_rentals_in_shop then
                    context.card:set_rental(true)
                end
            end
        end
    })
end