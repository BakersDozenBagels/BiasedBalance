--[[

Copyright (C) 2025 Mills-44

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

SMODS.Voucher {
    object_type = "Voucher",
    key = 'recipe',
    --atlas = 'vouchers',
    pos = {
        x = 0,
        y = 0
    },
    config = { 
        choices = 1
    },
    unlocked = true,
    discovered = false,
    redeem = function(self)
        G.GAME.recipe = (G.GAME.recipe or 0) + self.ability.extra.choices
	end,
}

SMODS.Voucher {
    object_type = "Voucher",
    key = 'trade_secret',
    --atlas = 'vouchers',
    pos = {
        x = 0,
        y = 0
    },
    config = { 
        extra = { 
            choices = 1 
        } 
    },
    requires = { "v_biasedBalanced_trade_secret" },
    unlocked = true,
    discovered = false,
    redeem = function(self)
       G.GAME.trade_secret = (G.GAME.trade_secret or 0) + self.ability.choices
	end,
}