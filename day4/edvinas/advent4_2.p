BLOCK-LEVEL ON ERROR UNDO, THROW.

DEFINE TEMP-TABLE ttPasswords NO-UNDO
    FIELD id AS INTEGER
    FIELD lineNo AS INTEGER
    FIELD word AS CHARACTER 
    INDEX idx lineNo word
.

DEFINE TEMP-TABLE ttAnagram NO-UNDO
    FIELD letter AS CHARACTER
    FIELD letterCount AS INTEGER
.

INPUT FROM "input.in".

DEFINE VARIABLE cLine AS CHARACTER NO-UNDO INITIAL 0.
DEFINE VARIABLE iLineCount AS INTEGER NO-UNDO.
DEFINE VARIABLE iValidLines AS INTEGER NO-UNDO INITIAL 0.
DEFINE VARIABLE i AS INTEGER NO-UNDO.
DEFINE VARIABLE iCurrentID AS INTEGER NO-UNDO.

FUNCTION isAnagram RETURNS LOGICAL (cWord1 AS CHARACTER, cWord2 AS CHARACTER):
    DEFINE VARIABLE i AS INTEGER NO-UNDO.

    IF LENGTH(cWord1) <> LENGTH(cWord2)
    THEN RETURN FALSE.

    FOR EACH ttAnagram:
        DELETE ttAnagram.
    END.

    DO i = 1 TO LENGTH(cWord1):
        FIND ttAnagram WHERE
             ttAnagram.letter = SUBSTRING(cWord1, i, 1) NO-ERROR.
        IF AVAILABLE ttAnagram
        THEN ttAnagram.letterCount = ttAnagram.letterCount + 1.
        ELSE DO:
            CREATE ttAnagram.
            ttAnagram.letter = SUBSTRING(cWord1, i, 1).
            ttAnagram.letterCount = 1.
        END.
    END.

    DO i = 1 TO LENGTH(cWord2):
        FIND ttAnagram WHERE
             ttAnagram.letter = SUBSTRING(cWord2, i, 1) NO-ERROR.
        IF AVAILABLE ttAnagram
        THEN DO:
            ttAnagram.letterCount = ttAnagram.letterCount - 1.
            IF ttAnagram.letterCount < 0
            THEN RETURN FALSE.
        END.
        ELSE RETURN FALSE.
    END.

    FOR EACH ttAnagram:
        IF ttAnagram.letterCount > 0
        THEN RETURN FALSE.
    END.

    RETURN TRUE.
END FUNCTION.

DEFINE BUFFER bPasswords FOR ttPasswords.

REPEAT:
    IMPORT UNFORMATTED cLine.
    iLineCount = iLineCount + 1.

    DO i = 1 TO NUM-ENTRIES(cLine, " "):
        iCurrentID = iCurrentID + 1.
        CREATE ttPasswords.
        ttPasswords.id = iCurrentID.
        ttPasswords.lineNo = iLineCount.
        ttPasswords.word = ENTRY(i, cLine, " ").
    END.
END.

main-block:
DO i = 1 TO iLineCount:
    FOR EACH ttPasswords WHERE
             ttPasswords.lineNo = i:
        FOR EACH bPasswords WHERE
                 bPasswords.lineNo = i AND
                 bPasswords.id > ttPasswords.id:
            IF isAnagram(ttPasswords.word, bPasswords.word)
            THEN NEXT main-block.
        END.
    END.
    iValidLines = iValidLines + 1.
END.

DISPLAY iValidLines iLineCount.

