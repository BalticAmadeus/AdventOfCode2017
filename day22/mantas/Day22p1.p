
/*------------------------------------------------------------------------
    File        : Day22p1.p
    Purpose     : 
    Notes       :
  ----------------------------------------------------------------------*/

block-level on error undo, throw.

def temp-table ttMap
    field x as int
    field y as int
    field c as char /* infected, not infected */
    index idx x y
.

def var vInput as char no-undo initial "input.txt".
def var vTest as log no-undo initial false.

def var vOutputTest as char no-undo.
def var vLine as char no-undo.
def var i as int no-undo.
def var x as int no-undo.
def var y as int no-undo.

def var vPositionX as int no-undo.
def var vPositionY as int no-undo.
def var vWASD as char no-undo.

if vTest
then vInput = "inputTest".

input from value(vInput).

y = 0.

repeat:
    import unformatted vLine.
    
    y = y + 1.
    
    repeat i = 1 to length(vLine):
        x = i.
        
        create ttMap.
        ttMap.x = x.
        ttMap.y = y.
        ttMap.c = substring(vLine, i, 1).
        
    end.
end.
    
input close.



output to "testInput.txt".

repeat i = 1 to 3:
    
    vOutputTest = "".
    
    for each ttMap where ttMap.y = i:
        vOutputTest = vOutputTest + ttMap.c.
    end.
    
    export vOutputTest.
end.

output close.

/* Midle if odd */
vPositionX = x / 2.
vPositionY = y / 2.
vWASD = "W".

def var vInfectCount as int no-undo initial 0.
def var vCureCount as int no-undo initial 0.
def var vNextWASD as char no-undo.
def var vNextPositionX as int no-undo initial 0.
def var vNextPositionY as int no-undo initial 0.

output to debug.log.

repeat i = 1 to 10000:
    
    find ttMap where
         ttMap.x = vPositionX and
         ttMap.y = vPositionY no-error.
    if not avail ttMap
    then do:
        create ttMap.
        ttMap.x = vPositionX.
        ttMap.y = vPositionY.
        ttMap.c = ".".
    end.
    
    message "before" vPositionX vPositionY vWASD ttMap.c.
    
    /*turn*/
    run turn(ttMap.c, vWASD, output vNextWASD).
    vWASD = vNextWASD.
    
    /*infect*/
    if ttMap.c = "."
    then do:
        ttMap.c = "#".
        vInfectCount = vInfectCount + 1.  
    end.
    else do:
        ttMap.c = ".".
        vCureCount = vCureCount + 1.
    end.
   
    /*move*/
    run move(vPositionX, vPositionY, vWASD, output vNextPositionX, output vNextPositionY).
    vPositionX = vNextPositionX.
    vPositionY = vNextPositionY.
    
    message "after" vPositionX vPositionY vWASD ttMap.c.  
end.

output close.

disp vInfectCount vCureCount vInfectCount - vCureCount.

procedure turn:
    def input param pC as char no-undo.
    def input param pWASD as char no-undo.
    def output param pTurn as char no-undo.
    
    case pC:
        when "." /* left */
        then do:
            if pWASD = "W"
            then do:
                pTurn = "A".
                return.
            end.
            else if pWASD = "A"
            then do:
                pTurn = "S".
                return.
            end.
            else if pWASD = "S"
            then do:
                pTurn = "D".
                return.
            end.
            else if pWASD = "D"
            then do:
                pTurn = "W".
                return.
            end.              
        end.
        when "#" /* right */
        then do:
            if pWASD = "W"
            then do:
                pTurn = "D".
                return.
            end.
            else if pWASD = "D"
            then do:
                pTurn = "S".
                return.
            end.
            else if pWASD = "S"
            then do:
                pTurn = "A".
                return.
            end.
            else if pWASD = "A"
            then do:
                pTurn = "W".
                return.
            end.            
        end.
    end case. 
end procedure. /* turn */

procedure move:
    def input param px as int no-undo.
    def input param py as int no-undo.
    def input param pC as char no-undo.
    def output param pnx as int no-undo.
    def output param pny as int no-undo.
    
    if pC = "W"
    then do:
        pny = py - 1.
        pnx = px.
    end.
    else if pC = "A"
    then do:
        pnx = px - 1.
        pny = py.
    end.
    else if pC = "S"
    then do:
        pny = py + 1.
        pnx = px.
    end.
    else if pC = "D"
    then do:
        pnx = px + 1.
        pny = py.
    end.         
end procedure.





