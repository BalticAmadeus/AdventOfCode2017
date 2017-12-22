BLOCK-LEVEL ON ERROR UNDO, THROW.

INPUT FROM "input.in".

DEFINE TEMP-TABLE ttMap  
    FIELD ix AS INTEGER
    FIELD iy AS INTEGER 
    FIELD sts AS CHARACTER
    INDEX idx ix iy
. 

DEFINE VARIABLE cLine AS CHARACTER NO-UNDO.
DEFINE VARIABLE maxHeight AS INTEGER NO-UNDO INITIAL 0.
DEFINE VARIABLE maxWidth AS INTEGER NO-UNDO INITIAL 0.
DEFINE VARIABLE i AS INTEGER NO-UNDO.

REPEAT:
    IMPORT UNFORMATTED cLine.

    maxHeight = maxHeight + 1.
    maxWidth = LENGTH(cLIne).

    DO i = 1 TO LENGTH(cLIne):
        CREATE ttMap.
        ttMap.ix = i.
        ttMap.iy = maxHeight.
        ttMap.sts = SUBSTRING(cLine, i, 1).
    END.
END.

FUNCTION turn RETURNS CHARACTER (direction AS CHARACTER, sts AS CHARACTER):
    IF sts = "." //not infected, turn left
    THEN DO:
        CASE direction:
            WHEN "up"
            THEN RETURN "left".
            WHEN "left"
            THEN RETURN "down".
            WHEN "down"
            THEN RETURN "right".
            WHEN "right"
            THEN RETURN "up".
        END CASE.
    END.
    ELSE IF sts = "#" 
    THEN DO: //infected, turn right
        CASE direction:
            WHEN "up"
            THEN RETURN "right".
            WHEN "right"
            THEN RETURN "down".
            WHEN "down"
            THEN RETURN "left".
            WHEN "left"
            THEN RETURN "up".
        END CASE.
    END.
    ELSE IF sts = "F" 
    THEN DO: //turn around
        CASE direction:
            WHEN "up"
            THEN RETURN "down".
            WHEN "right"
            THEN RETURN "left".
            WHEN "down"
            THEN RETURN "up".
            WHEN "left"
            THEN RETURN "right".
        END CASE.
    END.
    ELSE RETURN direction.
END FUNCTION.

DEFINE VARIABLE currentX AS INTEGER NO-UNDO.
DEFINE VARIABLE currentY AS INTEGER NO-UNDO.
DEFINE VARIABLE currentDirection AS CHARACTER NO-UNDO INITIAL "up".

DEFINE VARIABLE bursts AS INTEGER NO-UNDO INITIAL 0.
DEFINE VARIABLE infections AS INTEGER NO-UNDO INITIAL 0.

currentX = maxWidth / 2.
currentY = maxHeight / 2.

ETIME(true).

REPEAT:
    IF bursts MODULO 1000 = 0
    THEN DO:
        HIDE MESSAGE NO-PAUSE.
        MESSAGE "Remaining cycles:" 10000000 - bursts "Elapsed time:" ETIME / 1000.
    END.

    FIND ttMap WHERE
         ttMap.ix = currentX AND
         ttMap.iy = currentY NO-ERROR.
    IF NOT AVAILABLE ttMap
    THEN DO:
        CREATE ttMap.
        ttMap.ix = currentX.
        ttMap.iy = currentY.
        ttMap.sts = ".".
    END.

    currentDirection = turn(currentDirection, ttMap.sts).

    bursts = bursts + 1.
    IF ttMap.sts = "."
    THEN ttMap.sts = "W".
    ELSE IF ttMap.sts = "W"
    THEN DO:
        ttMap.sts = "#".
        infections = infections + 1.
    END.
    ELSE IF ttMap.sts = "#"
    THEN ttMap.sts = "F".
    ELSE ttMap.sts = ".".

    CASE currentDirection:
        WHEN "up"
        THEN currentY = currentY - 1.
        WHEN "down"
        THEN currentY = currentY + 1.
        WHEN "left"
        THEN currentX = currentX - 1.
        WHEN "right"
        THEN currentX = currentX + 1.
    END CASE.

    IF bursts = 10000000
    THEN LEAVE.
END.

DISPLAY bursts infections.
