using System;
using System.Numerics;
using System.Collections.Generic;

namespace myApp
{
    class advent3_1
    {
        
        static int getNeighbors(int x, int y, int offset, int[,] boardMap)
        {
            int nSum = 0;

            nSum += boardMap[x + offset - 1, y + offset - 1];
            nSum += boardMap[x + offset - 1, y + offset + 1];
            nSum += boardMap[x + offset + 1, y + offset - 1];
            nSum += boardMap[x + offset + 1, y + offset + 1];

            nSum += boardMap[x + offset + 1, y + offset - 0];
            nSum += boardMap[x + offset - 1, y + offset - 0];
            nSum += boardMap[x + offset - 0, y + offset - 1];
            nSum += boardMap[x + offset - 0, y + offset + 1];

            if (nSum == 0)
                nSum = 1;

            return nSum;
        }
        static void Main(string[] args)
        {
            int iInput = 312051;
            int xCurrent = 0;
            int yCurrent = 0;
            int iMovement = 1;
            int iSpeed = 1;
            int iValue = 0;
            string direction = "right";

            int[,] boardMap = new int[500, 500];
            int offset = 250;

            for(int i = 0; i < iInput; i++)
            {
                iValue = getNeighbors(xCurrent, yCurrent, offset, boardMap);
                System.Console.WriteLine(iValue);
                if (iValue > iInput)
                    break;
                boardMap[xCurrent + offset, yCurrent + offset] = iValue;

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

            //System.Console.WriteLine ( Math.Abs(boardMap[iInput - 1].X) + Math.Abs(boardMap[iInput - 1].Y)); 
            System.Console.WriteLine(iValue);
        }
    }
}
