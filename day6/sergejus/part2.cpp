#include <iostream>
#include <algorithm>
#include <vector>

using namespace std;
 
const int N = 16;

int getMaxIndex(int arr[]){
    return max_element(arr, arr + N) - arr;
}

int main() {
    vector<vector<int>> oldBlocks;
    vector<int> temp;
	int redList[N] = {};
	int list[N] = {};

	int steps=0;
	int currInd = 0;
	int maxVal = 0;
 
	for (int i = 0; i < N; i++){
		cin >> list[i];
	}
	
	copy(begin(list), end(list), begin(redList));
	
	while(find(oldBlocks.begin(), oldBlocks.end(), temp) == oldBlocks.end()){
        oldBlocks.push_back(temp);
        
	    currInd = getMaxIndex(redList);
	    maxVal = redList[currInd];
	    redList[currInd] = 0;
	    
	    while (maxVal > 0){
	        ++currInd;
	        
	        if (currInd == N)
	            currInd = 0;
	        
	        ++redList[currInd];
	        --maxVal;
        }
	    temp.clear();
	    for (int i=0; i<N; i++)
	        temp.push_back(redList[i]);
	    ++steps;
	}
 
     auto it = find(oldBlocks.begin(), oldBlocks.end(), temp);
 
    cout<<"index"<< distance(oldBlocks.begin(), it) <<endl;
	cout << "steps:" << steps;
    
    cout<<"answer:"<< steps - distance(oldBlocks.begin(), it);
	return 0;
}