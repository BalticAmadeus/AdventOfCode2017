BLOCK-LEVEL ON ERROR UNDO, THROW.

DEFINE TEMP-TABLE ttPasswords NO-UNDO
    FIELD lineNo AS INTEGER
    FIELD word AS CHARACTER 
    INDEX idx lineNo word.

INPUT FROM "input.in".

DEFINE VARIABLE cLine AS CHARACTER NO-UNDO INITIAL 0.
DEFINE VARIABLE iLineCount AS INTEGER NO-UNDO.
DEFINE VARIABLE iValidLines AS INTEGER NO-UNDO INITIAL 0.
DEFINE VARIABLE i AS INTEGER NO-UNDO.

read-block:
REPEAT:
    IMPORT UNFORMATTED cLine.
    iLineCount = iLineCount + 1.

    DO i = 1 TO NUM-ENTRIES(cLine, " "):
        FIND ttPasswords WHERE
             ttPasswords.word = ENTRY(i, cLine, " ") AND
             ttPasswords.lineNo = iLineCount NO-ERROR.
        IF AVAILABLE ttPasswords
        THEN NEXT read-block.
        ELSE DO:
            CREATE ttPasswords.
            ttPasswords.lineNo = iLineCount.
            ttPasswords.word = ENTRY(i, cLine, " ").
        END.
    END.

    iValidLines = iValidLines + 1.
END.

DISPLAY iValidLines iLineCount.