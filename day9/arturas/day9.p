BLOCK-LEVEL ON ERROR UNDO, THROW.

DEFINE VARIABLE cLine    AS CHARACTER NO-UNDO.
DEFINE VARIABLE iLevel   AS INTEGER   NO-UNDO.
DEFINE VARIABLE iScore   AS INTEGER   NO-UNDO.
DEFINE VARIABLE i        AS INTEGER   NO-UNDO.
DEFINE VARIABLE cChar    AS CHARACTER NO-UNDO.
DEFINE VARIABLE lGarbage AS LOGICAL   NO-UNDO.
DEFINE VARIABLE lSkip    AS LOGICAL   NO-UNDO.

INPUT FROM VALUE("D:\dev\pdsoeProjects\CodeOfAdvent\res\inp.txt").
REPEAT:
    IMPORT UNFORMATTED cLine.
END.
INPUT CLOSE.

DO i = 1 TO LENGTH(cLine):
    cChar = SUBSTRING(cLine, i, 1).
    
    IF lSkip THEN DO:
        lSkip = FALSE.
        NEXT.
    END.
    
    CASE cChar:
        WHEN "~{" THEN DO:
            IF NOT lGarbage THEN
                iLevel = iLevel + 1.
        END.
        WHEN "}" THEN DO:
            IF NOT lGarbage THEN DO:
                iScore = iScore + iLevel.
                iLevel = iLevel - 1.
            END.
        END.
        WHEN "!" THEN DO:
            lSkip = TRUE.
        END.
        WHEN "<" THEN DO:
            lGarbage = TRUE.
        END.
        WHEN ">" THEN DO:
            lGarbage = FALSE.
        END.
    END CASE.
END.

MESSAGE iScore VIEW-AS ALERT-BOX.
