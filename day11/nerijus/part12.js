const fs = require("fs");

var input = fs.readFileSync('input.dat', 'utf-8').split(',');

var x = 0;
var y = 0;
var max = 0;
var dist = 0;

input.forEach(dir => {
    if (dir == 'n'){
        x++;
    } else if (dir == 'ne'){
        y++;
    } else if (dir == 'se'){
        x--;
        y++;
    } else if (dir == 's'){
        x--;
    } else if (dir == 'sw'){
        y--;
    } else if (dir == 'nw'){
        x++;
        y--;
    }
    dist = Math.max(Math.abs(x), Math.abs(y), Math.abs(-x-y));
    max = Math.max(max, dist);
});

console.log(dist, max);