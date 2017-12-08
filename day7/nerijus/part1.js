const fs = require("fs");

var children = [];

var input = fs.readFileSync('input.dat', 'utf-8').split("\n").map(x => {
    var top = x.split(' -> ');
    if (typeof top[1] !== 'undefined'){
        top[1].split(", ").map(y => {
            children.push(y);
        });
    }
    return x.split(" ")[0];
}).filter(x => children.indexOf(x) === -1);


console.log(input[0]);
