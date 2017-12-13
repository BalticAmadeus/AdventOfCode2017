BLOCK-LEVEL ON ERROR UNDO, THROW.

DEFINE TEMP-TABLE ttFirewall NO-UNDO
    FIELD layerID AS INTEGER
    FIELD depth AS INTEGER
    FIELD isGoingDown AS LOGICAL
    FIELD scanner AS INTEGER
.

INPUT FROM "input.in".

DEFINE VARIABLE cLine AS CHARACTER NO-UNDO.
DEFINE VARIABLE iFirewallDepth AS INTEGER NO-UNDO.
DEFINE VARIABLE iSeverity AS INTEGER NO-UNDO INITIAL 0.
DEFINE VARIABLE iPacketPosition AS INTEGER NO-UNDO.

REPEAT:
    IMPORT UNFORMATTED cLine.
    CREATE ttFirewall.
    ttFirewall.layerID = INTEGER(ENTRY(1, cLine, ":")).
    ttFirewall.depth = INTEGER(ENTRY(2, cLine, ":")).
    ttFirewall.scanner = 1.
    ttFirewall.isGoingDown = TRUE.

    iFirewallDepth = ttFirewall.layerID.
END.

DO iPacketPosition = 0 TO iFirewallDepth:
    //Check for colisions
    FIND ttFirewall WHERE
         ttFirewall.layerID = iPacketPosition NO-ERROR.
    IF AVAILABLE ttFirewall
    THEN DO:
        IF ttFirewall.scanner = 1
        THEN DO:
            iSeverity = iSeverity + ttFirewall.depth * ttFirewall.layerID.
            //DISPLAY ttFirewall.
        END.
    END.

    //Move scanners
    FOR EACH ttFirewall:
        IF ttFirewall.scanner = ttFirewall.depth
        THEN ttFirewall.isGoingDown = NOT ttFirewall.isGoingDown.
        ELSE IF ttFirewall.scanner = 1 AND
                NOT ttFirewall.isGoingDown
        THEN ttFirewall.isGoingDown = TRUE.

        IF ttFirewall.isGoingDown
        THEN ttFirewall.scanner = ttFirewall.scanner + 1.
        ELSE ttFirewall.scanner = ttFirewall.scanner - 1.
    END.
END.

DISPLAY iSeverity.
