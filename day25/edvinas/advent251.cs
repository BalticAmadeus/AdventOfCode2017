using System;
using System.Collections.Generic;
using System.Linq;

public class advent251
{
    public struct rule
    {
        public int value;
        public string direction;
        public char newState;
    }
    public struct condition
    {
        public char state;
        public int value;
    }

    public static void Main()
    {
        string line;
        char currentState;
        int requiredSteps;
        Dictionary<condition, rule> turingMachine = new Dictionary<condition, rule>();

        System.IO.StreamReader file = new System.IO.StreamReader("input.txt");
        line = file.ReadLine();
        currentState = line[15]; //read starting state
        line = file.ReadLine();
        requiredSteps = Int32.Parse(line.Split()[5]); //read itrartion number

        //read instruction set
        while(true)  
        {
            char readState = ' ';
            int readValue;
            condition readCondition = new condition();
            rule readRule = new rule();

            for(int i = 0; i < 10; i++)
            {
                line = file.ReadLine();
                if (line == null)
                    break;
                if (i == 1)
                    readState = line.Split()[2][0];
                else if (i == 2 || i == 6)
                {
                    readValue = Int32.Parse(line.Split()[7][0].ToString());
                    readCondition = new condition();
                    readCondition.state = readState;
                    readCondition.value = readValue;
                }
                else if (i == 3 || i == 7)
                {
                    readRule = new rule();
                    readRule.value = Int32.Parse(line.Split()[8][0].ToString());
                }
                else if (i == 4 || i == 8)
                    readRule.direction = line.Split()[10].TrimEnd('.');
                else if (i == 5 || i == 9)
                {
                    readRule.newState = line.Split()[8][0];
                    turingMachine.Add(readCondition, readRule);
                }
            }
            if (line == null)
                break;
        }

        int currentPosition = 0;
        condition currentCondition = new condition();
        rule currentRule = new rule();
        Dictionary<int, int> tape = new Dictionary<int, int>();

        //execute turing machine instructions
        for (int i = 0; i < requiredSteps; i++)
        {
            //check if tape needs to be resized, probably should optimize
            if (!tape.ContainsKey(currentPosition))
                tape.Add(currentPosition, 0);

            //find instruction to execute
            currentCondition.state = currentState;
            currentCondition.value = tape[currentPosition];
            currentRule = turingMachine[currentCondition];

            //execute instructions
            tape[currentPosition] = currentRule.value;
            currentState = currentRule.newState;
            if (currentRule.direction == "right")
                currentPosition++;
            else if (currentRule.direction == "left")
                currentPosition--;
            else Console.WriteLine("Unexpected rule found! {0}", currentRule.direction);
        }

        int checksum = 0;
        foreach (KeyValuePair<int, int> field in tape)
        {
            checksum += field.Value;
        }

        Console.WriteLine("Done! Result: {0}", checksum);
    }
}
