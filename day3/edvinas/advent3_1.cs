using System;
using System.Numerics;
using System.Collections.Generic;

namespace myApp
{
    class advent3_1
    {
        static void Main(string[] args)
        {
            int iInput = 312051;
            int xCurrent = 0;
            int yCurrent = 0;
            int iMovement = 1;
            int iSpeed = 1;
            string direction = "right";

            List<Vector2> boardMap = new List<Vector2>();

            for(int i = 0; i < iInput; i++)
            {
                boardMap.Add(new Vector2(xCurrent, yCurrent));
                //System.Console.Write ( xCurrent); 
                //System.Console.Write ( "; "); 
                //System.Console.WriteLine ( yCurrent);

                if (direction == "right")
                {
                    iMovement--;
                    if (iMovement == 0) 
                    {
                        direction = "up";
                        iMovement = iSpeed;
                    }

                    xCurrent += 1;
                }
                else if (direction == "up")
                {
                    iMovement--;
                    if (iMovement == 0) 
                    {
                        direction = "left";
                        iSpeed++;
                        iMovement = iSpeed;
                    }

                    yCurrent += 1;
                    
                }
                else if (direction == "left")
                {
                    iMovement--;
                    if (iMovement == 0) 
                    {
                        direction = "down";
                        iMovement = iSpeed;
                    }

                    xCurrent -= 1;
                }
                else if (direction == "down")
                {
                    iMovement--;
                    if (iMovement == 0) 
                    {
                        direction = "right";
                        iSpeed++;
                        iMovement = iSpeed;
                    }

                    yCurrent -= 1;
                    
                }

            }

            System.Console.WriteLine ( Math.Abs(boardMap[iInput - 1].X) + Math.Abs(boardMap[iInput - 1].Y)); 
        }
    }
}
