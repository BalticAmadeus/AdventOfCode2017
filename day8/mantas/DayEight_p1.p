
/*------------------------------------------------------------------------
    File        : DayThree_p1.p
    Purpose     : 
    Notes       :
  ----------------------------------------------------------------------*/

block-level on error undo, throw.

def temp-table ttLine
    field Register as char
    field IncDec as char
    field IncDecValue as int
    field OperReg as char
    field OperCheck as char
    field OperValue as int
.

def temp-table ttRegister
    field Register as char
    field RegValue as int
    index idx Register.
.

def var vLine as char no-undo.
def var i as int no-undo.


input from value("input.txt").

repeat:
    import unformatted vLine.
    
    create ttLine.
    ttLine.Register = entry(1, vLine, "").
    ttLine.IncDec= entry(2, vLine, "").
    ttLine.IncDecValue = integer(entry(3, vLine, "")).
    ttLine.OperReg = entry(5, vLine, "").
    ttLine.OperCheck = entry(6, vLine, "").
    ttLine.OperValue = integer(entry(7, vLine, "")).
    
    find ttRegister where 
         ttRegister.Register = ttLine.Register no-error.
    if not avail ttRegister
    then do:
        create ttRegister.
        ttRegister.Register = ttLine.Register.
        ttRegister.RegValue = 0.
    end.
    
    find ttRegister where 
         ttRegister.Register = ttLine.OperReg no-error.
    if not avail ttRegister
    then do:
        create ttRegister.
        ttRegister.Register = ttLine.OperReg.
        ttRegister.RegValue = 0.
    end.
end.

def var vCheckReg as char no-undo.
def var vCheckVal as int no-undo.
def var vMax as int initial 0 no-undo.

LineBlock:
for each ttLine:
    
    vCheckReg = ttLine.OperReg.
    vCheckVal = ttLine.OperValue.
    
    find ttRegister where 
         ttRegister.Register = vCheckReg.
    if vMax < ttRegister.RegValue
    then vMax = ttRegister.RegValue.
    
    case OperCheck:
        when "=="
        then do:
            if ttRegister.RegValue <> vCheckVal
            then next LineBlock.
        end.
        when "!="
        then do:
            if ttRegister.RegValue = vCheckVal
            then next LineBlock.
        end.
        when ">="
        then do:
            if ttRegister.RegValue < vCheckVal
            then next LineBlock.
        end.
        when "<="
        then do:
            if ttRegister.RegValue > vCheckVal
            then next LineBlock.
        end.
        when ">"
        then do:
            if ttRegister.RegValue <= vCheckVal
            then next LineBlock.
        end.
        when "<"
        then do:
            if ttRegister.RegValue >= vCheckVal
            then next LineBlock.
        end.
        otherwise.
    end case.
    
    find ttRegister where 
         ttRegister.Register = ttLine.Register.
    if ttLine.IncDec = "inc"
    then do:
        if vMax < ttRegister.RegValue
        then vMax = ttRegister.RegValue.
        ttRegister.RegValue = ttRegister.RegValue + ttLine.IncDecValue.
        if vMax < ttRegister.RegValue
        then vMax = ttRegister.RegValue.
    end.
    else do:
        if vMax < ttRegister.RegValue
        then vMax = ttRegister.RegValue.
        ttRegister.RegValue = ttRegister.RegValue - ttLine.IncDecValue.
        if vMax < ttRegister.RegValue
        then vMax = ttRegister.RegValue.
    end.
end.


disp vMax.
