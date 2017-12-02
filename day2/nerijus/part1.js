var fs = require("fs");

var input = fs.readFileSync("input.dat", "utf-8");

var checksum = 0;

var lines = input.split("\n");

for (var i = 0; i < lines.length; i++){
    let line = lines[i].split("\t").map(x => parseInt(x));

    let min = Math.min.apply(null, line),
        max = Math.max.apply(null, line);
    checksum += Math.abs(min - max);
}

console.log(checksum);
