
/*------------------------------------------------------------------------
    File        : DayFour_p1.p
    Purpose     : 
    Notes       :
  ----------------------------------------------------------------------*/

block-level on error undo, throw.

def temp-table ttWord
    field line as int
    field word as char
.

def var vInput as char initial "input.txt" no-undo.
def var vLine as char no-undo.
def var vEntry as char no-undo.
def var vCorrectCount as int initial 0 no-undo.
def var vLineNr as int initial 0 no-undo.
def var i as int no-undo.

input from value(vInput).

input-blk:
repeat:
    import unformatted vLine.
    
    vLineNr = vLineNr + 1.
    vCorrectCount = vCorrectCount + 1.
    
    repeat i = 1 to num-entries(vLine, ""):    
        
        find first ttWord where 
                   ttWord.word = entry(i, vLine, "") and
                   ttWord.line = vLineNr no-error.
        if not avail ttWord
        then do:
            create ttWord.
            ttWord.word = entry(i, vLine, "").
            ttWord.line = vLineNr.
        end.
        else do:
            vCorrectCount = vCorrectCount - 1.
            next input-blk.
        end.
    end.
end.

input close.

disp vCorrectCount
