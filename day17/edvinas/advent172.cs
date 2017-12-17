using System;
using System.Collections.Generic;
using System.Linq;
					
public class advent172
{
    public static void Main()
	{
		int step = 356;
		int position = 0;
		int index0 = 0;
		List<int> spinlock = new List<int>();
		spinlock.Add(0);
				
		for (int i = 1; i < 50000000; i++)
		{
			if (step % i >= 0)
				position += step % i;
			else position += step;

			if (position >= i)
				position = position - i;

			position++;

			if (position == 1)
				index0 = i;
		}

        Console.WriteLine(index0);
	}
}
