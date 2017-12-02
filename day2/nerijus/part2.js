var fs = require("fs");

var input = fs.readFileSync("input.dat", "utf-8");

var checksum = 0;

var lines = input.split("\n");

for (var i = 0; i < lines.length; i++){
    checksum += getLineCheck(lines[i].split("\t").map(x => parseInt(x)));
}

console.log(checksum);

function getLineCheck(line){
    for (var  j = 0; j < line.length - 1; j++){
        for (var k = j + 1; k < line.length; k++){
            if ((line[j] / line[k]) % 1 == 0){
                return line[j] / line[k];
            } else if ((line[k] / line[j]) % 1 == 0){
                return line[k] / line[j];
            }
        }
    }
    return 0;
}
