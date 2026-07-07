--[[

Copyright (C) 2025  BakersDozenBagels

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

]]                                     --

SMODS.Back:take_ownership("black", {
    config = { fake_hands = -1, fake_joker_slot = 1, fake_money = 1 },
    loc_vars = function(self, info_queue, back)
        local vars = nil
        if G.GAME.Biased_Balance.pink_stake_active then
            vars = { self.config.fake_joker_slot, self.config.fake_hands, self.config.fake_money } 
            vars.key = 'b_black_pink'
        else 
            vars = { self.config.fake_joker_slot, self.config.fake_hands } 
            vars.key = 'b_black'
        end
        return vars
    end,
    apply = function(self, back)
        if G.GAME.Biased_Balance.pink_stake_active then
            G.GAME.starting_params.discards = G.GAME.starting_params.discards + self.config.fake_hands
            G.GAME.starting_params.joker_slots = G.GAME.starting_params.joker_slots + self.config.fake_joker_slot
            G.GAME.starting_params.dollars = G.GAME.starting_params.dollars - self.config.fake_money
        else
            G.GAME.starting_params.discards = G.GAME.starting_params.discards + self.config.fake_hands
            G.GAME.starting_params.joker_slots = G.GAME.starting_params.joker_slots + self.config.fake_joker_slot
        end
    end,
}) -- Tweak in editions.lua

