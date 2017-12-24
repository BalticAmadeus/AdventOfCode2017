using System;
using System.Collections.Generic;
using System.Linq;

public class advent241
{
    public struct component
    {
        public int id;
        public int leftConnector;
        public int rightConnector;
        public bool used;
    }

    public static component[] components = new component[58];

    public static void Main()
    {
        string line;
        int i = 1;

        components[0].id = 0;
        components[0].leftConnector = 0;
        components[0].rightConnector = 0;
        components[0].used = false;

        System.IO.StreamReader file = new System.IO.StreamReader("input.txt");  
        while((line = file.ReadLine()) != null)  
        {
            var splitLine = line.Split('/');
            components[i].id = i;
            components[i].leftConnector  = Int32.Parse(splitLine[0]);
            components[i].rightConnector = Int32.Parse(splitLine[1]);
            components[i].used = false;
            i++;
        }

        Console.WriteLine(connectBridge(0, 0, 0));
    }
    
    public static int connectBridge(int currentWeight, int currentNode, int currentSide)
    {
        int maxWeight = 0;
        int subBridgeWeight = 0;
        components[currentNode].used = true;
        int componentWeight = components[currentNode].leftConnector + components[currentNode].rightConnector;

        foreach (component currentComp in components.Where(x => (x.leftConnector == currentSide || x.rightConnector == currentSide) && !x.used))
        {
            if (currentComp.leftConnector == currentSide)
            {
                subBridgeWeight = connectBridge(componentWeight, currentComp.id, currentComp.rightConnector);
            }
            else
            {
                subBridgeWeight = connectBridge(componentWeight, currentComp.id, currentComp.leftConnector);
            }

            maxWeight = Math.Max(subBridgeWeight, maxWeight);
        }

        components[currentNode].used = false;
        return maxWeight + componentWeight;
    }
}
