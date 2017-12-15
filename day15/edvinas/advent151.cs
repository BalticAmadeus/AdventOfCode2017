using System;
					
public class Program
{
	public static ulong superMagicNumber = 2147483647;
	
	public static void Main()
	{
		ulong gen1 = 277;
		ulong gen2 = 349;
		
		ulong factor1 = 16807;
		ulong factor2 = 48271;
		
		int score = 0;
		
		for (int i = 0; i < 40000000; i++)
		{
			gen1 = getNextNumber(gen1, factor1);
			gen2 = getNextNumber(gen2, factor2);
			if ((gen1 & 0xFFFF) == (gen2 & 0xFFFF))
				score++;
		}		
		Console.WriteLine(score);
		
	}
	
	public static ulong getNextNumber(ulong input, ulong factor)
	{
		return input * factor % superMagicNumber;
	}
}
