var fs = require("fs");

var input = fs.readFileSync("input.dat", "utf-8");

var lines = input.split("\n");

var sum = 0;
lines.forEach(function(line){
    line = line.split(" ");
    let words = [];
    line.forEach(function(word){
        word = word.split("").sort().join("");
        if (words.indexOf(word) === -1){
            words.push(word);
        }
    });

    sum += line.length == words.length ? 1 : 0;
});

console.log(sum);