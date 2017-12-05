#include <iostream>
using namespace std;

const int N = 1074;
int main() {
	int list[N] = {};
	unsigned int steps = 0;
	int oldVal = 0;

	for (int i = 0; i < N; i++) {
		cin >> list[i];
	}

	for (int i = 0; i < N;) {
		oldVal = list[i];
		++steps;
		/* if part==2 && if (oldVal > 2){
			--list[i];
		}
		else */++list[i];
		i += oldVal;
	}

	cout << steps;
	return 0;
}