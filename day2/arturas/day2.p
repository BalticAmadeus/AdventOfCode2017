    
def var wkLine as char no-undo.
def var wkSum  as integer no-undo.

function getDiff returns int (ipLine as char) forward.

input from value("D:\dev\pdsoeProjects\CodeOfAdvent\res\inp.txt").
repeat:
    import unformatted wkLine.
    wkSum = wkSum + getDiff(wkLine).
    
end.
input close.

MESSAGE wkSum VIEW-AS ALERT-BOX.

function getDiff returns int (ipLine as char):
    def var wkI as int no-undo.
    def var wkMin as int no-undo.
    def var wkMax as int no-undo.
    def var wkNum as int no-undo.
    
    wkMin = integer(entry(1, ipLine, " ")).
    wkMax = integer(entry(1, ipLine, " ")).
    
    do wkI = 1 to num-entries(ipLine, " "):
        wkNum = integer(entry(wkI, ipLine, " ")).
        
        if wkNum > wkMax then
            wkMax = wkNum.
        if wkNum < wkMin then
            wkMin = wkNum.
    end.
    
    return wkMax - wkMin.
    
end function.
