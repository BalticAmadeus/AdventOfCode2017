using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
					
public class advent211
{
    public static Dictionary<string, string> ruleDictionary = new Dictionary<string, string>();

    public static void Main()
	{
        string[] ruleList = File.ReadAllLines("input.txt"); 
        string[] currentGrid = new string[]
        {
            ".#.",
            "..#",
            "###",
        };

        //Make disctionary of all rules and their transformations
        foreach (string rule in ruleList)
        {
            string[] splitRules = rule.Split(new string[] { "=>" }, StringSplitOptions.None);

            string pattern = splitRules[0].Trim();
            string output = splitRules[1].Trim();

            ruleDictionary.TryAdd(pattern, output);
            ruleDictionary.TryAdd(flipHorizontaly(pattern), output);
            ruleDictionary.TryAdd(flipVerticaly(pattern), output);

            string rotation1 = rotate(pattern);
            string rotation2 = rotate(rotation1);
            string rotation3 = rotate(rotation2);

            ruleDictionary.TryAdd(rotation1, output);
            ruleDictionary.TryAdd(flipHorizontaly(rotation1), output);
            ruleDictionary.TryAdd(flipVerticaly(rotation1), output);

            ruleDictionary.TryAdd(rotation2, output);
            ruleDictionary.TryAdd(flipHorizontaly(rotation2), output);
            ruleDictionary.TryAdd(flipVerticaly(rotation2), output);

            ruleDictionary.TryAdd(rotation3, output);
            ruleDictionary.TryAdd(flipHorizontaly(rotation3), output);
            ruleDictionary.TryAdd(flipVerticaly(rotation3), output);
        }

        for (int i = 0; i < 18; i++)
        {
            currentGrid = ENHANCE(currentGrid);
        }

        int count = 0;
        foreach (string currentLine in currentGrid)
        {
            Console.WriteLine(currentLine);
            count += currentLine.Count(x => x == '#');
        }
        Console.WriteLine(count);
	}

    public static string[] ENHANCE(string[] currentGrid)
    {
        int gridSize;
        if (currentGrid.Length % 2 == 0)
            gridSize = 2;
        else gridSize = 3;

        string[] enhancedGrid = new string[(currentGrid.Length / gridSize) * (gridSize + 1)];

        for (int i = 0; i * gridSize < currentGrid.Length; i++)
        {
            for (int j = 0; j * gridSize < currentGrid.Length; j++)
            {
                string square = collectSquare(currentGrid, i * gridSize, j * gridSize, gridSize);
                addToNewGrid(enhancedGrid, ruleDictionary[square], gridSize + 1, i * (gridSize + 1));
            }
        }

        return enhancedGrid;
    }

    public static void addToNewGrid(string[] grid, string square, int size, int cornerRow)
    {
        string[] rows = square.Split('/', StringSplitOptions.RemoveEmptyEntries);
        for (int i = 0; i < size; i++)
        {
            for (int j = 0; j < size; j++)
            {
                grid[cornerRow + i] += rows[i][j];
            }
        }
    }

    public static string collectSquare(string[] grid, int cornerRow, int cornerColumn, int size)
    {
        string[] section = new string[size];

        for (int i = 0; i < size; i++)
        {
            for (int j = 0; j < size; j++)
            {
                section[i] += grid[i + cornerRow][j + cornerColumn];
            }
        }

        return string.Join('/', section);
    }

    public static void CopyTo(string[] grid, string section, int size, int startRow, int startColumn)
    {
        string[] rows = section.Split('/', StringSplitOptions.RemoveEmptyEntries);
        for (int i = 0; i < size; i++)
        {
            for (int j = 0; j < size; j++)
            {
                grid[startRow + i] += rows[i][j];
            }
        }
    }

    public static string rotate(string pattern)
    {
        string[] splitPattern = pattern.Split("/");
        char[,] rotatedGrid = new char[splitPattern.Length, splitPattern.Length];
        string[] rotatedPattern = new string[splitPattern.Length];

        for(int i = 0; i < splitPattern.Length; i++)
        {
            for (int j = 0; j < splitPattern.Length; j++)
            {
                rotatedGrid[splitPattern.Length - j - 1, i] = splitPattern[i][j];
            }
        }

        for(int i = 0; i < splitPattern.Length; i++)
        {
            for(int j = 0; j < splitPattern.Length; j++)
            {
                rotatedPattern[i] += rotatedGrid[i,j];
            }
        }

        return string.Join<string>('/', rotatedPattern);
    }

    public static string flipHorizontaly(string pattern)
    {
        string[] splitPattern = pattern.Split("/");
        string[] flippedPattern = new string[splitPattern.Length];

        for(int i = 0; i < splitPattern.Length; i++)
        {
            flippedPattern[splitPattern.Length - i - 1] = splitPattern[i];
        }

        return string.Join<string>('/', flippedPattern);
    }

    public static string flipVerticaly(string pattern)
    {
        string[] splitPattern = pattern.Split("/");
        string[] flippedPattern = new string[splitPattern.Length];

        for(int i = 0; i < splitPattern.Length; i++)
        {
            flippedPattern[i] = string.Join("", splitPattern[i].Reverse());
        }

        return string.Join<string>('/', flippedPattern);
    }
}
