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

--Load Lib Files
SMODS.load_file("lib/content.lua")() -- Definitions 
SMODS.load_file("lib/utils.lua")() -- Utility functions built
SMODS.load_file("lib/pools.lua")()

-- Lovely Fixes
SMODS.load_file("lovely/fixes.toml")

-- TWEAKS
BiasedBalance.file_loader(BiasedBalance.Back_Tweaks, "src/tweaks/backs")
BiasedBalance.file_loader(BiasedBalance.Blind_Tweaks, "src/tweaks/blinds")
BiasedBalance.file_loader(BiasedBalance.Edition_Tweaks, "src/tweaks/editions")
BiasedBalance.file_loader(BiasedBalance.Enhancement_Tweaks, "src/tweaks/enhancements")
BiasedBalance.file_loader(BiasedBalance.Joker_Tweaks, "src/tweaks/jokers")
BiasedBalance.file_loader(BiasedBalance.Planet_Tweaks, "src/tweaks/planets")
BiasedBalance.file_loader(BiasedBalance.Rarity_Tweaks, "src/tweaks/rarities")
BiasedBalance.file_loader(BiasedBalance.Spectral_Tweaks, "src/tweaks/spectrals")
BiasedBalance.file_loader(BiasedBalance.Stake_Tweaks, "src/tweaks/stakes")
BiasedBalance.file_loader(BiasedBalance.Tag_Tweaks, "src/tweaks/tags")
BiasedBalance.file_loader(BiasedBalance.Tarot_Tweaks, "src/tweaks/tarots")
BiasedBalance.file_loader(BiasedBalance.Voucher_Tweaks, "src/tweaks/vouchers")

-- ADDS
BiasedBalance.file_loader(BiasedBalance.Back_Adds, "src/adds/backs")
BiasedBalance.file_loader(BiasedBalance.Blind_Adds, "src/adds/blinds")
BiasedBalance.file_loader(BiasedBalance.Joker_Adds, "src/adds/jokers")
BiasedBalance.file_loader(BiasedBalance.Spectral_Adds, "src/adds/spectrals")
BiasedBalance.file_loader(BiasedBalance.Stake_Adds, "src/adds/stakes")
BiasedBalance.file_loader(BiasedBalance.Tag_Adds, "src/adds/tags")
BiasedBalance.file_loader(BiasedBalance.Voucher_Adds, "src/adds/vouchers")

-- ||           ATLAS           ||

SMODS.Atlas {
    key  = "Backs", 
    path = "Backs.png", 
    px   = 71,
    py   = 95,
}

SMODS.Atlas {
    key  = "Joker", 
    path = "Jokers.png", 
    px   = 71,
    py   = 95,
}

SMODS.Atlas {
    key  = "Spectrals", 
    path = "Spectrals.png", 
    px   = 71,
    py   = 95,
}

SMODS.Atlas {
    key  = "Stakes", 
    path = "Stakes.png", 
    px   = 71,
    py   = 95,
}

SMODS.Atlas {
    key = "Tags",
    path = "Tags.png",
    px = 34,
    py = 34
}

--SMODS.Atlas {
  --  key = "Vouchers",
  --  path = "Vouchers.png",
  --  px = 71,
  --  py = 95
--}

