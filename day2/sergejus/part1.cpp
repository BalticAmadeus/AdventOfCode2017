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
	ifstream input("input.txt");
	string line;
	int nCheckSum = 0;

	while (getline(input, line)) {
		stringstream sStream(line);
		istream_iterator<int> begin(sStream), end;
		vector<int> vec(begin, end);
		
		nCheckSum += *max_element(vec.begin(), vec.end()) - *min_element(vec.begin(), vec.end());
	}

	input.close();

	cout << nCheckSum;

	return 0;
}