BLOCK-LEVEL ON ERROR UNDO, THROW.

DEFINE TEMP-TABLE ttTree NO-UNDO
    FIELD node AS CHARACTER
    FIELD parentId AS CHARACTER
    FIELD weight AS INTEGER 
.

INPUT FROM "input.in".

DEFINE VARIABLE cLine AS CHARACTER NO-UNDO.
DEFINE VARIABLE iTempLeftIndex AS INTEGER NO-UNDO.
DEFINE VARIABLE iTempRightIndex AS INTEGER NO-UNDO.
DEFINE VARIABLE cNodeName AS CHARACTER NO-UNDO.
DEFINE VARIABLE iNodeWeight AS INTEGER NO-UNDO.
DEFINE VARIABLE cChildren AS CHARACTER NO-UNDO.
DEFINE VARIABLE i AS INTEGER NO-UNDO.

REPEAT:
    IMPORT UNFORMATTED cLine.

    iTempLeftIndex = INDEX(cLine, "(").
    iTempRightIndex = INDEX(cLine, ")").
    cNodeName = TRIM(SUBSTRING(cLine, 1, iTempLeftIndex - 1)).
    iNodeWeight = INTEGER(SUBSTRING(cLine, iTempLeftIndex + 1, iTempRightIndex - iTempLeftIndex - 1)).
    cChildren = TRIM(SUBSTRING(cLine, iTempRightIndex + 4, LENGTH(cLine) - iTempRightIndex - 3)).

    FIND FIRST ttTree WHERE
               ttTree.node = cNodeName NO-ERROR.
    IF NOT AVAILABLE ttTree
    THEN DO:
        CREATE ttTree.
        ttTree.parentId = "".
        ttTree.node = cNodeName.
    END.
    ttTree.weight = iNodeWeight.

    DO i = 1 TO NUM-ENTRIES(cChildren, ", "):
        FIND FIRST ttTree WHERE
                   ttTree.node = TRIM(ENTRY(i, cChildren, ", ")) NO-ERROR.
        IF NOT AVAILABLE ttTree
        THEN DO:
            CREATE ttTree.
            ttTree.node = TRIM(ENTRY(i, cChildren, ", ")).
        END.
        ttTree.parentId = cNodeName.
    END.
END.

FIND ttTree WHERE
     ttTree.parentId = "".
DISPLAY ttTree.
