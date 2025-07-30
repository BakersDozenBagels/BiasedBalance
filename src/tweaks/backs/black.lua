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

SMODS.Back:take_ownership("black", {}) -- Tweak in editions.lua
SMODS.Back:take_ownership("ghost", {})
SMODS.Back:take_ownership("yellow", {
 config = {dollars = 12}
})

SMODS.Booster:take_ownership_by_kind('Spectral', {
    get_weight = function(self)
        if G.GAME.selected_back.effect.center.key == "b_ghost" then
            return self.weight * 3
        end
        return self.weight
    end
}, true)
