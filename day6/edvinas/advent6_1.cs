using System;
using System.Linq;
using System.Collections.Generic;
					
public class Program
{
	public static List<int> bankList;
	
	public static void Main()
	{
		string input = "0	5	10	0	11	14	13	4	11	8	8	7	1	4	12	11";
		//string input = "0 2 7 0";
		
		bankList = input.Split().Select(int.Parse).ToList();
		int cycles = 0;
		int maxIndex;

		List<string> snapshots = new List<string>();
		snapshots.Add(String.Join(", ", bankList.ToArray()));
		
		while (true)
		{
			cycles++;
			maxIndex = bankList.IndexOf(bankList.Max());
			redistribute(maxIndex);
			
			//Console.WriteLine(String.Join(", ", bankList.ToArray()));
			if (snapshots.Contains(String.Join(", ", bankList.ToArray())))
				break;
			snapshots.Add(String.Join(", ", bankList.ToArray()));
		}

		
		Console.WriteLine(cycles);
	}
	
	public static void redistribute(int bankNumber)
	{
		int currentBank = bankNumber;
		int numBlocks = bankList[bankNumber];
		
		bankList[bankNumber] = 0;
		
		for (int i = numBlocks; i > 0; i--)
		{
			currentBank++;
			if (currentBank >= bankList.Count())
				currentBank = 0;
			
			bankList[currentBank]++;
		}
	}
}