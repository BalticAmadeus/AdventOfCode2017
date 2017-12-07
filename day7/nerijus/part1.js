const fs = require("fs");

var nodes = {};

var input = fs.readFileSync('input.dat', 'utf-8').split("\n").map(x => {
    var top = x.split(' -> ');
    var children = [];
    if (typeof top[1] !== 'undefined'){
        top[1].split(", ").map(y => {
            children.push(y);
        });
    }

    nodes[x.split(" ")[0]] = {
        weight: x.match(/\((\d.)\)/)[1],
        children: children
    };

    return x.split(" ")[0];
});

console.log(input);
