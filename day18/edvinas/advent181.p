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
    FIELD amount AS int64 INITIAL 0
.

DEFINE VARIABLE cLine AS CHARACTER NO-UNDO.
DEFINE VARIABLE iInstrcutionCount AS INTEGER NO-UNDO INITIAL 0.

REPEAT:
    IMPORT UNFORMATTED cLine.

    iInstrcutionCount = iInstrcutionCount + 1.
    CREATE ttInstruction.
    ttInstruction.id = iInstrcutionCount.
    ttInstruction.instruction = ENTRY(1, cLine, " ").
    ttInstruction.register = ENTRY(2, cLine, " ").
    ttInstruction.amount = ENTRY(3, cLine, " ") NO-ERROR.
END.

DEFINE VARIABLE currentInstruction AS INTEGER NO-UNDO INITIAL 1.
DEFINE VARIABLE lastSoundPlayed AS INTEGER NO-UNDO INITIAL 0.
DEFINE VARIABLE currentAmount AS INTEGER NO-UNDO.
DEFINE BUFFER bRegister FOR ttRegister.

instruction-loop:
DO WHILE TRUE:
    FIND ttInstruction WHERE
         ttInstruction.id = currentInstruction.

    FIND bRegister WHERE
         bRegister.id = ttInstruction.amount NO-ERROR.
    IF AVAILABLE bRegister
    THEN currentAmount = bRegister.amount.
    ELSE currentAmount = INTEGER(ttInstruction.amount).

    FIND ttRegister WHERE
         ttRegister.id = ttInstruction.register NO-ERROR.

    CASE ttInstruction.instruction:
        WHEN "snd"
        THEN DO:
            IF NOT AVAILABLE ttRegister
            THEN lastSoundPlayed = 0.
            ELSE lastSoundPlayed = ttRegister.amount.
        END.
        WHEN "set"
        THEN DO:
            IF NOT AVAILABLE ttRegister
            THEN DO:
                CREATE ttRegister.
                ttRegister.id = ttInstruction.register.
            END.
            ttRegister.amount = currentAmount.
        END.
        WHEN "add"
        THEN DO:
            IF NOT AVAILABLE ttRegister
            THEN DO:
                CREATE ttRegister.
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
                ttRegister.id = ttInstruction.register.
                ttRegister.amount = 0.
            END.
            ttRegister.amount = ttRegister.amount MODULO currentAmount.
        END.
        WHEN "rcv"
        THEN DO:
            IF AVAILABLE ttRegister AND
                         ttRegister.amount > 0
            THEN DO:
                MESSAGE lastSoundPlayed VIEW-AS ALERT-BOX.
                LEAVE instruction-loop.
            END.
        END.
        WHEN "jgz"
        THEN DO:
            IF AVAILABLE ttRegister AND
                         ttRegister.amount > 0
            THEN DO:
                currentInstruction = currentInstruction + currentAmount - 1.
            END.
        END.
        OTHERWISE DO:
            MESSAGE "Unknown command" ttInstruction.instruction.
        END.
    END CASE.

    currentInstruction = currentInstruction + 1.
END.


