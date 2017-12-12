
/*------------------------------------------------------------------------
    File        : DayFour_p1.p
    Purpose     : 
    Notes       :
  ----------------------------------------------------------------------*/

block-level on error undo, throw.

def var vInput as char initial "input.txt" no-undo.
def var vLine as char no-undo.
def var vEntry as char no-undo.
def var vCorrectCount as int initial 0 no-undo.
def var vLineNr as int initial 0 no-undo.
def var i as int no-undo.
def var vSortWord as char no-undo.

function sortWord return char (vWord as char) forward.

input from value(vInput).

input-blk:
repeat:
    import unformatted vLine.
end.

def var x as int no-undo initial 0.
def var y as int no-undo initial 0.
def var z as int no-undo initial 0.
def var vMaxx as int no-undo initial 0.
def var vMaxy as int no-undo initial 0.
def var vMaxz as int no-undo initial 0.
def var vMinx as int no-undo initial 0.
def var vMiny as int no-undo initial 0.
def var vMinz as int no-undo initial 0.

repeat i = 1 to num-entries(vLine, ","):
    vEntry = entry(i, vLine, ",").
    
    case vEntry:
        when "n"
        then do:
            x = x + 0.
            y = y + 1.
            z = z + -1.
        end.
        when "s"
        then do:
            x = x + 0.
            y = y + -1.
            z = z + 1.
        end.
        when "ne"
        then do:
            x = x + 1.
            y = y + 0.
            z = z + -1.
        end.
        when "nw"
        then do:
            x = x + -1.
            y = y + 1.
            z = z + 0.
        end.
        when "se"
        then do:
            x = x + 1.
            y = y + -1.
            z = z + 0.
        end.
        when "sw"
        then do:
            x = x + -1.
            y = y + 0.
            z = z + 1.
        end.
    end case.
    
    if x > vMaxx
    then vMaxX = x.
    
    if x < vMinx
    then vMinx = x.
    
    if y > vMaxy
    then vMaxY = y.
    
    if y < vMiny
    then vMiny = y.
    
    if z > vMaxz
    then vMaxz = z.
    
    if z < vMinz
    then vMinz = z.
end.

disp "X" vMaxx vMinx.
disp "Y" vMaxy vMiny.
disp "Z" vMaxz vMinz.
