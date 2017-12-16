using System;
using System.Numerics;
using System.Linq;
using System.Collections.Generic;

namespace myApp
{
    class advent161
    {
        static void Main(string[] args)
        {
            string line;
            List<string> instructions;
            List<char> programs = new List<char>{'a','b','c','d','e',
                                                 'f','g','h','i','j',
                                                 'k','l','m','n','o','p'};
            int splitLocation;

            System.IO.StreamReader file = new System.IO.StreamReader("input.txt");  
            line = file.ReadLine(); 

            instructions = line.Split(',').ToList();

            foreach (string i in instructions)
            {
                if (i.StartsWith('s'))
                {
                    programs = spin(programs, Convert.ToInt32(i.Substring(1)));
                }
                else if (i.StartsWith('x'))
                {
                    splitLocation = i.IndexOf("/");
                    programs = exchange(programs, Convert.ToInt32(i.Substring(1, splitLocation - 1)), Convert.ToInt32(i.Substring(splitLocation + 1)));
                }
                else if (i.StartsWith('p'))
                {
                    programs = swap(programs, Convert.ToChar(i.Substring(1, 1)),  Convert.ToChar(i.Substring(3, 1)));
                }
            }

            foreach (char i in programs)
            {
                System.Console.Write(i);
            }
            System.Console.WriteLine();
        }

        public static List<char> spin(List<char> programs, int spinNumber)
        {
            List<char> result = new List<char>();
            result.AddRange( programs.GetRange(programs.Count() - spinNumber, spinNumber) );
            result.AddRange( programs.GetRange(0, programs.Count() - spinNumber) );
            return result;
        }

        public static List<char> exchange(List<char> programs, int position1, int position2)
        {
            char tempChar;
            tempChar = programs[position1];
            programs[position1] = programs[position2];
            programs[position2] = tempChar;
            return programs;
        }

        public static List<char> swap(List<char> programs, char program1, char program2)
        {
            return exchange(programs, programs.FindIndex(x => x == program1), programs.FindIndex(x => x == program2));
        }
    }
}
