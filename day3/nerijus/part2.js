var  input = process.argv[2];

var sqrt = Math.sqrt(input);
var round = Math.round(sqrt);
var short = Math.max(Math.floor(sqrt), round);
var long = Math.ceil(sqrt);

var memory = [];

memory[1] = 1;

for (var i = 2; i <= input; i++){
    let info = getInfo(i);
    let myPos = getPos(i);

    let val = 0;
    let perimetras = getPerimeter(info);

    let its = 0;

    for (var j = i - 1; j > 0 && its < 5; j--){
        val += getVal(i, j);
    }

    memory.push(val);
    console.log(i, val);
    if (val > input){
        return;
    }
}


function getPerimeter(info){
    if (info.short < 2){
        return info.long;
    } else {
        return ((info.long - 1) * 2 + info.short * 2) - 4
    }
}

function getVal(index1, index2){
    //console.log("dist", index, getPos(index), getDist(pos, getPos(index)));
    if (index2 < 1){
        return 0;
    }

    //console.log(index, pos, getPos(index));

    if (getDist(index1, index2) > 1){
        return 0;
    }

    var ret = memory[index2];

    if (typeof ret !== 'undefined'){
        return ret;
    } else {
        return 0;
    }
}

function getInfo(pos){
    var sqrt = Math.sqrt(pos);
    var round = Math.round(sqrt);
    var short = Math.max(Math.floor(sqrt), round);
    var long = Math.ceil(sqrt);
    
    var maxNumber = short * long;
    var awayFromMax = maxNumber - pos;

    return {
        short: short,
        long: long
    };
}

function getPos(index){
    var sqrt = Math.sqrt(index);
    var round = Math.round(sqrt);
    var short = Math.max(Math.floor(sqrt), round);
    var long = Math.ceil(sqrt);
    
    var maxNumber = short * long;
    var awayFromMax = maxNumber - index;

    var memPos = {
        x: null,
        y: null
    };

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

    return memPos;
}

function getDist(index1, index2){
    var pos1 = getDistToCenter(index1);
    var pos2 = getDistToCenter(index2);
    return Math.max(Math.abs(pos1.x - pos2.x), Math.abs(pos1.y - pos2.y));
}

function getDistToCenter(input){
    var sqrt = Math.sqrt(input);
    var round = Math.round(sqrt);
    var short = Math.max(Math.floor(sqrt), round);
    var long = Math.ceil(sqrt);
    
    var maxNumber = short * long;
    var awayFromMax = maxNumber - input;
    var centerPos = {
        x: null,
        y: null
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

    return {
        x: centerPos.x - memPos.x,
        y: centerPos.y - memPos.y
    };
}