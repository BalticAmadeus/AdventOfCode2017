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

int getSum(vector<int> vec) {
	int nSum = 0;

	for (int i = 0; i < vec.size(); i++) {
		for (int j = 0; j < vec.size(); j++){
			if (i == j)
				continue;
			
			if (vec[i] % vec[j] == 0)
				nSum+= vec[i] / vec[j];
		}
	}

	return nSum;
}

int main() {
	ifstream input("input.txt");
	string line;
	int nCheckSum = 0;

	while (getline(input, line)) {
		stringstream sStream(line);
		istream_iterator<int> begin(sStream), end;
		vector<int> vec(begin, end);

		nCheckSum += getSum(vec);
	}

	input.close();

	cout << nCheckSum;

	return 0;
}