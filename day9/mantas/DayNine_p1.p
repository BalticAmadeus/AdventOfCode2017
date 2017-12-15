
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
end.

input close.

def var vChar as char no-undo.
def var vIgnore as log no-undo.
def var vGarbage as log no-undo.
def var vCount as int no-undo initial 0.
def var vLevel as int no-undo initial 0.
def var vGarbageTruck as int no-undo.

repblk:
repeat i = 1 to length(vLine):
    vChar = substring(vLine, i, 1).
    
    if vIgnore
    then do:
        vIgnore = false.
        next repblk.
    end.
    
    case vChar:
        when "<"
        then do:
            if vGarbage
            then vGarbageTruck = vGarbageTruck + 1.
         
            vGarbage = true.
                        
        end.
        when ">"
        then do:
            /*Garbage truck. Oh no*/
            vGarbage = false.
        end.
        when "!"
        then do:
            vIgnore = true.
        end.
        when "~{"
        then do:
            if vGarbage
            then vGarbageTruck = vGarbageTruck + 1.
            else vLevel = vLevel + 1.
        end.
        when "~}"
        then do:
            if vGarbage
            then vGarbageTruck = vGarbageTruck + 1.
            else do:
                vCount = vCount + vLevel.
                vLevel = vLevel - 1.
            end.
        end.
        otherwise do:
            if vGarbage
            then vGarbageTruck = vGarbageTruck + 1.
        end.
    
    end case.
end.

disp vGarbageTruck.
