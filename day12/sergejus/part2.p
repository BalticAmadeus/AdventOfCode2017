
 DEFINE TEMP-TABLE ttNode NO-UNDO 
	  FIELD id AS INTEGER INIT 0
	  FIELD connections AS CHARACTER
	  FIELD visited AS LOGICAL INIT FALSE
  INDEX id IS PRIMARY UNIQUE id.
  
DEFINE VARIABLE cLine AS CHARACTER NO-UNDO.

DEFINE VARIABLE lIsUnique AS LOGICAL NO-UNDO.
DEFINE VARIABLE nCounter AS INTEGER NO-UNDO INIT 0.
DEFINE VARIABLE cAct AS CHARACTER NO-UNDO.

PROPATH = "C:\DEV\advent," + PROPATH.
INPUT FROM VALUE(SEARCH("input.txt")) binary.

DO WHILE TRUE ON ENDKEY UNDO, LEAVE:

  IMPORT UNFORMATTED cLine.
  

  CREATE ttNode.
  ttNode.id = integer(trim(substring(cLine, 1, index(cLine, "<") - 1))).
  ttNode.connections = trim(substring(cLine, index(cLine, ">") + 1)).

END.
INPUT CLOSE.



function visitNode returns logical (nId as int ):
    DEFINE VARIABLE ix AS INTEGER   NO-UNDO.
    DEFINE VARIABLE nNumEntries AS INTEGER NO-UNDO.
    
    define buffer ttNode for ttNode.
    define buffer bttNode for ttNode.
    
    find first ttNode where
               ttNode.id = nId.
    
    ttNode.visited = true.
    nNumEntries = num-entries(ttNode.connections, ",").
    repeat ix = 1 to nNumEntries:
        find first bttNode no-lock where
                   bttNode.id = integer(trim(entry(ix, ttNode.connections, ","))) NO-ERROR.
                   
        if (bttNode.visited) then next.

        visitNode(bttNode.id).
    END.
    
    
END function.

FOR EACH ttNode NO-LOCK:
   if NOT (ttNode.visited) then DO:
   visitNode(ttNode.id).
    nCounter = nCounter + 1.
    END.
END.

message nCounter.
