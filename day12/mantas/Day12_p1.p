
/*------------------------------------------------------------------------
    File        : DayFour_p1.p
    Purpose     : 
    Notes       :
  ----------------------------------------------------------------------*/

block-level on error undo, throw.

def temp-table ttProg
    field line as int
    field program as char
    field programCalls as char
    index idx program
.

def temp-table ttProgCount
    field program as char
    field processed as log
    index idx program
.

def var vInput as char initial "input.txt" no-undo.
def var vLine as char no-undo.
def var vEntry as char no-undo.
def var vLineNr as int initial 0 no-undo.
def var i as int no-undo.
def var vSortWord as char no-undo.
def var vProgList as char no-undo.

function sortWord return char (vWord as char) forward.

input from value(vInput).

message "START".

input-blk:
repeat:
    import unformatted vLine.
    
    vLineNr = vLineNr + 1.
    
    create ttProg.
    ttProg.line = vLineNr.
    ttProg.program = trim(entry(1, vLine, "")).
    
    vSortWord = entry(2, vLine, ">").
    vProgList = "".
    
    repeat i = 1 to num-entries(vSortWord, ","):
        
        if vProgList = ""
        then vProgList =  trim(entry(i, vSortWord, ",")).
        else vProgList = vProgList + " " + trim(entry(i, vSortWord, ",")).
    end.
    
    ttProg.programCalls = vProgList.
end.



input close.

def var vGrp as int no-undo initial 0.
def buffer ttPrg2 for ttProg.
def buffer ttPrg for ttProg.
def buffer ttPrg3 for ttProg.

repblk2:
repeat:

    find first ttPrg no-lock no-error.
    if not avail ttPrg 
    then do:
        leave repblk2.
    end.
    
    disp ttPrg.program.
    
    vGrp = vGrp + 1.

    repeat i = 1 to num-entries(ttPrg.programCalls, " "):
        create ttProgCount.
        ttProgCount.program = trim(entry(i, ttPrg.programCalls, " ")).
        ttProgCount.processed = false.
    end.
    
    create ttProgCount.
    ttProgCount.program = ttPrg.program.
    ttProgCount.processed = true.
    
    def buffer bProgCount for ttProgCount.
    def buffer b2P for ttProgCount.
    def buffer b3p for ttProgCount.
    def buffer b4p for ttProgCount.

    repblk:
    repeat:
        
        find first bProgCount no-lock where
                   bProgCount.processed = false no-error.
        if avail bProgCount
        then do:
            find ttPrg3 where ttPrg3.program = bProgCount.program.
            
            repeat i = 1 to num-entries(ttPrg3.programCalls, ""):
                find first b3p where b3p.program = trim(entry(i, ttPrg3.programCalls, " ")) no-error.
                if not avail b3p
                then do:
                    create b3p.
                    b3p.program = trim(entry(i, ttPrg3.programCalls, " ")).
                    b3p.processed = false.
                end.
            end.
            
            bProgCount.processed = true.
        end.
        else do:
            leave repblk.
        end.
    
    end.
    
    for each ttProgCount:
        find first ttPrg2 where ttPrg2.program = ttProgCount.program no-error.
        if avail ttPrg2 
        then delete ttPrg2.
        
        delete ttProgCount.        
    end.
    
end.

disp vGrp.
