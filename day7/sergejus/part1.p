DEFINE TEMP-TABLE ttDisc NO-UNDO 
	  FIELD NAME AS CHARACTER
  INDEX NAME IS PRIMARY UNIQUE NAME.
  
DEFINE TEMP-TABLE ttChild NO-UNDO 
	  FIELD NAME AS CHARACTER
  INDEX NAME IS PRIMARY UNIQUE NAME.

DEFINE VARIABLE cLine AS CHARACTER NO-UNDO.
DEFINE VARIABLE ix      AS INTEGER   NO-UNDO.
DEFINE VARIABLE ij      AS INTEGER   NO-UNDO.
DEFINE VARIABLE lIsUnique AS LOGICAL NO-UNDO.
DEFINE VARIABLE nCounter AS INTEGER NO-UNDO INIT 0.
DEFINE VARIABLE cChildren AS CHARACTER NO-UNDO.

PROPATH = "C:\secretfolder" + PROPATH.
INPUT FROM VALUE(SEARCH("input.txt")) binary.

DO WHILE TRUE ON ENDKEY UNDO, LEAVE:
  IMPORT UNFORMATTED cLine.
  cChildren = "".
  
  CREATE ttDisc.
  ttDisc.name = TRIM(SUBSTRING(cLine, 1, index(cLine, '(') - 1)).
  IF index(cLine, '>') > 0
  THEN DO: 
      cChildren = SUBSTRING(cLine, index(cLine, '>') + 1).
      
      IF index(cChildren, ',') > 0 THEN DO:
      REPEAT ix = 1 TO NUM-ENTRIES(cChildren, ","):
        CREATE ttChild.
        ttChild.name = TRIM(ENTRY(ix, cChildren, ",")).
      END.
      END.
      ELSE DO:
          CREATE ttChild.
          ttChild.name = TRIM(cChildren).
      END.
  END.
END.
INPUT CLOSE.


FOR EACH ttDisc NO-LOCK:
    FIND FIRST ttChild NO-LOCK WHERE ttDisc.name = ttChild.name NO-ERROR.
    IF NOT AVAILABLE ttChild THEN DO:
        MESSAGE ttDisc.name.
    END.
END.