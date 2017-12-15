BLOCK-LEVEL ON ERROR UNDO, THROW.

DEFINE VARIABLE cLine     AS CHARACTER NO-UNDO.
DEFINE VARIABLE i         AS INTEGER   NO-UNDO.
DEFINE VARIABLE iCurX     AS INTEGER   NO-UNDO.
DEFINE VARIABLE iCurY     AS INTEGER   NO-UNDO.
DEFINE VARIABLE iCurZ     AS INTEGER   NO-UNDO.
DEFINE VARIABLE cDir      AS CHARACTER NO-UNDO.
DEFINE VARIABLE iDist     AS INTEGER   NO-UNDO.

INPUT FROM VALUE("D:\dev\pdsoeProjects\CodeOfAdvent\res\inp.txt").
REPEAT:
    IMPORT UNFORMATTED cLine.
END.
INPUT CLOSE.

DO i = 1 TO NUM-ENTRIES(cLine):
    cDir = ENTRY(i, cLine).
    
    CASE cDir:
        WHEN "n" THEN DO:
            iCurY = iCurY - 1.
            iCurZ = iCurZ + 1.
        END.
        WHEN "ne" THEN DO:
            iCurX = iCurX + 1.
            iCurY = iCurY - 1.
        END.
        WHEN "se" THEN DO:
            iCurX = iCurX + 1.
            iCurZ = iCurZ - 1.
        END.
        WHEN "s" THEN DO:
            iCurY = iCurY + 1.
            iCurZ = iCurZ - 1.
        END.
        WHEN "sw" THEN DO:
            iCurX = iCurX - 1.
            iCurY = iCurY + 1.
        END.
        WHEN "nw" THEN DO:
            iCurX = iCurX - 1.
            iCurZ = iCurZ + 1.
        END.
    END CASE.
END.

iDist = (ABSOLUTE(iCurX) + ABSOLUTE(iCurY) + ABSOLUTE(iCurZ)) / 2.

MESSAGE iDist VIEW-AS ALERT-BOX.



