SMODS.Tag {
    key = 'Hone',
    atlas = 'Tags',
    pos = { x = 0, y = 0 },
    min_ante = 2,
    loc_vars = function()
        return { 
            vars = { 
                
            } 
        }
    end,
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            tag.triggered = true
            local jokers = {}
        for k, v in ipairs(G.jokers.cards) do
            if not v.edition then 
                jokers[#jokers + 1] = v                
            end
        end
        local joker = pseudorandom_element(jokers, pseudoseed('hone_tag'))
            local edition = pseudorandom_element(BiasedBalance.Hone_Tag_Editions, pseudoseed('choice'))
            joker:set_edition(edition, nil, true)
        end
    end
}