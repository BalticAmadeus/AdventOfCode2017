var fs = require("fs");

var input = fs.readFileSync("input.dat", "utf-8");

var lines = input.split("\n").map(x => parseInt(x));
var length = lines.length;
var num = 0;
var i = 0;
while (i >= 0 && i < length){
    let val = lines[i];
    if (val >= 3){
        lines[i]--;
    } else {
        lines[i]++;
    }
    i = i + val;
    num++;
}

console.log(num);
