BLOCK-LEVEL ON ERROR UNDO, THROW.

DEFINE VARIABLE cLine     AS CHARACTER NO-UNDO.
DEFINE VARIABLE i         AS INTEGER   NO-UNDO.
DEFINE VARIABLE d         AS INTEGER   NO-UNDO.
DEFINE VARIABLE iSkipSize AS INTEGER   NO-UNDO.
DEFINE VARIABLE iLength   AS INTEGER   NO-UNDO.
DEFINE VARIABLE iPosition AS INTEGER   NO-UNDO INITIAL 1.
DEFINE VARIABLE iHash     AS INTEGER   EXTENT 256 NO-UNDO.
DEFINE VARIABLE iSubHash  AS INTEGER   EXTENT 256 NO-UNDO.

FUNCTION getSubHash RETURNS LOGICAL(ipPosition AS INTEGER, ipLength AS INTEGER) FORWARD.
FUNCTION switchEntries RETURNS LOGICAL(ipPosition AS INTEGER, ipLength AS INTEGER) FORWARD.

INPUT FROM VALUE("D:\dev\pdsoeProjects\CodeOfAdvent\res\inp.txt").
REPEAT:
    IMPORT UNFORMATTED cLine.
END.
INPUT CLOSE.

DO i = 0 TO 255:
    iHash[i + 1] = i. 
END.

DO i = 1 TO NUM-ENTRIES(cLine):
    iLength = INTEGER(ENTRY(i, cLine)).
    
/*    DO d = 1 TO 256:       */
/*        DISPLAY iHash[d] d.*/
/*        PAUSE.             */
/*    END.                   */
    
    getSubHash(iPosition, iLength).
    switchEntries(iPosition, iLength).
    
    iPosition = iPosition + iLength + iSkipSize.
    IF iPosition > 256 THEN
        iPosition = iPosition - 256.
    iSkipSize = iSkipSize + 1.
END.

MESSAGE iHash[1] iHash[2] iHash[1] * iHash[2] VIEW-AS ALERT-BOX.

FUNCTION getSubHash RETURNS LOGICAL(ipPosition AS INTEGER, ipLength AS INTEGER):
    DEFINE VARIABLE j    AS INTEGER NO-UNDO.
    DEFINE VARIABLE iVal AS INTEGER NO-UNDO.
    
    IF ipLength = 0 THEN
        RETURN TRUE.
    
    DO j = 1 TO ipLength:
        iVal = ipPosition + j - 1.
        IF iVal > 256 THEN
            iVal = iVal - 256.
        iSubHash[j] = iHash[iVal].
    END.
END FUNCTION.

FUNCTION switchEntries RETURNS LOGICAL(ipPosition AS INTEGER, ipLength AS INTEGER):
    DEFINE VARIABLE j       AS INTEGER NO-UNDO.
    DEFINE VARIABLE iCurPos AS INTEGER NO-UNDO.
    
    iCurPos = ipPosition + ipLength - 1.
    IF iCurPos > 256 THEN
        iCurPos = iCurPos - 256.
    
    IF ipLength = 0 THEN
        RETURN TRUE.
    
    DO j = 1 TO ipLength:
        iHash[iCurPos] = iSubHash[j].
        
        iCurPos = iCurPos - 1.
        IF iCurPos < 1 THEN
            iCurPos = 256.
    END.
END FUNCTION.
    