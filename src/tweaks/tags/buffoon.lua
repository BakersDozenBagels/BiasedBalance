--[[

Copyright (C) 2025  BakersDozenBagels and Mills-44

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.

]] --








local b_buf = SMODS.Booster {
    key = 'LowStickerBuffoon',
    no_collection = true,
    pos = { x = 3, y = 8 },
    config = {
        extra = 4,
        choose = 2
    },
    weight = 0,
    loc_vars = function()
        return { vars = { 4, 2 }, key = 'p_buffoon_mega' }
    end,
    create_card = function(self, pack, i)
        local card = G.P_CENTERS.p_buffoon_mega_1:create_card(pack, i)

        if type((_card_to_spawn or {}).is) ~= 'function' or not _card_to_spawn:is(Card) then
            card = SMODS.create_card(card)
        end

        if not G.GAME.modifiers.all_eternal then
            card:set_eternal(false)
        end
        card:set_perishable(false)
        card:set_rental(false)

        local choice = pseudorandom 'LowStickerBuffoon'
        if choice < 0.1 and G.GAME.modifiers.enable_eternals_in_shop then
                    card:set_eternal(true)
                elseif choice < 0.2 and G.GAME.modifiers.enable_perishables_in_shop and not card.ability.eternal then
                    card:set_perishable(true)
                end

        if pseudorandom 'LowStickerBuffoon' < 0.1 then
            card:set_rental(true)
        end
        return card
    end,
    in_pool = function() return false end
}

SMODS.Tag:take_ownership("buffoon", {
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            tag:yep('+', G.C.PURPLE, function()
                local booster = Card(G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
                    G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2, G.CARD_W * 1.27, G.CARD_H * 1.27, G.P_CARDS.empty,
                    b_buf, { bypass_discovery_center = true, bypass_discovery_ui = true })
                booster.cost = 0
                booster.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = booster } })
                booster:start_materialize()
                return true
            end)
            tag.triggered = true
            return true
        end
    end
})
