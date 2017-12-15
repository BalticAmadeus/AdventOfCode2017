BLOCK-LEVEL ON ERROR UNDO, THROW.

DEFINE TEMP-TABLE ttGroup NO-UNDO
    FIELD groupID AS INTEGER
    FIELD program AS INTEGER
    INDEX idx groupID.
.

INPUT FROM "input.in".

DEFINE VARIABLE cLine AS CHARACTER NO-UNDO.
DEFINE VARIABLE iProgram AS INTEGER NO-UNDO. 
DEFINE VARIABLE cGroupList AS CHARACTER NO-UNDO.
DEFINE VARIABLE iGroupID AS INTEGER NO-UNDO INITIAL 0.
DEFINE VARIABLE iTempID AS INTEGER NO-UNDO.
DEFINE VARIABLE i AS INTEGER NO-UNDO.

DEFINE BUFFER bGroup FOR ttGroup.

REPEAT:
    IMPORT UNFORMATTED cLine.
    iProgram = INTEGER(ENTRY(1, cLine, "<")).
    cGroupList = TRIM(ENTRY(2, cLine, ">")).

    FIND FIRST ttGroup WHERE
               ttGroup.program = iProgram NO-ERROR.
    IF NOT AVAILABLE ttGroup
    THEN DO:
        iGroupID = iGroupID + 1.
        iTempID = iGroupID.
        CREATE ttGroup.
        ttGroup.groupID = iGroupID.
        ttGroup.program = iProgram.
    END.
    ELSE iTempID = ttGroup.groupID.

    DO i = 1 TO NUM-ENTRIES(cGroupList, ","):
        FIND FIRST ttGroup WHERE
                   ttGroup.program = INTEGER(ENTRY(i, cGroupList, ",")) NO-ERROR.
        IF NOT AVAILABLE ttGroup
        THEN DO:
            CREATE ttGroup.
            ttGroup.groupID = iTempID.
            ttGroup.program = INTEGER(ENTRY(i, cGroupList, ",")).
        END.
        ELSE IF ttGroup.groupID <> iTempID //merge groups
        THEN DO:
            FOR EACH bGroup WHERE
                     bGroup.groupID = iTempID:
                bGroup.groupID = ttGroup.groupID.
                iTempID = ttGroup.groupID.
            END.
        END.
    END.
END.

DEFINE VARIABLE iCount AS INTEGER NO-UNDO INITIAL 0.
DEFINE VARIABLE iCountGroups AS INTEGER NO-UNDO INITIAL 0.
FIND bGroup WHERE
     bGroup.program = 0.
FOR EACH ttGroup WHERE
         ttGroup.groupID = bGroup.groupID:
    iCount = iCount + 1.
END.

FOR EACH ttGroup BREAK BY ttGroup.groupID:
    IF FIRST-OF(ttGroup.groupID)
    THEN iCountGroups = iCountGroups + 1.
END.

MESSAGE iCount iCountGroups.


