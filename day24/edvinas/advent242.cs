using System;
using System.Collections.Generic;
using System.Linq;

public class advent242
{
    public struct component
    {
        public int id;
        public int leftConnector;
        public int rightConnector;
        public bool used;
    }

    public static component[] components = new component[58];
    public static int maxDepth = 0;

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

        //much zeroes, many wow, very recursion, extremely bridge
        int maximumDepth;
        Console.WriteLine(connectBridge(0, 0, 0, 0, out maximumDepth));
    }
    
    public static int connectBridge(int depth, int currentWeight, int currentNode, int currentSide, out int maxDepth)
    {
        int maxWeight = 0;
        int subBridgeWeight = 0;
        components[currentNode].used = true;
        int componentWeight = components[currentNode].leftConnector + components[currentNode].rightConnector;
        int currentMaxDepth = 0;

        maxDepth = depth;

        foreach (component currentComp in components.Where(x => (x.leftConnector == currentSide || x.rightConnector == currentSide) && !x.used))
        {
            if (currentComp.leftConnector == currentSide)
                subBridgeWeight = connectBridge(depth + 1, componentWeight, currentComp.id, currentComp.rightConnector, out currentMaxDepth);
            else
                subBridgeWeight = connectBridge(depth + 1, componentWeight, currentComp.id, currentComp.leftConnector, out currentMaxDepth);

            if (currentMaxDepth >= maxDepth)
            {
                maxDepth = currentMaxDepth;
                maxWeight = subBridgeWeight;
            }
        }

        components[currentNode].used = false;
        return maxWeight + componentWeight;
    }
}
