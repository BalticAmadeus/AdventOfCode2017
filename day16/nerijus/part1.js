const fs = require('fs');

var abc = "abcdefghijklmnopqrstuvwxyz";

var seq = abc.split("").slice(0, process.argv[2]);

console.log(seq.join(""));

fs.readFileSync('input.dat', 'utf-8').split(',').map(x => {
    let match = null;
    if (match = x.match(/s(\d+)/)){
        seq = [...seq.slice(-match[1]), ...seq.slice(0, seq.length - match[1])];
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
});

console.log(seq.join(""));