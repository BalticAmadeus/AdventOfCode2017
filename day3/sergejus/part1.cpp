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
	int inp = 289326;

	int width = 1;
	int nMaxValue = 1;

	while (inp > nMaxValue) {
		width += 2;
		nMaxValue = width * width;
	}

	int nCurrNum = nMaxValue;

	int nRealX, nRealY;
	nRealX = nRealY = 0;

	int x, y;
	x = y = width - 1;

	/*
	____
	|  |
    ***
	*/
	for (int i = width; i > 1; i--) {
		nCurrNum--;
		x--;
		if (nCurrNum == inp) {
			nRealX = x;
			nRealY = y;
			break;
		}
	}
	/*
	____
	*  |
	----
	*/
	for (int i = width; i > 1; i--) {
		nCurrNum--;
		y--;
		if (nCurrNum == inp) {
			nRealX = x;
			nRealY = y;
			break;
		}
	}

	/*
	****
	|  |
	----
	*/
	for (int i = width; i > 1; i--) {
		nCurrNum--;
		x++;
		if (nCurrNum == inp) {
			nRealX = x;
			nRealY = y;
			break;
		}
	}

	/*
	____
	|  *
	----
	*/
	for (int i = width; i > 1; i--) {
		nCurrNum--;
		y++;
		if (nCurrNum == inp) {
			nRealX = x;
			nRealY = y;
			break;
		}
	}

	int center = abs(width / 2);

	cout << abs(nRealX - center) + abs(nRealY - center);

	return 0;
}