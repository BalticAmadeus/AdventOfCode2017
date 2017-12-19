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
DEFINE VARIABLE i AS INTEGER NO-UNDO.

REPEAT:
    IMPORT UNFORMATTED cLine.

    maxHeight = maxHeight + 1.

    DO i = 1 TO LENGTH(cLIne):
        CREATE ttMap.
        ttMap.ix = i.
        ttMap.iy = maxHeight.
        ttMap.sts = SUBSTRING(cLine, i, 1).
    END.
END.

DEFINE VARIABLE direction AS CHARACTER NO-UNDO INITIAL "down".
DEFINE VARIABLE collection AS CHARACTER NO-UNDO INITIAL "".
DEFINE VARIABLE coordX AS INTEGER NO-UNDO.
DEFINE VARIABLE coordY AS INTEGER NO-UNDO.

FUNCTION canGo RETURNS LOGICAL (cx AS INTEGER, cy AS INTEGER, direct AS CHARACTER):
    DEFINE BUFFER ttMap FOR ttMap.

    FIND ttMap WHERE
         ttMap.ix = cx AND
         ttMap.iy = cy NO-ERROR.
    IF NOT AVAILABLE ttMap
    THEN RETURN FALSE.

    IF ttMap.sts = " "
    THEN RETURN FALSE.

    IF (direct = "up" OR
        direct = "down") AND
       ttMap.sts = "-"
    THEN RETURN TRUE.

    IF (direct = "left" OR
        direct = "right") AND
       ttMap.sts = "|"
    THEN RETURN TRUE.

    RETURN TRUE.
END FUNCTION.

//Find entry point
FIND ttMap WHERE
     ttMap.sts = "|" AND
     ttMap.iy = 1.
coordX = ttMap.ix.
coordY = ttMap.iy.

DEFINE VARIABLE stepCount AS INTEGER NO-UNDO INITIAL 0.

walk-block:
REPEAT:
    //MESSAGE coordX coordY.
    FIND ttMap WHERE
         ttMap.ix = coordX AND
         ttMap.iy = coordY NO-ERROR.
    IF NOT AVAILABLE ttMap
    THEN LEAVE walk-block. //exit found

    CASE ttMap.sts:
        WHEN " "
        THEN LEAVE walk-block. //exit found maybe?
        WHEN "|"
        THEN DO:
            IF direction = "down"
            THEN coordY = coordY + 1.
            ELSE IF direction = "up"
            THEN coordY = coordY - 1.
            ELSE IF direction = "right"
            THEN coordX = coordX + 1.
            ELSE IF direction = "left"
            THEN coordX = coordX - 1.
            ELSE MESSAGE "Something bad has happened. 2. Panick!".
        END.
        WHEN "-"
        THEN DO:
            IF direction = "right"
            THEN coordX = coordX + 1.
            ELSE IF direction = "left"
            THEN coordX = coordX - 1.
            ELSE IF direction = "down"
            THEN coordY = coordY + 1.
            ELSE IF direction = "up"
            THEN coordY = coordY - 1.
            ELSE MESSAGE "Something bad has happened. 3. Panick!".
        END.
        WHEN "+"
        THEN DO:
            IF direction = "right" OR
               direction = "left"
            THEN DO:
                IF canGo(coordX, coordY - 1, "up")
                THEN DO:
                    coordY = coordY - 1.
                    direction = "up".
                END.
                ELSE IF canGo(coordX, coordY + 1, "down")
                THEN DO:
                    coordY = coordY + 1.
                    direction = "down".
                END.
                ELSE MESSAGE "Something bad has happened. 4. Panick!".
            END.
            ELSE IF direction = "up" OR
                    direction = "down"
            THEN DO:
                IF canGo(coordX - 1, coordY, "left")
                THEN DO:
                    coordX = coordX - 1.
                    direction = "left".
                END.
                ELSE IF canGo(coordX + 1, coordY, "right")
                THEN DO:
                    coordX = coordX + 1.
                    direction = "right".
                END.
                ELSE MESSAGE "Something bad has happened. 6. Panick!".
            END.
            ELSE MESSAGE "Something bad has happened. 7. Panick!".
        END.
        OTHERWISE DO:
            IF direction = "down"
            THEN coordY = coordY + 1.
            ELSE IF direction = "up"
            THEN coordY = coordY - 1.
            ELSE IF direction = "right"
            THEN coordX = coordX + 1.
            ELSE IF direction = "left"
            THEN coordX = coordX - 1.
            ELSE MESSAGE "Something bad has happened. 5. Panick!".

            collection = collection + ttMap.sts.
        END.
    END CASE.

    stepCount = stepCount + 1.
END.

MESSAGE collection stepCount.
