
/*------------------------------------------------------------------------
    File        : Day7.p
    Purpose     : 
    Notes       :
  ----------------------------------------------------------------------*/


block-level on error undo, throw.

def temp-table ttParent
    field prog as char
    field size as char
.

def temp-table ttRelation
    field parent as char
    field child as char
.

def var vTest as log no-undo initial false.
def var vLine as char no-undo.
def var i as int no-undo.
def var vTemp as char no-undo.

if vTest
then input from value("inputTest").
else input from value("input.txt").

repeat:
    import unformatted vLine.
    
    create ttParent.
    ttParent.prog = entry(1, vLine, " "). 
    ttParent.size = entry(2, vLine, " ").
    
    vTemp = entry(3, vLine, " ") no-error.
    
    if vTemp = "->"
    then do:
        repeat i = 4 to num-entries(vLine, " "):
            create ttRelation.
            ttRelation.parent =  ttParent.prog.
            ttRelation.child = trim(entry(i, vLine, " "), ",").
        end.
    end.
end.

input close.

for each ttParent:
    
    find ttRelation no-lock where
         ttRelation.child = ttParent.prog no-error.
    if avail ttRelation
    then do:
        delete ttParent.
    end.
    
end.

for each ttParent:
    disp ttParent.
end.

for each ttParent:
    
    find ttRelation where
         ttRelation.parent = ttParent.prog no-error.
    if avail ttRelation
    then do:
        disp ttParent.
    end.
    
end.