const fs = require("fs");


var firewalls = [];
var input = fs.readFileSync('input.dat', 'utf-8').split('\n').map(val => {
    firewalls[parseInt(val.split(': ')[0])] = {
        position: 0,
        dir: "D",
        range: parseInt(val.split(': ')[1])
    }
});


var caught = true;
var delay = 0;

for (var k=0; caught; k++){
    caught = false;
    for (var i=0; i < firewalls.length; i++){
        if (firewalls[i] && ((i + k) % ((firewalls[i].range - 1) * 2)) == 0){
            caught =true;
        }
    }
    delay = k;
}

console.log(delay);