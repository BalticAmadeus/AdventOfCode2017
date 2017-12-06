
/*------------------------------------------------------------------------
    File        : DaySix_p1.p
    Purpose     : 
    Notes       :
  ----------------------------------------------------------------------*/

block-level on error undo, throw.

def temp-table ttSituation
    field situationNr as int
    field situation as char
.

def temp-table ttBlock
    field nr as int
    field size as int
.

def var vInput as char no-undo initial "4 10 4 1 8 4 9 14 5 1 14 15 0 15 3 5".
def var vRestCount as int no-undo initial 0.
def var i as int no-undo.
def var vMaxNr as int no-undo.
def var vMax as int no-undo.
def var vSituation as char no-undo.
def var vEndOfCycle as log no-undo initial true.
def var vElemtCount as int no-undo.
def var vRestVal as int no-undo.
def var vRestPos as int no-undo.

vInput = "4 10 4 1 8 4 9 14 5 1 14 15 0 15 3 5".

function getMaxNr return int (table ttBlock) forward.
function getMaxVal return int (table ttBlock, vNr as int) forward.

vElemtCount = num-entries(vInput, "").

/*Read*/
repeat i = 1 to vElemtCount:
    create ttBlock.
    ttBlock.nr = i.
    ttBlock.size = integer(entry(i, vInput, "")).
end.

for each ttBlock:
    disp ttBlock.nr ttBlock.size.
end.

restblk:
repeat:
    if vEndOfCycle
    then do:
       vMaxNr = getMaxNr(table ttBlock).
       vMax = getMaxVal(table ttBlock, vMaxNr).
       vSituation = "".
       
       for each ttBlock:
           vSituation = subst("&1,&2", vSituation, ttBlock.size).
       end.
       
       find first ttSituation where
                  ttSituation.situation = vSituation no-error.
       if avail ttSituation
       then do:
           disp vRestCount vRestCount - ttSituation.situationNr + 1.
           leave restblk.
       end.
       else do:
           vRestCount = vRestCount + 1.
           create ttSituation.
           ttSituation.situationNr = vRestCount.
           ttSituation.situation = vSituation.
       end.
       
       vRestVal = vMax.
       vRestPos = vMaxNr.
       
       vEndOfCycle = false.
    end.
    
    if vRestVal = 0
    then vEndOfCycle = true.
    else do:
        
        if vElemtCount = vRestPos
        then vRestPos = 1.
        else vRestPos = vRestPos + 1.
        
        find first ttBlock where
                   ttBlock.nr = vRestPos no-error.
        if avail ttBlock
        then do:
            ttBlock.size = ttBlock.size + 1.
            vRestPos + 1.
        end.
        
        find first ttBlock where
                   ttBlock.nr = vMaxNr no-error.
        if avail ttBlock
        then do:
            vRestVal = vRestVal - 1.
            ttBlock.size = ttBlock.size - 1.
        end.
        
        
    end.
end.
    
function getMaxNr return int (table ttBlock):
    def var vNr as int no-undo.
    def var vMax as int no-undo initial 0.
    
    for each ttBlock:
        
        if vMax < ttBlock.size
        then do:
            vMax = ttBlock.size.
            vNr = ttBlock.nr.
        end.
        
    end.
    
    return vNr.
end function.


function getMaxVal return int (table ttBlock, vNr as int):
    
    find first ttBlock no-lock where
               ttBlock.nr = vNr no-error.
    if avail ttBlock
    then return ttBlock.size.
    
end function.