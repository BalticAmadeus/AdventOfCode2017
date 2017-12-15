BLOCK-LEVEL ON ERROR UNDO, THROW.

INPUT FROM "input.in".

DEFINE VARIABLE cLine AS  CHARACTER NO-UNDO.
IMPORT UNFORMATTED cLine.
DEFINE VARIABLE i AS INTEGER NO-UNDO.

DEFINE VARIABLE iCurrentX AS INTEGER NO-UNDO.
DEFINE VARIABLE iCurrentY AS INTEGER NO-UNDO.
DEFINE VARIABLE iCurrentZ AS INTEGER NO-UNDO.
DEFINE VARIABLE iMaxCoord AS INTEGER NO-UNDO INITIAL 0.

DO i = 1 TO NUM-ENTRIES(cLine, ","):
    CASE TRIM(ENTRY(i, cLine)):
        WHEN "N"
            THEN DO:
                iCurrentX = iCurrentX + 0.
                iCurrentY = iCurrentY + 1.
                iCurrentZ = iCurrentZ - 1.
            END.
        WHEN "NE"
            THEN DO:
                iCurrentX = iCurrentX + 1.
                iCurrentY = iCurrentY + 0.
                iCurrentZ = iCurrentZ - 1.
            END.
        WHEN "NW"
            THEN DO:
                iCurrentX = iCurrentX - 1.
                iCurrentY = iCurrentY + 1.
                iCurrentZ = iCurrentZ - 0.
            END.
        WHEN "S"
            THEN DO:
                iCurrentX = iCurrentX + 0.
                iCurrentY = iCurrentY - 1.
                iCurrentZ = iCurrentZ + 1.
            END.
        WHEN "SE"
            THEN DO:
                iCurrentX = iCurrentX + 1.
                iCurrentY = iCurrentY - 1.
                iCurrentZ = iCurrentZ - 0.
            END.
        WHEN "SW"
            THEN DO:
                iCurrentX = iCurrentX - 1.
                iCurrentY = iCurrentY + 0.
                iCurrentZ = iCurrentZ + 1.
            END.
        OTHERWISE MESSAGE "Unknown insctruction:" TRIM(ENTRY(i, cLine)).
    END CASE.
    iMaxCoord = MAXIMUM(ABSOLUTE(iCurrentX), ABSOLUTE(iCurrentY), ABSOLUTE(iCurrentZ), ABSOLUTE(iMaxCoord)).
END.

DISPLAY iCurrentX iCurrentY iCurrentZ iMaxCoord.
