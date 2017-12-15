using System;
using System.Numerics;
using System.Collections.Generic;

namespace myApp
{
    class advent9_1
    {
        static void Main(string[] args)
        {
            string line;
            int score = 0;
            int depth = 0;
            bool garbageFlag = false;
            bool ignoreFlag = false;

            System.IO.StreamReader file = new System.IO.StreamReader("input2.txt");  
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
                        break;
                    case '}':
                        if (!garbageFlag)
                        {
                            score += depth; 
                            depth--;
                        }
                        break;
                    case '<':
                        garbageFlag = true; 
                        break;
                    case '>':
                        garbageFlag = false; 
                        break;
                    case '!':
                        ignoreFlag = true;
                        break;  
                    default:
                        //System.Console.WriteLine("Unknown symbol! {0}", line[i]);
                        break;
                }
            }
           
            System.Console.WriteLine(score);
        }
    }
}
