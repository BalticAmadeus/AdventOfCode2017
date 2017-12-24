const fs = require('fs');

var parts = fs.readFileSync('input.dat', 'utf-8').split('\n').map(x => {
    return {
        left: Number(x.split('/')[0]),
        right: Number(x.split('/')[1]),
        used: false
    }
});

let max = 0;
let maxLength = 0;
let longest = 0;

addPart(0, 0, 0);

console.log("MAX", max);
console.log("LONGEST", longest);

function addPart(strength, num, depth){
    let parts = getPossibleParts(num);

    if (depth >= longest){
        if (longest != depth){
            max = 0;
        }
        longest = depth;
        max = Math.max(max, strength);
    }

    parts.forEach(part => {
        let curStrength = strength + part.left + part.right;
        part.used = true;

        if (part.left === num){
            addPart(curStrength, part.right, depth+1);
        } else {
            addPart(curStrength, part.left, depth+1);
        }
        part.used = false;
    });
}


function getPossibleParts(num){
    return parts.filter(x => !x.used).filter(x => {
        return x.left == num || x.right == num;
    });
}
