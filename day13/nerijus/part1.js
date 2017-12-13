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
    console.log(firewalls[4]);
    if (firewalls[i] && firewalls[i].position == 0){
        score += i * firewalls[i].range;
    }

    for (var j=0; j < firewalls.length; j++){
        if (firewalls[j]){
            if (firewalls[j].dir == "D"){
                firewalls[j].dir = firewalls[j].range == firewalls[j].position + 1 ? "U" : "D";
                firewalls[j].position += firewalls[j].range == firewalls[j].position + 1 ? -1 : 1;
            } else {
                firewalls[j].dir = firewalls[j].position == 0 ? "D" : "U";
                firewalls[j].position += firewalls[j].position == 0 ? 1 : -1;
            }
        }
    }
}

console.log(score);