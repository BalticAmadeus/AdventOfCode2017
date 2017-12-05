
/*------------------------------------------------------------------------
    File        : DayFive_p1.p
    Purpose     : 
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

block-level on error undo, throw.

def temp-table ttJump
    field place as int
    field jumpValue as int
    index idx place
.

def var vInput as char initial "input.txt" no-undo.
def var i as int initial 1 no-undo.
def var vSteps as int initial 0 no-undo.
def var vPlace as int initial 1 no-undo.
def var vLine as char no-undo.

function sortWord return char (vWord as char) forward.

message "START".

input from value(vInput).
repeat:
    import unformatted vLine.
    
    create ttJump.
    ttJump.place = i.
    ttJump.jumpValue = integer(vLine).
    
    i = i + 1.
    
end.

input close.

etime(true).

repblk:
repeat:
    
    find first ttJump where 
               ttJump.place = vPlace use-index idx no-error.
    if avail ttJump
    then do:
        vSteps = vSteps + 1.
        vPlace = vPlace + ttJump.jumpValue.
        
        if ttJump.jumpValue >= 3
        then ttJump.jumpValue = ttJump.jumpValue - 1.
        else ttJump.jumpValue = ttJump.jumpValue + 1.
    end.
    else do:
        disp vSteps.
        leave repblk.
    end.
end.

message "END" etime.