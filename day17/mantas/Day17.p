
/*------------------------------------------------------------------------
    File        : Day17.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Sun Dec 17 11:00:46 EET 2017
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

block-level on error undo, throw.

def temp-table ttBuff
    field pos as int 
    field val as int
    field moved as log
    index idx pos
.

def var vInput as int no-undo initial 301.
def var i as int no-undo.
def var vPos as int no-undo.
def var vLenght as int no-undo initial 1.
def var vCharOfSymbols as char initial "0," no-undo.
def var vTempPos as int no-undo.
def var vTempChar2 as char no-undo.

      
create ttBuff.
ttBuff.pos = 0.
ttBuff.val = 0.

repeat i = 1 to 50000000 + 1:
   
    vPos = (vPos + vInput) mod vLenght + 1.
    
    /* PART2 */
    if vPos = 1
    then do:
        disp i.
    end.
    
    /* PART 1
    run insert(vPos, i).
    */
    
    vLenght = vLenght + 1.
end.

disp vPos.

for each ttBuff where pos >= vPos:
    
    disp ttBuff.
    
end.

procedure insert:
    def input param vPos as int no-undo.
    def input param i as int no-undo.
    
    def var vPush as int no-undo initial -1.
    def var push as log no-undo initial false.
    
    def buffer ttBuff1 for ttBuff.
    
    find first ttBuff1 where
               ttBuff1.pos = vPos no-error.
    if not avail ttBuff1
    then do:     
    end.
    else do:
        push = true.
        vPush = ttBuff1.pos.
    end.
    
    if push
    then do:
        for each ttBuff1 where pos >= vPush and
                               moved = false:
            ttBuff1.pos = pos + 1.
            ttBuff1.moved = true.
        end.
    end.
    
    create ttBuff1.
    ttBuff1.pos = vPos.
    ttBuff1.val = i.         
    
    for each ttBuff1:
        ttBuff1.moved = false.
    end.
    
end procedure.