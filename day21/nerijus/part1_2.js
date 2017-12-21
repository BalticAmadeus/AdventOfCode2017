const fs = require('fs');

const iterations = process.argv[2];

var map = [];

console.time('main');

fs.readFileSync('input.dat', 'utf-8').split('\n').map(val => {
    val = val.split(' => ');

    let arr = val[0].split('/').map(row => row.split(''));

    for (let i = 0; i < 4; i++){ //rotate 4 times!
        rotate(arr);
        map[serialize(arr)] = val[1]; //rotated
        map[serialize(arr.reverse())] = val[1]; //rotated flip rows
        map[serialize(arr.map(row => row.reverse()))] = val[1]; //rotated flip cols
    }
});

var matrix = [
    ['.', '#', '.'],
    ['.', '.', '#'],
    ['#', '#', '#']
];

for (var i = 0; i < iterations; i++){
    let length = matrix.length;
    let size = length % 2 === 0 ? 2 : 3;
    let newSize = (size + 1) * (length / size);
    let newBlockSize = size + 1;

    let newMatrix = new Array(newSize).fill([]).map(x => new Array(newSize).fill('.'));

    for (var j = 0; j < length; j+=size){
        for (var k = 0; k < length; k+=size){
            map[serialize(matrix.slice(j, j+size).map(row => row.slice(k, k+size)))].split('/').map((row, rowNum) => {
                row.split('').map((element, colNum) => {
                    newMatrix[(j / size * newBlockSize) + rowNum][(k / size * newBlockSize) + colNum] = element;
                });
            });
        }
    }

    matrix = newMatrix;
}

var answer = 0;

matrix.map(x => x.map(y => {
    answer += y === "#" ? 1 : 0;
}))

console.log(answer);
console.timeEnd('main');


function serialize(arr){
    return arr.map(row => row.join('')).join('/');
}

function rotate(matrix) {
    matrix = matrix.reverse();
    for (var i = 0; i < matrix.length; i++) {
        for (var j = 0; j < i; j++) {
            var temp = matrix[i][j];
            matrix[i][j] = matrix[j][i];
            matrix[j][i] = temp;
        }
    }
}