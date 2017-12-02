
/*------------------------------------------------------------------------
    File        : DayOne_p1.p
    Purpose     : 
    Notes       :
  ----------------------------------------------------------------------*/
block-level on error undo, throw.

def var i as int no-undo.
def var vLine as char no-undo.
def var vNum as int no-undo.
def var vMax as int no-undo.
def var vMin as int no-undo.
def var vSum as int no-undo.

input from value("input.txt").

repeat:
    import unformatted vLine.
    
    vMax = ?.
    vMin = ?.
    
    repeat i = 1 to num-entries(vLine, "~011"):
        vNum = integer(entry(i, vLine, "~011")).
        
        if vNum > vMax or vMax = ?
        then vMax = vNum.
        
        if vNum < vMin or vMin = ?
        then vMin = vNum.
    end.
    
    disp vSum vMax vMin.
    vSum = vSum + vMax - vMin.
end.

input close.

disp vSum.
