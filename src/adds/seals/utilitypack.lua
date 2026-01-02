SMODS.Booster {
    key = 'UtilityPack',
    group_key = "k_booster_group_p_biasedBalance_Utility",
    atlas = 'Boosters',
    pos = { x = 0, y = 0 },
    config = {
        extra = 2,
        choose = 1
    },
    cost = 5,
    weight = 1.5,
    loc_vars = function()
        return { vars = { 1, 2 } }
    end,
    create_card = function(self, pack, i)
        return create_card("Utility", G.pack_cards, nil, nil, true, false, nil, "Utility_Pack")
    end
}
--[[
Chaos The Clown, 
Splash, 
Juggler, 
Drunkard, 
Four Fingers, 
Pareidolia, 
Burglar, 
Shortcut, 
Midas Mask, 
Smeared Joker, 
Showman, 
Merry Andy, Oops! All 6s, Hanging Chad, Mime, Hack, Seltzer, Sock and Bustin, Minstrel, Poacher, 
Burnt Joker, Astronomer, Spice, Granite Joker, Last Dance, Propitious Joker, Shape Shifter, Jester, Negative Norman, Negative Nancy, Smurf, Light in the tunnel]]