const fs = require("fs");


var firewalls = [];
var input = fs.readFileSync('input.dat', 'utf-8').split('\n').map(val => {
    firewalls[parseInt(val.split(': ')[0])] = {
        position: 0,
        dir: "D",
        range: parseInt(val.split(': ')[1])
    }
});

var score = 0;


for (var i=0; i < firewalls.length; i++){
    if (firewalls[i] && firewalls[i].position == 0){
        score += i * firewalls[i].range;
    }
}

console.log(score);