using System;
using System.Collections.Generic;
using System.Linq;
					
public class Program
{
	public static void Main()
	{
		string cInput = "ljoxqyyw";
		string hexHash;
		string binaryHash;
		int iCount = 0;
		
		for (int i = 0; i < 128; i++)
		{
			hexHash = getKnotHash(cInput + "-" + i);
			binaryHash = String.Join(String.Empty, hexHash.Select(c => Convert.ToString(Convert.ToInt32(c.ToString(), 16), 2).PadLeft(4, '0')));
			iCount += binaryHash.Count(j => j == '1');
			//Console.WriteLine(binaryHash);
		}
		Console.WriteLine(iCount);
	}
	
	static string getKnotHash(string sInput)
	{
		string line;
		List<int> currentList = new List<int>();
		List<int> instructions = new List<int>();
		int currentPosition = 0;
		int skipSize = 0;
		
		line = sInput;
		
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
			//hashString += Convert.ToString(currentByte, 2);
			hashString += currentByte.ToString("x2");
			//Console.WriteLine(Convert.ToString(currentByte, 2));
		}
		
		
		return hashString;
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