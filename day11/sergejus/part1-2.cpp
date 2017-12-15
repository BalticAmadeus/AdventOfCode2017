#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <sstream>
#include <iterator>
#include <algorithm>

using namespace std;

int main() {
	stringstream str;
	string direction;
	int x, y, max, distance;
	x = y = max = 0;

	ifstream input("input.txt");
	if (input)
	{
		str << input.rdbuf();

		input.close();

	}

	while (std::getline(str, direction, ','))
	{
		if (direction == "n") {
			x += 0;
			y += 1;
		}
		else if (direction == "ne") {
			x += -1;
			y += 1;
		}
		else if (direction == "se") {
			x += -1;
			y += 0;
		}
		else if (direction == "s") {
			x += 0;
			y += -1;
		}
		else if (direction == "sw") {
			x += 1;
			y += -1;
		}
		else if (direction == "nw") {
			x += 1;
			y += 0;
		}
		
		distance = (abs(x) + abs(y) + abs(x + y)) / 2;
		if (distance > max) 
			max = distance;
	}

	cout <<  distance << endl << max;

	return 0;
}