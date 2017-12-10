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
            List<int> instructions;
            int currentPosition = 0;
            int skipSize = 0;

            System.IO.StreamReader file = new System.IO.StreamReader("input.txt");  
            line = file.ReadLine();
            instructions = line.Split(',').Select(Byte.Parse).ToList();

            for (int i = 0; i < 5; i++)
            {
                currentList.Add(i);
            }

            foreach (int i in instructions)
            {
                currentList = reverseSublist(currentList, currentPosition, i);
                currentPosition += (i + skipSize);
                if (currentPosition > currentList.Count())
                    currentPosition = currentPosition - currentList.Count();
                skipSize++;
            }

            System.Console.WriteLine(currentList[0] * currentList[1]);
            System.Console.WriteLine(String.Join(',', currentList));
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
