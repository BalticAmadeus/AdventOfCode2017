const fs = require('fs');

var abc = "abcdefghijklmnopqrstuvwxyz";

var seq = abc.split("").slice(0, process.argv[2]);

console.log(seq.join(""));

var input = fs.readFileSync('input.dat', 'utf-8').split(',').map(x => x);
var inputLength = input.length;

var cache = {};

for (var i = 0; i < 1000000000; i++){
    let before = seq.join('');
    if (cache[before]){
        seq = cache[before].split('');
        continue;
    }

    for (var j=0; j < inputLength; j++){
        let match = null;
        let x = input[j];
    
        if (match = x.match(/s(\d+)/)){
            seq =  seq.slice(-match[1]).concat(seq.slice(0, seq.length - match[1]));
        } else if (match = x.match(/x(\d+)\/(\d+)/)){
            let temp = seq[match[1]];
            seq[match[1]] = seq[match[2]];
            seq[match[2]] = temp;
        } else if (match = x.match(/p(\w)\/(\w)/)){
            let iA = seq.indexOf(match[1]);
            let iB = seq.indexOf(match[2]);
    
            let temp = seq[iA];
            seq[iA] = seq[iB];
            seq[iB] = temp;
        }
        
    }

    let after = seq.join('');

    cache[before] = after;
}


console.log(seq.join(""));