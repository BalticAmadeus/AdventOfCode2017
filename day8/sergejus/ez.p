 DEFINE TEMP-TABLE ttRegister NO-UNDO 
	  FIELD NAME AS CHARACTER
	  FIELD val AS INTEGER INIT 0
  INDEX NAME IS PRIMARY UNIQUE NAME.
  
DEFINE VARIABLE cLine AS CHARACTER NO-UNDO.
DEFINE VARIABLE ix      AS INTEGER   NO-UNDO.
DEFINE VARIABLE ij      AS INTEGER   NO-UNDO.
DEFINE VARIABLE lIsUnique AS LOGICAL NO-UNDO.
DEFINE VARIABLE nCounter AS INTEGER NO-UNDO INIT 0.
DEFINE VARIABLE cAct AS CHARACTER NO-UNDO.
DEFINE VARIABLE nAmt AS INTEGER NO-UNDO.
DEFINE VARIABLE nMax AS INTEGER NO-UNDO INIT -999999.
DEFINE VARIABLE nMax2 AS INTEGER NO-UNDO INIT -999999.

DEFINE VARIABLE cCond AS CHARACTER NO-UNDO.
  DEFINE VARIABLE cCond1 AS CHARACTER NO-UNDO.
  DEFINE VARIABLE nCond2 AS INTEGER NO-UNDO.
  DEFINE VARIABLE cCondResult AS LOGICAL NO-UNDO.
  DEFINE VARIABLE nVal AS INTEGER NO-UNDO.

PROPATH = "C:\secret" + PROPATH.
INPUT FROM VALUE(SEARCH("input.txt")) binary.

DO WHILE TRUE ON ENDKEY UNDO, LEAVE:

  IMPORT UNFORMATTED cLine.
  
  FIND FIRST ttRegister NO-LOCK WHERE ttRegister.name = ENTRY(1, cLine, " ") NO-ERROR.
  IF NOT AVAILABLE ttRegister THEN DO:
      CREATE ttRegister.
  	    ttRegister.name = ENTRY(1, cLine, " "). 
  	END.
  
  // check condition
  cCond = ENTRY(5, cLine, " ").
  cCond1 = ENTRY(6, cLine, " ").
  nCond2 = integer(ENTRY(7, cLine, " ")).
  
  FIND FIRST ttRegister NO-LOCK WHERE ttRegister.name = cCond NO-ERROR.
  IF AVAILABLE ttRegister THEN DO:
      nVal = ttRegister.val.
  	END.
  	ELSE nVal = 0.
  	
  cCondResult = FALSE.	
  	CASE cCond1:
  	    WHEN ">" THEN DO:
  	        IF nVal > nCond2
  	        THEN cCondResult = TRUE.
  	    END.
  	    WHEN "<" THEN DO:
  	        IF nVal < nCond2
  	        THEN cCondResult = TRUE.
  	    END.
  	    WHEN "==" THEN DO:
  	        IF nVal = nCond2
  	        THEN cCondResult = TRUE.
  	    END.
  	    WHEN ">=" THEN DO:
  	        IF nVal >= nCond2
  	        THEN cCondResult = TRUE.
  	    END.
  	    WHEN "<=" THEN DO:
  	        IF nVal <= nCond2
  	        THEN cCondResult = TRUE.
  	    END.
  	    WHEN "!=" THEN DO:
  	        IF nVal <> nCond2
  	        THEN cCondResult = TRUE.
  	    END.
  	    END CASE.
  	    
  	    cAct = ENTRY(2, cLine, " ").
  	    nAmt = integer(ENTRY(3, cLine, " ")).

      FIND FIRST ttRegister NO-LOCK WHERE ttRegister.name = ENTRY(1, cLine, " ") NO-ERROR.
  	    IF cCondResult THEN DO:
	       
  	        IF cAct = "dec" THEN DO:
		              ttRegister.val = ttRegister.val - nAmt.
  	        END.
  	        IF cAct = "inc" THEN DO:
		              ttRegister.val = ttRegister.val + nAmt.
  	        END.
  	    END.
	      
	      IF nMax2 < ttRegister.val
    THEN nMax2 = ttRegister.val.
END.
INPUT CLOSE.

FOR EACH ttRegister NO-LOCK BY ttRegister.val DESCENDING :
    IF nMax < ttRegister.val
    THEN nMax = ttRegister.val.
END.

MESSAGE nMax. //part1
MESSAGE nMax2. //part2