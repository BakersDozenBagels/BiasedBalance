SMODS.Tag {
    key = 'Hone',
    atlas = 'Tags',
    pos = { x = 2, y = 0 },
    min_ante = 2,
    loc_vars = function()
        return { 
            vars = { 
                
            } 
        }
    end,
    apply = function(self, tag, context)
        if context.type == "immediate" then
            local jokers = {}
            for k, v in ipairs(G.jokers.cards) do
                if not v.edition then 
                    jokers[#jokers + 1] = v                
                end
            end
            if #jokers > 0 then
                local lock = tag.ID
				G.CONTROLLER.locks[lock] = true
                local joker = pseudorandom_element(jokers, pseudoseed('hone_tag'))
                tag:yep("+", G.C.BLUE, function()
					local edition = pseudorandom_element(BiasedBalance.Hone_Tag_Editions, pseudoseed('choice'))
                    joker:set_edition(edition, nil, true)
                    joker:juice_up()
					G.CONTROLLER.locks[lock] = nil
					return true
				end)
            else
				tag:nope()
			end
            tag.triggered = true
            return true
        end
    end
}