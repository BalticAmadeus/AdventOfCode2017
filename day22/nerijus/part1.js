const fs = require('fs');

let map = {};
let size = fs.readFileSync('input.dat', 'utf-8').split('\n').map((row, i) => {
    row.split('').map((cell, j) => {
        map[i + "_" + j] = cell == '#';
    })
}).length;

let steps = process.argv[2];

let dir = [-1, 0];
let pos = [Math.floor(size/2), Math.floor(size/2)];

let infections = 0;

for (let i=0; i<steps;i++){

    if (getPos(pos) === true){
        clean(pos);
        //right
        if (dir[0] === -1 && dir[1] === 0){
            dir = [0, 1];
        } else if (dir[0] === 1 && dir[1] === 0){
            dir = [0, -1];
        } else if (dir[0] === 0 && dir[1] === -1){
            dir = [-1, 0];
        } else if (dir[0] === 0 && dir[1] === 1){
            dir = [1, 0];
        }
    } else {
        setVirus(pos);
        infections++;
        //left
        if (dir[0] === -1 && dir[1] === 0){
            dir = [0, -1];
        } else if (dir[0] === 1 && dir[1] === 0){
            dir = [0, 1];
        } else if (dir[0] === 0 && dir[1] === -1){
            dir = [1, 0];
        } else if (dir[0] === 0 && dir[1] === 1){
            dir = [-1, 0];
        }
    }

    pos = [pos[0] + dir[0], pos[1] + dir[1]];
}

console.log(infections);

function getPos(pos){
    return map[pos[0] + "_" + pos[1]];
}

function setVirus(pos){
    map[pos[0] + "_" + pos[1]] = true;
}

function clean(pos){
    map[pos[0] + "_" + pos[1]] = false;
}
