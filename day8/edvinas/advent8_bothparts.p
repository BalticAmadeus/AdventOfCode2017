BLOCK-LEVEL ON ERROR UNDO, THROW.

DEFINE TEMP-TABLE ttInstruction NO-UNDO
    FIELD register AS CHARACTER
    FIELD operation AS CHARACTER
    FIELD amt AS INTEGER 
    FIELD compRegister AS CHARACTER
    FIELD comparison AS CHARACTER
    FIELD compAmt AS INTEGER
.

DEFINE TEMP-TABLE ttRegister NO-UNDO
    FIELD register AS CHARACTER
    FIELD amt AS INTEGER
.

DEFINE VARIABLE cLine AS CHARACTER NO-UNDO.
DEFINE VARIABLE iMaxAmt AS INTEGER NO-UNDO INITIAL 0.

INPUT FROM "input.in".

REPEAT:
    IMPORT UNFORMATTED cLine.

    CREATE ttInstruction.
    ttInstruction.register = ENTRY(1, cLine, " ").
    ttInstruction.operation = ENTRY(2, cLine, " ").
    ttInstruction.amt = INTEGER(ENTRY(3, cLine, " ")).
    ttInstruction.compRegister = ENTRY(5, cLine, " ").
    ttInstruction.comparison = ENTRY(6, cLine, " ").
    ttInstruction.compAmt = INTEGER(ENTRY(7, cLine, " ")).

    FIND ttRegister WHERE
         ttRegister.register = ttInstruction.register NO-ERROR.
    IF NOT AVAILABLE ttRegister
    THEN DO:
        CREATE ttRegister.
        ttRegister.register = ttInstruction.register.
        ttRegister.amt = 0.
    END.
END.

DEFINE VARIABLE isLegal AS LOGICAL NO-UNDO.

FOR EACH ttInstruction:
    FIND ttRegister WHERE
         ttRegister.register = ttInstruction.compRegister. //add no-error if problems

    CASE ttInstruction.comparison:
        WHEN "=="
            THEN isLegal = (ttRegister.amt = ttInstruction.compAmt).
        WHEN ">"
            THEN isLegal = (ttRegister.amt > ttInstruction.compAmt).
        WHEN "<"
            THEN isLegal = (ttRegister.amt < ttInstruction.compAmt).
        WHEN "<="
            THEN isLegal = (ttRegister.amt <= ttInstruction.compAmt).
        WHEN ">="
            THEN isLegal = (ttRegister.amt >= ttInstruction.compAmt).
        WHEN "!="
            THEN isLegal = (ttRegister.amt <> ttInstruction.compAmt).
        OTHERWISE MESSAGE "Illegal operation:" ttInstruction.comparison.
    END CASE.

    IF NOT isLegal
    THEN NEXT.

    FIND ttRegister WHERE
         ttRegister.register = ttInstruction.register.
    IF ttInstruction.operation = "inc"
    THEN ttRegister.amt = ttRegister.amt + ttInstruction.amt.
    IF ttInstruction.operation = "dec"
    THEN ttRegister.amt = ttRegister.amt - ttInstruction.amt.

    IF ttRegister.amt > iMaxAmt
    THEN iMaxAmt = ttRegister.amt.
END.

FOR EACH ttRegister:
    DISPLAY ttRegister.
END.

MESSAGE iMaxAmt.
