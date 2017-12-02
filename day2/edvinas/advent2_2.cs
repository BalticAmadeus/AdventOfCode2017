using System;
using System.Linq;
using System.Collections.Generic;

namespace myApp
{
    class advent2_2
    {
        static void Main(string[] args)
        {
            string line;
            List<int> lineNumbers;
            int hashCode = 0;

            System.IO.StreamReader file = new System.IO.StreamReader("input.txt");  
            while((line = file.ReadLine()) != null)  
            {  
                lineNumbers = line.Split().Select(Int32.Parse).ToList();
                lineNumbers.Sort();
                for (int i = 0; i < lineNumbers.Count - 1; i++)
                {
                    for (int j = i + 1; j < lineNumbers.Count; j++)
                    {
                        if (lineNumbers[j] % lineNumbers[i] == 0)
                            hashCode += lineNumbers[j] / lineNumbers[i];
                    }
                }
            }  
            System.Console.WriteLine (hashCode); 
        }
    }
}
