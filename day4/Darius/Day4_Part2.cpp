#define _CRT_SECURE_NO_DEPRECATE
#pragma comment(linker, "/STACK:16777216")
#include <iostream>
#include <fstream>
#include <cstdio>
#include <stdio.h>
#include <cstdlib>
#include <stdlib.h>
#include <string>
#include <list>
#include <fstream>
#include <algorithm>
#include <cmath>
#include <map>
#include <vector>
#include <iomanip>
#include <queue>
#include <deque>
#include <set>
#include <stack>
#include <sstream>
#include <assert.h>
#include <functional>
#include <climits>
#include <cstring>
#include <bitset>
#include <unordered_map>
typedef long long ll;
typedef std::pair<ll, ll> pll;
typedef std::pair<int, int> pii;
#define _USE_MATH_DEFINES
#define ALL(x)           (x).begin(), (x).end()
#define forn(N)          for(ll i = 0; i<(int)N; i++)
#define fornj(N)         for(ll j = 0; j<(int)N; j++)
#define fornk(N)         for(ll k = 0; k<(int)N; k++)
#define forn1(N)          for(ll i = 1; i<=(int)N; i++)
#define fornj1(N)         for(ll j = 1; j<=(int)N; j++)
#define fornk1(N)         for(ll k = 1; k<=(int)N; k++)
#define PI 3.1415926535897932384626433
#define LINF (1LL<<60)
#define INF (1<<30)
#define v vector
#define File "fileName"

#define isOn(S, j) (S & (1 << j))
#define setBit(S, j) (S |= (1 << j))
#define clearBit(S, j) (S &= ~(1 << j))
#define toggleBit(S, j) (S ^= (1 << j))
#define lowBit(S) (S & (-S))
#define setAll(S, n) (S = (1 << n) - 1)

#define log2BitApproximate(S) ((int)(log((double)S) / log(2.0)))
#define log2Bit(S) (1 << (log2BitApproximate(S) + 1) > S ? log2BitApproximate(S) : log2BitApproximate(S) + 1)
#define highBit(S) (isPowerOfTwo(S) ? S : 1 << log2Bit(S))

#define modulo(S, N) ((S) & (N - 1))   // returns S % N, where N is a power of 2
#define isPowerOfTwo(S) (!(S & (S - 1)))
#define nearestPowerOfTwo(S) ((int)pow(2.0, (int)((log((double)S) / log(2.0)) + 0.5)))
#define turnOffLastBit(S) ((S) & (S - 1))
#define turnOnLastZero(S) ((S) | (S + 1))
#define turnOffLastConsecutiveBits(S) ((S) & (S + 1))
#define turnOnLastConsecutiveZeroes(S) ((S) | (S - 1))

using namespace std;

const ll MOD = 1000000007;
const double EPS = 1e-6;

int DIRECTIONS[8][2] = { { 0,1 },{ -1,1 },{ -1,0 },{ -1,-1 },{ 0,-1 },{ 1,-1 },{ 1,0 },{ 1,1 } };

bool checkExistance(v<string>& exists, string word)
{
	int letters[26] = { 0 };
	

	forn(word.length())
		letters[word[i] - 'a']++;

	fornj(exists.size())
	{
		int letters2[26] = { 0 };
		forn(exists[j].length())
			letters2[exists[j][i] - 'a']++;

		bool match = true;
		forn(26)
			if (letters[i] != letters2[i])
				match = false;

		if (match)
			return true;
	}
		

	return false;
}

int main()
{
#if defined(_DEBUG) || defined(_RELEASE)
	freopen("input.txt", "r", stdin); freopen("output.txt", "w", stdout);
#else
	//freopen(File".in", "r", stdin); freopen(File".out", "w", stdout);
#endif

	string s;
	int valid = 0;
	while (getline(cin, s))
	{
		bool isValid = true;

		vector < string> exists;
		stringstream ss;
		ss << s;

		string word;
		while (ss >> word)
		{
			if (checkExistance(exists,word)) {
				isValid = false;
				break;
			}

			exists.push_back(word);

		}

		if (isValid) valid++;
	}

	cout << valid << endl;
	return 0;
}