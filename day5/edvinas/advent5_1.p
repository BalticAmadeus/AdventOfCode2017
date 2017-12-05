BLOCK-LEVEL ON ERROR UNDO, THROW.

DEFINE TEMP-TABLE ttInstruction NO-UNDO
    FIELD lineNo AS INTEGER
    FIELD instruction AS INTEGER 
    INDEX idx lineNo.

INPUT FROM "input.in".

DEFINE VARIABLE cLine AS CHARACTER NO-UNDO.
DEFINE VARIABLE iLineCount AS INTEGER NO-UNDO INITIAL 0.

REPEAT:
    IMPORT UNFORMATTED cLine.

    iLineCount = iLineCount + 1.

    CREATE ttInstruction.
    ttInstruction.lineNo = iLineCount.
    ttInstruction.instruction = INTEGER(cLine).

END.

DEFINE VARIABLE iInstructionNo AS INTEGER NO-UNDO INITIAL 1.
DEFINE VARIABLE iStepCount AS INTEGER NO-UNDO INITIAL 0.

REPEAT:
    FIND ttInstruction WHERE
         ttInstruction.lineNo = iInstructionNo NO-ERROR.
    IF NOT AVAILABLE ttInstruction
    THEN LEAVE.

    iInstructionNo = iInstructionNo + ttInstruction.instruction.

    ttInstruction.instruction = ttInstruction.instruction + 1.
    iStepCount = iStepCount + 1.
END.

DISPLAY iStepCount.

