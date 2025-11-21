SMODS.Joker:take_ownership("loyalty_card", { 
    no_collection = true,
	in_pool = function(self, args)
		return false
	end, })