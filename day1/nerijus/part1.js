var fs = require("fs");

var input = fs.readFileSync('input1.dat', 'utf-8');

input = input + input.charAt(0);

var sum = 0;
var length = input.length;

for (var i=0; i < length-1; i++){
    sum+=input.charAt(i) == input.charAt(i + 1) ? parseInt(input.charAt(i)) : 0;
}

console.log(sum);