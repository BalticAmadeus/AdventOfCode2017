DEFINE VARIABLE cLine AS CHARACTER NO-UNDO.
DEFINE VARIABLE ix      AS INTEGER   NO-UNDO.
DEFINE VARIABLE lIsUnique AS LOGICAL NO-UNDO.
DEFINE VARIABLE nCounter AS INTEGER NO-UNDO INIT 0.

INPUT FROM VALUE(SEARCH("input.txt")) binary.
DO WHILE TRUE ON ENDKEY UNDO, LEAVE:
  IMPORT UNFORMATTED cLine.
  
  lIsUnique = TRUE.
  
  REPEAT ix = 1 TO NUM-ENTRIES(cLine, " "):
     IF INDEX(cLine, ENTRY(ix, cLine, " ")) <> R-INDEX(cLine, ENTRY(ix, cLine, " "))
     THEN DO:
         		lIsUnique = FALSE.
     		END.
		  END.
		  
		  IF lIsUnique THEN nCounter = nCounter + 1.
END.
INPUT CLOSE.

MESSAGE nCounter.