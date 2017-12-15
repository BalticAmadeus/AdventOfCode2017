BLOCK-LEVEL ON ERROR UNDO, THROW.

INPUT FROM "input.in".

DEFINE VARIABLE cLine AS CHARACTER NO-UNDO.
DEFINE VARIABLE iFirewallDepth AS INTEGER NO-UNDO.
DEFINE VARIABLE isCaught AS LOGICAL NO-UNDO.
DEFINE VARIABLE iPacketPosition AS INTEGER NO-UNDO.
DEFINE VARIABLE iTime AS INTEGER NO-UNDO.

DEFINE VARIABLE iFirewall AS INTEGER EXTENT 97 NO-UNDO.

ETIME(TRUE).

REPEAT:
    IMPORT UNFORMATTED cLine.

    iFirewall[INTEGER(ENTRY(1, cLine, ":")) + 1] = INTEGER(ENTRY(2, cLine, ":")).
    iFirewallDepth = INTEGER(ENTRY(1, cLine, ":")).
END.

DEFINE VARIABLE iDelay AS INTEGER NO-UNDO INITIAL 0.

delay-block:
REPEAT:
    //clear state
    isCaught = FALSE.
    iPacketPosition = 0.

    internal-block:
    DO iTime = iDelay TO iFirewallDepth + iDelay:
        IF iTime >= iDelay 
        THEN DO:
            //Check for colisions
            IF iFirewall[iPacketPosition + 1] > 0
            THEN DO:
                IF iTime MODULO ((iFirewall[iPacketPosition + 1] - 1) * 2) = 0
                THEN DO:
                    isCaught = true.
                    LEAVE internal-block.
                END.
            END.

            iPacketPosition = iPacketPosition + 1.
        END.
    END.

    IF NOT isCaught
    THEN LEAVE delay-block.
    
    //try longer delay
    iDelay = iDelay + 1.

    HIDE MESSAGE NO-PAUSE.
    MESSAGE iDelay ETIME / 1000.

END.

DISPLAY iDelay ETIME / 1000.
