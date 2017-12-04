
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

def temp-table ttOneWord
    field vchar as char
.

def var vInput as char initial "input.txt" no-undo.
def var vLine as char no-undo.
def var vEntry as char no-undo.
def var vCorrectCount as int initial 0 no-undo.
def var vLineNr as int initial 0 no-undo.
def var i as int no-undo.
def var vSortWord as char no-undo.

function sortWord return char (vWord as char) forward.

input from value(vInput).

message "START".

input-blk:
repeat:
    import unformatted vLine.
    
    vLineNr = vLineNr + 1.
    vCorrectCount = vCorrectCount + 1.
    
    repeat i = 1 to num-entries(vLine, ""):
        
        vSortWord = sortWord(entry(i, vLine, "")).
        
        find first ttWord where 
                   ttWord.word = vSortWord and
                   ttWord.line = vLineNr no-error.
        if not avail ttWord
        then do:
            create ttWord.
            ttWord.word = vSortWord.
            ttWord.line = vLineNr.
        end.
        else do:
            vCorrectCount = vCorrectCount - 1.
            next input-blk.
        end.
    end.
end.

message "END".

input close.

disp vCorrectCount.

function sortWord return char (vWord as char):
    def var vSortedWord as char no-undo.
    def var i as int no-undo.
    
    empty temp-table ttOneWord.
    
    repeat i = 1 to length(vWord):
        create ttOneWord.
        ttOneWord.vchar = substring(vWord, i, 1).
    end.
    
    for each ttOneWord by vchar desc:
        vSortedWord = vSortedWord + ttOneWord.vchar.
    end. 
    
    return vSortedWord.
end.
