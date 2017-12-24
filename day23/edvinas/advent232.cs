using System;
using System.Collections.Generic;
using System.Linq;

public class advent232
{
    public static void Main()
    {
        int input = 107900;
        int c = input + 17000;
        int h = 0;

        for(int b = input; b < c + 1; b += 17)
        {
            if (!isPrime(b))
                h++;
        }

        Console.WriteLine(h);
    }

    public static bool isPrime(int number)
    {
        if (number == 1) return false;
        if (number == 2) return true;
        if (number % 2 == 0)  return false;

        var boundary = (int)Math.Floor(Math.Sqrt(number));

        for (int i = 3; i <= boundary; i+=2)
        {
            if (number % i == 0)  return false;
        }

        return true;
    }
}
