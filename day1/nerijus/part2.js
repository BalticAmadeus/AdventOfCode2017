var fs = require("fs");

var input = fs.readFileSync('input2.dat', 'utf-8');

var step = input.length / 2;
var length = input.length;

input = input + input;

var sum = 0;

for (var i=0; i < length; i++){
    sum+=parseInt(input.charAt(i)) == parseInt(input.charAt(i + step)) ? parseInt(input.charAt(i)) : 0;
}

console.log(sum);