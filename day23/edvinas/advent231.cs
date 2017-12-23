using System;
using System.Collections.Generic;
using System.Linq;
					
public class advent231
{
    public struct instruction
    {
        public string command;
        public string register;
        public string amount;
    }
    public static void Main()
	{
        string line;
        
        Dictionary<char, int> register = new Dictionary<char, int>();
        register.Add('a', 0);
        register.Add('b', 0);
        register.Add('c', 0);
        register.Add('d', 0);
        register.Add('e', 0);
        register.Add('f', 0);
        register.Add('g', 0);
        register.Add('h', 0);

        instruction[] instructions = new instruction[32];
        int i = 0;

        System.IO.StreamReader file = new System.IO.StreamReader("input.txt");  
        while((line = file.ReadLine()) != null)  
        {
            var splitLine = line.Split();
            instructions[i].command = splitLine[0].ToString();
            instructions[i].register = splitLine[1].ToString();
            instructions[i].amount = splitLine[2].ToString();
            i++;
        }

        int currentNumber = 0;
        instruction currentInstruction = instructions[currentNumber];
        int currentAmount = 0;
        int multiplications = 0;

        while (true)
        {
            if (currentNumber >= 32 || currentNumber < 0)
                break;

            currentInstruction = instructions[currentNumber];
            if (!Int32.TryParse(currentInstruction.amount, out currentAmount))
                currentAmount = register[currentInstruction.amount[0]];

            if (currentInstruction.command == "set")
                register[currentInstruction.register[0]] = currentAmount;
            else if (currentInstruction.command == "sub")
                register[currentInstruction.register[0]] -= currentAmount;    
            else if (currentInstruction.command == "mul")
            {
                register[currentInstruction.register[0]] *= currentAmount;
                multiplications++;      
            }
            else if (currentInstruction.command == "jnz")
            {
                if (currentInstruction.register == "1" || register[currentInstruction.register[0]] != 0)
                    currentNumber += currentAmount - 1;
            }
            else 
            {
                Console.WriteLine("Unknown instruction {0}", currentInstruction.command);
                break;
            }

            currentNumber++;
        }

        Console.WriteLine(multiplications);
	}
}
