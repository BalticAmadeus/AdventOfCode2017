const fs = require('fs');

var map = fs.readFileSync('input.dat', 'utf-8').split('\n').map(x => x.split(''));

var pos = [0, map[0].indexOf('|')];
var dir = [1, 0];

var mapHeight = map[0].length;
var mapWidth = map.length;

var path = "";
var steps = 0;

while(true){
    let comp = [pos[0] + dir[0], pos[1] + dir[1]];

    //break if ne position is edge
    if (pos[0] < 0 || pos[0] === mapWidth || pos[1] < 0 || pos[1] === mapHeight){
        console.log("break", pos, comp);
        break;
    }
    
    let cur = map[pos[0]][pos[1]];

    if (cur === ' '){
        break;
    }

    if (cur === '+'){
        let temp = dir.splice();
        if (dir[0] === 0){
            if (pos[0] + 1 < mapWidth && map[pos[0] + 1][pos[1]] !== ' '){
                dir = [1, 0];
            } else if (pos[0] - 1 >= 0 && map[pos[0] - 1][pos[1]]){
                dir = [-1, 0];
            }
        } else {
            if (pos[1] + 1 < mapHeight && map[pos[0]][pos[1] + 1] !== ' '){
                dir = [0, 1];
            } else if (pos[1] - 1 >= 0 && map[pos[0]][pos[1] - 1]){
                dir = [0, -1];
            }
        }
    } else if (cur !== "|" && cur !== '-'){
        path += cur;
    }

    pos = [pos[0] + dir[0], pos[1] + dir[1]];
    steps++;
}

console.log(steps, path);