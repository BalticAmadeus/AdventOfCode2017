using System;
using System.Numerics;
using System.Collections.Generic;
using System.Linq;

namespace myApp
{
    class advent10_1
    {
        static void Main(string[] args)
        {
            string line;
            List<int> currentList = new List<int>();
            List<int> instructions = new List<int>();
            int currentPosition = 0;
            int skipSize = 0;

            System.IO.StreamReader file = new System.IO.StreamReader("input.txt");  
            line = file.ReadLine();
            
            for (int i = 0; i < 256; i++)
            {
                currentList.Add(i);
            }

            for (int i = 0; i < line.Length; i++)
            {
                instructions.Add((Int32)line[i]);
            }
            instructions.Add(17);
            instructions.Add(31);
            instructions.Add(73);
            instructions.Add(47);
            instructions.Add(23);

            for (int j = 0; j < 64; j++)
            {
                foreach (int i in instructions)
                {
                    currentList = reverseSublist(currentList, currentPosition, i);
                    currentPosition += (i + skipSize);
                    if (currentPosition > currentList.Count())
                        currentPosition = currentPosition % currentList.Count();
                    skipSize++;
                }
            }

            string hashString = "";
            int currentByte;
            for (int i = 0; i < 255; i+=16)
            {
                currentByte = currentList[i];
                for (int j = 1; j < 16; j++)
                {
                    currentByte = currentByte ^ currentList[i + j];
                }
                hashString += currentByte.ToString("x2");
            }

            System.Console.WriteLine(hashString);
        }
        static List<int> reverseSublist(List<int> currentList, int start, int length)
        {
            if (length == 1)
                return currentList;

            //duplicate current lest to imitate circularity
            List<int> workingList = new List<int>(currentList);
            workingList.AddRange(currentList);

            //reverse sublist
            List<int> sublist = new List<int>(workingList.GetRange(start, length));
            sublist.Reverse();

            //add sublist back to working list
            for (int i = start; i < start + length; i++)
            {
                workingList[i] = sublist[i - start];
            }

            //reassemble list
            int tempLength = workingList.Count / 2;
            List<int> resultList = new List<int>();

            if (tempLength - tempLength + start > 0)
                resultList.AddRange(workingList.GetRange(tempLength, tempLength - (tempLength - start)));
            resultList.AddRange(workingList.GetRange(start, tempLength - start));

            return resultList;
        }
    }
}
