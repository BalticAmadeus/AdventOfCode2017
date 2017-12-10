
/*------------------------------------------------------------------------
    File        : DayThree_p1.p
    Purpose     : 
    Notes       :
  ----------------------------------------------------------------------*/

block-level on error undo, throw.

def temp-table ttLine
    field valIndex as int
    field val as int
    field moved as log
.

def var vInput as char no-undo initial "199,0,255,136,174,254,227,16,51,85,1,2,22,17,7,192".
def var vLine as char no-undo.
def var i as int no-undo.
def var vMax as int initial 256 no-undo.

repeat i = 1 to vMax:
    
    create ttLine.
    ttLine.valIndex = i.
    ttLine.val = i - 1.
    ttLine.moved = false.
    
end.

def buffer ttLineNext for ttLine.
def buffer ttDebug for ttLine.

def var vOper as int no-undo.
def var vPlace as int no-undo initial 1.
def var vSkip as int no-undo initial 0.
def var j as int no-undo.
def var vMidle as int no-undo.
def var vLyg as log no-undo.
def var vTemp as int no-undo.
def var vChangePlace as int no-undo.
def var vLoopPlace as int no-undo.

nextOper:
repeat i = 1 to num-entries(vInput, ","):
    
    if i <> 1
    then do:
        vPlace = vOper + vSkip + vPlace.
        vSkip = vSkip + 1.
    end.
    
    vOper = integer(entry(i, vInput, ",")).
    
    if vOper = 1
    then next nextOper.
    
    if vOper modulo 2 = 0
    then do:
        vLyg = true.
        vMidle = vOper / 2 + vPlace.
        /*Lyginis*/
    end.
    else do:
        vLyg = false.
        vMidle = (vOper - 1) / 2 + vPlace.
        /*Nelyginis*/
    end.
    
    for each ttLine by valIndex:
        ttLine.moved = false.
    end.
        
    /*for each ttDebug by valIndex:
        disp ttDebug.valIndex ttDebug.val ttDebug.moved.
    end.*/
    
    /*disp vPlace vMidle.*/
    
    doblk:
    repeat j = vPlace to vMidle:
        
        if j > vMax
        then vLoopPlace = j modulo vMax.
        else vLoopPlace = j.
        
        if vLoopPlace = 0
        then vLoopPlace = vMax.

        find first ttLine where 
                   ttLine.valIndex = vLoopPlace and
                   ttLine.moved = false.
        if avail ttLine
        then do:
            if not vLyg
            then do:
                
                if vMidle = j
                then leave doblk.
                
                vTemp = ttLine.valIndex.
                vChangePlace = j + vOper - 1 - (j - vPlace) * 2.
                
                if vChangePlace > vMax
                then vChangePlace = vChangePlace modulo vMax.
                
                if vChangePlace = 0
                then vChangePlace = vMax.
                
                ttLine.valIndex = vChangePlace.
                ttLine.moved = true.
                
                find first ttLineNext where 
                           ttLineNext.valIndex = vChangePlace and
                           ttLineNext.moved = false.
                if avail ttLineNext
                then do:
                    
                    ttLineNext.valIndex = vTemp.
                    ttLineNext.moved = true.
                end.
            end.
            else do:
                vTemp = ttLine.valIndex.
                vChangePlace = j + vOper - 1 - (j - vPlace) * 2.
                
                if vChangePlace > vMax
                then vChangePlace = vChangePlace modulo vMax.
                
                if vChangePlace = 0
                then vChangePlace = vMax.
                
                ttLine.valIndex = vChangePlace.
                ttLine.moved = true.
                
                find first ttLineNext where 
                           ttLineNext.valIndex = vChangePlace and
                           ttLineNext.moved = false.
                if avail ttLineNext
                then do:
                    ttLineNext.valIndex = vTemp.
                    ttLineNext.moved = true.
                end.
                
                if j + 1 = vMidle
                then leave doblk.
            end. 
        end.
    end.  
end.

def var v1 as int no-undo.
def var v2 as int no-undo.

find first ttLine where
           ttLine.valIndex = 1.
v1 = ttLine.val.

find first ttLine where
           ttLine.valIndex = 2.
v2 = ttLine.val.

disp v1 * v2.


