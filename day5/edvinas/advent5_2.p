BLOCK-LEVEL ON ERROR UNDO, THROW.

DEFINE TEMP-TABLE ttInstruction NO-UNDO
    FIELD lineNo AS INTEGER
    FIELD instruction AS INTEGER 
    INDEX idx IS UNIQUE PRIMARY lineNo.

DEFINE VARIABLE inst AS INTEGER EXTENT 3000.

INPUT FROM "input.in".

DEFINE VARIABLE cLine AS CHARACTER NO-UNDO.
DEFINE VARIABLE iLineCount AS INTEGER NO-UNDO INITIAL 0.

REPEAT:
    IMPORT UNFORMATTED cLine.

    iLineCount = iLineCount + 1.
    inst[iLineCount] = INTEGER(cLine).
END.

DEFINE VARIABLE iInstructionNo AS INTEGER NO-UNDO INITIAL 1.
DEFINE VARIABLE iStepCount AS INTEGER NO-UNDO INITIAL 0.

REPEAT:
    IF iInstructionNo > 1070 OR
       iInstructionNo < 0
    THEN LEAVE.

    iInstructionNo = iInstructionNo + inst[iInstructionNo].

    IF inst[iInstructionNo] >= 3
    THEN inst[iInstructionNo] = inst[iInstructionNo] - 1.
    ELSE inst[iInstructionNo] = inst[iInstructionNo] + 1.
    iStepCount = iStepCount + 1.
END.

DISPLAY iStepCount.

