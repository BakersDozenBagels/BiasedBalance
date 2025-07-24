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

BiasedBalance = {}

assert(SMODS.load_file('src/tweaks/consumables.lua'))()
assert(SMODS.load_file('src/tweaks/vouchers.lua'))()
assert(SMODS.load_file('src/tweaks/jokers.lua'))()
assert(SMODS.load_file('src/tweaks/tags.lua'))()
assert(SMODS.load_file('src/tweaks/backs.lua'))()
assert(SMODS.load_file('src/tweaks/editions.lua'))()
assert(SMODS.load_file('src/tweaks/rarities.lua'))()
assert(SMODS.load_file('src/tweaks/stakes.lua'))()
assert(SMODS.load_file('src/tweaks/enhancements.lua'))()

assert(SMODS.load_file('lib/pools.lua'))()

assert(SMODS.load_file('src/additions/backs.lua'))()
assert(SMODS.load_file('src/additions/jokers.lua'))()
assert(SMODS.load_file('src/additions/tags.lua'))()
assert(SMODS.load_file('src/additions/spectrals.lua'))()
assert(SMODS.load_file('src/additions/vouchers.lua'))()

