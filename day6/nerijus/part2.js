const fs = require("fs");

var input = fs.readFileSync('input.dat', 'utf-8').split("\t").map(x => parseInt(x));

var copy = input.slice(0);

var steps = 0;
var length = input.length;


var history = {};
history[input.join("_")] = 0;

while (true){
    let maxIndex = indexOfMax(input);
    let val = input[maxIndex];
    input[maxIndex] = 0;

    for (var i = 1; i <= val; i++){
        //console.log(i, maxIndex, length);
        if (maxIndex + i >= length){
            //console.log("this", maxIndex + i - length);
            if (maxIndex + i - length >= length){
                input[maxIndex + i - length - length]++;
            } else {
                input[maxIndex + i - length]++;
            
            }
        } else {
            input[maxIndex + i]++;
        }
    }

    steps++;
    if (typeof history[input.join("_")] != 'undefined'){
        break;
    }
    history[input.join("_")] = steps;
}

console.log(steps - history[input.join("_")]);

function indexOfMax(arr) {
    if (arr.length === 0) {
        return -1;
    }

    var max = arr[0];
    var maxIndex = 0;

    for (var i = 1; i < arr.length; i++) {
        if (arr[i] > max) {
            maxIndex = i;
            max = arr[i];
        }
    }

    return maxIndex;
}