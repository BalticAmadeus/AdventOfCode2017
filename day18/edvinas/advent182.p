BLOCK-LEVEL ON ERROR UNDO, THROW.

INPUT FROM "input.in".

DEFINE TEMP-TABLE ttInstruction NO-UNDO
    FIELD id AS INTEGER
    FIELD instruction AS CHARACTER 
    FIELD register AS CHARACTER 
    FIELD amount AS CHARACTER 
    INDEX idx id
.

DEFINE TEMP-TABLE ttRegister NO-UNDO
    FIELD id AS CHARACTER
    FIELD program AS INTEGER 
    FIELD amount AS int64 INITIAL 0
.

DEFINE TEMP-TABLE ttQueue NO-UNDO
    FIELD id AS int64
    FIELD receiver AS INTEGER
    FIELD amount AS int64
    INDEX idx receiver id ASCENDING 
.

DEFINE VARIABLE cLine AS CHARACTER NO-UNDO.
DEFINE VARIABLE iInstrcutionCount AS INTEGER NO-UNDO INITIAL 0.
DEFINE VARIABLE queueCount AS int64 NO-UNDO INITIAL 0.
DEFINE VARIABLE totalSends AS int64 NO-UNDO INITIAL 0.

REPEAT:
    IMPORT UNFORMATTED cLine.

    iInstrcutionCount = iInstrcutionCount + 1.
    CREATE ttInstruction.
    ttInstruction.id = iInstrcutionCount.
    ttInstruction.instruction = ENTRY(1, cLine, " ").
    ttInstruction.register = ENTRY(2, cLine, " ").
    ttInstruction.amount = ENTRY(3, cLine, " ") NO-ERROR.
END.

CREATE ttRegister.
ttRegister.id = "p".
ttRegister.program = 1.
ttRegister.amount = 0.
CREATE ttRegister.
ttRegister.id = "p".
ttRegister.program = 2.
ttRegister.amount = 1.

DEFINE VARIABLE currentInstruction AS INTEGER EXTENT 2 NO-UNDO.
currentInstruction[1] = 1.
currentInstruction[2] = 1.
DEFINE VARIABLE isWaiting AS LOGICAL EXTENT 2 NO-UNDO.
isWaiting[1] = FALSE.
isWaiting[2] = FALSE.

DEFINE BUFFER bQueue FOR ttQueue.
DEFINE VARIABLE cycleCount AS INTEGER NO-UNDO INITIAL 0.
DEFINE VARIABLE queueInstructions1 AS INTEGER NO-UNDO INITIAL 0.
DEFINE VARIABLE queueInstructions2 AS INTEGER NO-UNDO INITIAL 0.

ETIME(true).

execution-loop:
DO WHILE TRUE:
    queueInstructions1 = 0.
    queueInstructions2 = 0.
    FOR EACH ttQueue:
        IF ttQueue.receiver = 1
        THEN queueInstructions1 = queueInstructions1 + 1.
        IF ttQueue.receiver = 2
        THEN queueInstructions2 = queueInstructions2 + 1.
    END.
    HIDE MESSAGE NO-PAUSE.
    MESSAGE "Cycle number:" cycleCount "queueInstructions:" queueInstructions1 queueInstructions2 "Time spent:" ETIME / 1000.
    cycleCount = cycleCount + 1.

    FIND FIRST ttQueue WHERE
               ttQueue.receiver = 1 NO-ERROR.
    FIND FIRST bQueue WHERE
               bQueue.receiver = 2 NO-ERROR.

    IF (AVAILABLE ttQueue OR NOT isWaiting[1])
    THEN RUN processInstructions(1).
    ELSE IF (AVAILABLE bQueue OR NOT isWaiting[2])
    THEN RUN processInstructions(2).
    ELSE LEAVE execution-loop.
END.

DISPLAY totalSends.

PROCEDURE processInstructions:
    DEFINE INPUT PARAMETER programID AS INTEGER NO-UNDO.

    DEFINE VARIABLE currentAmount AS int64 NO-UNDO.
    DEFINE BUFFER ttRegister FOR ttRegister.
    DEFINE BUFFER ttInstruction FOR ttInstruction.
    DEFINE BUFFER bRegister FOR ttRegister.
    DEFINE BUFFER ttQueue FOR ttQueue.

    instruction-loop:
    DO WHILE TRUE:
        FIND ttInstruction WHERE
             ttInstruction.id = currentInstruction[programID].

        FIND bRegister WHERE
             bRegister.program = programID AND
             bRegister.id = ttInstruction.amount NO-ERROR.
        IF AVAILABLE bRegister
        THEN currentAmount = bRegister.amount.
        ELSE currentAmount = INTEGER(ttInstruction.amount).

        FIND ttRegister WHERE
             ttRegister.program = programID AND
             ttRegister.id = ttInstruction.register NO-ERROR.

        CASE ttInstruction.instruction:
            WHEN "snd"
            THEN DO:
                CREATE ttQueue.
                ttQueue.id = queueCount.
                IF AVAILABLE ttRegister
                THEN ttQueue.amount = ttRegister.amount.
                ELSE ttQueue.amount = INTEGER(ttInstruction.register).

                IF programID = 1
                THEN DO:
                    ttQueue.receiver = 2.
                END.
                ELSE IF programID = 2
                THEN DO:
                    ttQueue.receiver = 1.
                    totalSends = totalSends + 1.
                END.
                ELSE MESSAGE "Something went wrong!" VIEW-AS ALERT-BOX.

                queueCount = queueCount + 1.
            END.
            WHEN "set"
            THEN DO:
                IF NOT AVAILABLE ttRegister
                THEN DO:
                    CREATE ttRegister.
                    ttRegister.program = programID.
                    ttRegister.id = ttInstruction.register.
                END.
                ttRegister.amount = currentAmount.
            END.
            WHEN "add"
            THEN DO:
                IF NOT AVAILABLE ttRegister
                THEN DO:
                    CREATE ttRegister.
                    ttRegister.program = programID.
                    ttRegister.id = ttInstruction.register.
                    ttRegister.amount = 0.
                END.
                ttRegister.amount = ttRegister.amount + currentAmount.
            END.
            WHEN "mul"
            THEN DO:
                IF NOT AVAILABLE ttRegister
                THEN DO:
                    CREATE ttRegister.
                    ttRegister.program = programID.
                    ttRegister.id = ttInstruction.register.
                    ttRegister.amount = 0.
                END.
                ttRegister.amount = ttRegister.amount * currentAmount.
            END.
            WHEN "mod"
            THEN DO:
                IF NOT AVAILABLE ttRegister
                THEN DO:
                    CREATE ttRegister.
                    ttRegister.program = programID.
                    ttRegister.id = ttInstruction.register.
                    ttRegister.amount = 0.
                END.
                ttRegister.amount = ttRegister.amount MODULO currentAmount.
            END.
            WHEN "rcv"
            THEN DO:
                FIND FIRST ttQueue WHERE
                           ttQueue.receiver = programID USE-INDEX idx NO-ERROR.
                IF AVAILABLE ttQueue 
                THEN DO:
                    IF NOT AVAILABLE ttRegister
                    THEN DO:
                        CREATE ttRegister.
                        ttRegister.program = programID.
                        ttRegister.id = ttInstruction.register.
                        ttRegister.amount = 0.
                    END.
                    ttRegister.amount = ttQueue.amount.
                    DELETE ttQueue.
                    isWaiting[programID] = FALSE.
                END.
                ELSE DO:
                    isWaiting[programID] = TRUE.
                    LEAVE instruction-loop.
                END.
            END.
            WHEN "jgz"
            THEN DO:
                IF AVAILABLE ttRegister
                THEN DO:
                    IF ttRegister.amount > 0
                    THEN currentInstruction[programID] = currentInstruction[programID] + currentAmount - 1.
                END.
                ELSE DO:
                    IF INTEGER(ttInstruction.register) > 0
                    THEN currentInstruction[programID] = currentInstruction[programID] + currentAmount - 1.
                END.
            END.
            OTHERWISE DO:
                MESSAGE "Unknown command" ttInstruction.instruction.
            END.
        END CASE.

        currentInstruction[programID] = currentInstruction[programID] + 1.
    END.
END PROCEDURE.


