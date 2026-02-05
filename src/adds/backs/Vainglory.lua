SMODS.Back {
    key = 'Vainglory',
    atlas = 'Backs',
    pos = {
        x = 2,
        y = 1
    },
    config = {  },
    loc_vars = function(self, info_queue, back)
        return { vars = {  } }
    end,
    calculate = function(self, card, context) 
        if context.end_of_round then
            G.GAME.current_round.voucher = SMODS.get_next_vouchers()
        end
    end
}