var  input = process.argv[2];

console.log(input);

var sqrt = Math.sqrt(input);
var round = Math.round(sqrt);
var short = Math.max(Math.floor(sqrt), round);
var long = Math.ceil(sqrt);

var maxNumber = short * long;
var awayFromMax = maxNumber - input;

console.log(`plygon is ${short} x ${long}, im in ${round}`);
console.log(`max memory cell is ${maxNumber}`);
console.log(`location ${awayFromMax} is away from max`);

var centerPos = {
    y: null,
    x: null
};

var memPos = {
    x: null,
    y: null
};

//find center location
if (short == long){
    if (long % 2 == 0){
        centerPos.y = Math.floor(long / 2) + 1;
    }
    if (long % 2 == 1){
        centerPos.y = Math.ceil(long / 2);
    }
    centerPos.x = Math.ceil(short / 2);
} else {
    centerPos.y = Math.ceil(long / 2);
    centerPos.x = Math.ceil(long / 2);
}

if (short == long){
    //South
    if (long % 2 == 1){
        memPos.x = long - awayFromMax;
        memPos.y = long;
    }
    //West
    if (long % 2 == 0){
        memPos.x = awayFromMax + 1;
        memPos.y = 1;
    }
} else {
    if (long % 2 == 1){
        memPos.x = 1;
        memPos.y = short - awayFromMax;
    }
    if (long % 2 == 0){
        memPos.x = long;
        memPos.y = awayFromMax + 1;
    }
}

console.log(`center is in ${centerPos.x} ${centerPos.y}`);
console.log(`mem    is in ${memPos.x} ${memPos.y}`);

console.log(Math.abs(centerPos.x - memPos.x) + Math.abs(centerPos.y - memPos.y));