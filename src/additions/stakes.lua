--[[

Copyright (C) 2025 Mills 44

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

SMODS.Atlas {
    key = "stakes",
    path = "stakes.png",
    px = 28,
    py = 28
}

SMODS.Stake{
    key = "pink",
    atlas = "stakes",
    pos = { 
        x = 0,
        y = 0 
    },
    applied_stakes = { "gold" },
    modifiers = function()
        G.GAME.win_ante = 9
        if G.GAME.ante == 9 then
            G.GAME.show_boss = true
        end
    end,
    order = 9,
    colour = HEX("ff27cc")
}

SMODS.Stake{
    key = "silver",
    atlas = "stakes",
    pos = { 
        x = 1,
        y = 0 
    },
    applied_stakes = { "biasedBalance_pink" },
}