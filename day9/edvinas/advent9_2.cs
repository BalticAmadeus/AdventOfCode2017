using System;
using System.Numerics;
using System.Collections.Generic;

namespace myApp
{
    class advent9_2
    {
        static void Main(string[] args)
        {
            string line;
            int score = 0;
            int depth = 0;
            int garbageCount = 0;
            bool garbageFlag = false;
            bool ignoreFlag = false;

            System.IO.StreamReader file = new System.IO.StreamReader("input.txt");  
            line = file.ReadLine(); 

            for (int i = 0; i < line.Length; i++)
            {
                if (ignoreFlag)
                {
                    ignoreFlag = false;
                    continue;
                }

                switch (line[i])
                {
                    case '{':
                        if (!garbageFlag)
                            depth++;
                        else garbageCount++;
                        break;
                    case '}':
                        if (!garbageFlag)
                        {
                            score += depth; 
                            depth--;
                        }
                        else garbageCount++;
                        break;
                    case '<':
                        if (garbageFlag)
                            garbageCount++;
                        else garbageFlag = true; 
                        break;
                    case '>':
                        garbageFlag = false; 
                        break;
                    case '!':
                        ignoreFlag = true;
                        break;  
                    default:
                        if (garbageFlag)
                            garbageCount++;
                        break;
                }
            }
           
            System.Console.WriteLine(garbageCount);
        }
    }
}
