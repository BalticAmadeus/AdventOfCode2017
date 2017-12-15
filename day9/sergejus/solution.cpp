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
	int nCond = 1; //1 - read, 0 - garbage, -1 ignore
	int nDepth = 0;
	int nTotalScore = 0;
	int nCharCount = 0;
	char ch;

	fstream input("input.txt", fstream::in);
	while (input >> noskipws >> ch) {
		if (nCond == 1) {
			switch (ch) {
				case '{': ++nDepth; break;
				case '}': 
					nTotalScore += nDepth;
					--nDepth;
					break;
				case '<': nCond = 0; break;
			}
		}
		else if (nCond == 0) {
			switch (ch) {
				case '!': nCond = -1; break;
				case '>': nCond = 1; break;
				default: ++nCharCount; break;
			}
		}
		else if(nCond == -1){
			nCond = 0;
		}
	}

	cout << nTotalScore << endl << nCharCount;
	return 0;
}