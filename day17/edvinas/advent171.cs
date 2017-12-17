using System;
using System.Collections.Generic;
using System.Linq;
					
public class advent171
{
    public static void Main()
	{
		int step = 356;
		int position = 0;
		List<int> spinlock = new List<int>();
		spinlock.Add(0);
				
		for (int i = 1; i < 2018; i++)
		{
			if (step % spinlock.Count() >= 0)
				position += step % spinlock.Count();
			else position += step;

			if (position >= spinlock.Count())
				position = position - spinlock.Count();

			position++;
			spinlock.Insert(position, i);
		}

		int index2017;
		index2017 = spinlock.IndexOf(2017);
        Console.WriteLine(spinlock[index2017 + 1]);
	}
}
