BLOCK-LEVEL ON ERROR UNDO, THROW.

INPUT FROM "input.in".

DEFINE TEMP-TABLE ttParticle
    FIELD id AS int64
    FIELD px AS int64
    FIELD py AS int64
    FIELD pz AS int64
    FIELD vx AS int64
    FIELD vy AS int64
    FIELD vz AS int64
    FIELD ax AS int64
    FIELD ay AS int64
    FIELD az AS int64
    FIELD distance AS int64
    INDEX idx distance
    INDEX idx2 id
    INDEX idx3 px py pz
.

DEFINE VARIABLE cLine AS CHARACTER NO-UNDO.
DEFINE VARIABLE i AS INTEGER NO-UNDO INITIAL 0.
DEFINE VARIABLE indexP AS INTEGER NO-UNDO.
DEFINE VARIABLE indexV AS INTEGER NO-UNDO.
DEFINE VARIABLE indexA AS INTEGER NO-UNDO.
DEFINE VARIABLE substrP AS CHARACTER NO-UNDO.
DEFINE VARIABLE substrV AS CHARACTER NO-UNDO.
DEFINE VARIABLE substrA AS CHARACTER NO-UNDO.

REPEAT:
    IMPORT UNFORMATTED cLine.

    indexP = INDEX(cLine, "p=").
    indexV = INDEX(cLine, "v=").
    indexA = INDEX(cLine, "a=").

    substrP = SUBSTRING(cLine, indexP + 3, indexV - indexP - 6).
    substrV = SUBSTRING(cLine, indexV + 3, indexA - indexV - 6).
    substrA = SUBSTRING(cLine, indexA + 3, LENGTH(cLine) - indexA - 3).

    CREATE ttParticle.
    ttParticle.id = i.
    ttParticle.px = INTEGER(ENTRY(1, substrP)).
    ttParticle.py = INTEGER(ENTRY(2, substrP)).
    ttParticle.pz = INTEGER(ENTRY(3, substrP)).
    ttParticle.vx = INTEGER(ENTRY(1, substrV)).
    ttParticle.vy = INTEGER(ENTRY(2, substrV)).
    ttParticle.vz = INTEGER(ENTRY(3, substrV)).
    ttParticle.ax = INTEGER(ENTRY(1, substrA)).
    ttParticle.ay = INTEGER(ENTRY(2, substrA)).
    ttParticle.az = INTEGER(ENTRY(3, substrA)).

    i = i + 1.
END.

//Run simulation, fuck Progress for not having vectors
i = 0.
DEFINE VARIABLE livingParticles AS INTEGER NO-UNDO INITIAL 1000. 
DEFINE BUFFER bParticle FOR ttParticle.

REPEAT:
    FOR EACH ttParticle BY ttParticle.id:
        //Accelerate
        ttParticle.vx = ttParticle.vx + ttParticle.ax.
        ttParticle.vy = ttParticle.vy + ttParticle.ay.
        ttParticle.vz = ttParticle.vz + ttParticle.az.

        //Move
        ttParticle.px = ttParticle.px + ttParticle.vx.
        ttParticle.py = ttParticle.py + ttParticle.vy.
        ttParticle.pz = ttParticle.pz + ttParticle.vz.
    END.

    FOR EACH ttParticle BY ttParticle.id:
        FIND FIRST bParticle WHERE
                   bParticle.px = ttParticle.px AND 
                   bParticle.py = ttParticle.py AND 
                   bParticle.pz = ttParticle.pz AND 
                   bParticle.id <> ttParticle.id NO-ERROR.
        IF AVAILABLE bParticle //collision detected
        THEN DO:
            FOR EACH bParticle WHERE
                     bParticle.px = ttParticle.px AND 
                     bParticle.py = ttParticle.py AND 
                     bParticle.pz = ttParticle.pz:
                DELETE bParticle.
                livingParticles = livingParticles - 1.
            END.
        END.
    END.

    HIDE MESSAGE NO-PAUSE.
    MESSAGE "Iteration:" i "Left alive:" livingParticles.

    i = i + 1.
END.


