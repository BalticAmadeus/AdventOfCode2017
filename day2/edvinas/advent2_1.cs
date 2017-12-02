using System;
using System.Linq;
using System.Collections.Generic;

namespace myApp
{
    class advent2_1
    {
        static void Test(string[] args)
        {
            string line;
            List<int> lineNumbers;
            int hashCode = 0;

            System.IO.StreamReader file = new System.IO.StreamReader("input.txt");  
            while((line = file.ReadLine()) != null)  
            {  
                lineNumbers = line.Split().Select(Int32.Parse).ToList();
                hashCode += lineNumbers.Max() - lineNumbers.Min();
            }  
            System.Console.WriteLine (hashCode); 
        }
    }
}
