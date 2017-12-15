const fs = require("fs");


var connections = {};
var input = fs.readFileSync('input.dat', 'utf-8').split('\n').map(val => {
    var digits = val.match(/\d+/g);
    connections[digits[0]] = digits.slice(1);
});

var catche = [];
var groups = 0;

function travel(conn){
    if (catche.indexOf(parseInt(conn)) >= 0){
        return;
    }

    catche.push(parseInt(conn));

    connections[conn].forEach(element => {
        travel(element);
    });
}

for (var conn in connections){
    if (catche.indexOf(parseInt(conn)) < 0){
        groups ++;
        travel(conn);
    }
}

console.log(catche.length, groups);