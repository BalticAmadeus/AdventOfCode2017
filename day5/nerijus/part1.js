var fs = require("fs");

var input = fs.readFileSync("input.dat", "utf-8");

var lines = input.split("\n").map(x => parseInt(x));
var length = lines.length;
var num = 0;
var i = 0;
while (i < length){
    let lineNum = i;
    i = i + lines[i];
    lines[lineNum]++;
    num++;
}

console.log(num);
