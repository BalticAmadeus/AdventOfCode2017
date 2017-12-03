
/*------------------------------------------------------------------------
    File        : DayThree_p1.p
    Purpose     : 
    Notes       :
  ----------------------------------------------------------------------*/

block-level on error undo, throw.

def var vInput as int no-undo initial 325489.
def var iteration as int no-undo.
def var vNumInLine as int no-undo.
def var vMaxNumber as int no-undo.
def var vLenght as int no-undo.
def var vNumber as int no-undo.
def var vMagicNumber as int initial 0 no-undo.
def var vAdd as log no-undo initial false.

vNumInLIne = 1.
vMaxNumber = 1.

do while vMaxNumber < vInput:
   iteration = iteration + 1.

   vMagicNumber = (vNumInLine + 1) / 2 - 1.
   
   if 4 + vNumInLine * 4 + vMaxNumber >= vInput
   then do:
       vNumber = vMaxNumber.
       
       do while vNumber <= vInput:
            vNumber = + vNumber + 1.
            
            message vNumber vMagicNumber vNumInLine (vNumInLine + 1) / 2 + vMagicNumber vInput iteration.
            
            if vNumber = vInput
            then do:
                vLenght = (vNumInLine + 1) / 2 + vMagicNumber.
                disp vLenght.
            
            end.
            
            if vAdd
            then vMagicNumber = vMagicNumber + 1.
            else vMagicNumber = vMagicNumber - 1.
            
            if vMagicNumber = 0
            then do:
                vAdd = true.
            end.
            if vMagicNumber = (vNumInLine + 1) / 2
            then do:
                vAdd = false.
            end.    
       end.
       
       
   end.
   
   
   vMaxNumber = 4 + vNumInLine * 4 + vMaxNumber.
   vNumInLine = vNumInLine + 2.
end.

vLenght = vNumInLine - 1.
