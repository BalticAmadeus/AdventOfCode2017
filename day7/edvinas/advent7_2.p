BLOCK-LEVEL ON ERROR UNDO, THROW.

DEFINE TEMP-TABLE ttTree NO-UNDO
    FIELD node AS CHARACTER
    FIELD parentId AS CHARACTER
    FIELD weight AS INTEGER 
    FIELD totalWeight AS INTEGER
    FIELD stdWeight AS INTEGER
    FIELD depth AS INTEGER
    INDEX idx depth ASCENDING.
.

INPUT FROM "input.in".

DEFINE VARIABLE cLine AS CHARACTER NO-UNDO.
DEFINE VARIABLE iTempLeftIndex AS INTEGER NO-UNDO.
DEFINE VARIABLE iTempRightIndex AS INTEGER NO-UNDO.
DEFINE VARIABLE cNodeName AS CHARACTER NO-UNDO.
DEFINE VARIABLE iNodeWeight AS INTEGER NO-UNDO.
DEFINE VARIABLE cChildren AS CHARACTER NO-UNDO.
DEFINE VARIABLE i AS INTEGER NO-UNDO.

FUNCTION calculateSubtree RETURNS INTEGER (cNodeId AS CHARACTER, iDepth AS INTEGER):
    DEFINE VARIABLE iTotalWeight AS INTEGER NO-UNDO INITIAL 0.
    DEFINE VARIABLE iNumChildren AS INTEGER NO-UNDO INITIAL 0.
    DEFINE VARIABLE iStandardWeight AS INTEGER NO-UNDO INITIAL ?.
    DEFINE BUFFER ttTree FOR ttTree.
    DEFINE BUFFER bTree FOR ttTree.

    FIND bTree WHERE 
         bTree.node = cNodeId.

    FOR EACH ttTree WHERE
             ttTree.parentId = cNodeId:
        iTotalWeight = iTotalWeight + calculateSubtree(ttTree.node, iDepth + 1).

        IF iStandardWeight = ?
        THEN iStandardWeight = iTotalWeight.
        ttTree.stdWeight = iStandardWeight.

        iNumChildren = iNumChildren + 1.
    END.

    bTree.totalWeight = bTree.weight + iTotalWeight.
    bTree.depth = iDepth.
    RETURN bTree.totalWeight.
END FUNCTION.

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
calculateSubtree(ttTree.node, 1).

DEFINE BUFFER bTree FOR ttTree.

FIND LAST ttTree WHERE
          ttTree.stdWeight <> ttTree.totalWeight USE-INDEX idx.
FOR EACH bTree WHERE
         bTree.parentId = ttTree.parentId:
    DISPLAY bTree. //This is not the final answer, but the code to find it would be ugly and it's obvious from here
END.

