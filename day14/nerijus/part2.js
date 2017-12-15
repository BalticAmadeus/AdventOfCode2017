var input = process.argv[2];

console.log(input);

function leadingZero4(num){
    return ("000" + num).substr(-4);
}

var memory = [];

for (var i=0; i < 128; i++){
    let hash = knotHash(input + "-" + i);
    hash = hash.split("").map(x => leadingZero4(parseInt(x, 16).toString(2)));

    memory.push(hash.join("").split(""));
}

var seen = {};
function check(x, y){
    if (memory[x][y] == 0){
        return;
    }
    if (typeof seen[x + "_" + y] !== 'undefined'){
        return;
    }
    seen[x + "_" + y] = 1;
    if (x > 0){
        check(x - 1, y);
    }
    if (x < 127){
        check(x + 1, y);
    }

    if (y > 0){
        check(x, y - 1);
    }
    if (y < 127){
        check(x, y + 1);
    }
}

var sum = 0;

for (var i=0; i< 128; i++){
    for (var j=0; j< 128; j++){
        if (memory[i][j] == 1 && typeof seen[i + "_" + j] === 'undefined'){
            check(i, j);
            sum++;
        }
    }
}

console.log(sum);

function knotHash(input){
    var input = input.split("").map(x=> x.charCodeAt(0));
    var listLength = 256;

    input = [...input, 17, 31, 73, 47, 23];

    var list = [];

    for (var i=0; i< listLength; i++){
        list.push(i);
    }
    
    var pos = 0;
    var skip = 0;
    for (var z=0; z < 64; z++){
        for (var i=0; i < input.length; i++){
            list = reverse(list, pos, input[i]);
            pos = (pos + input[i] + skip) % listLength;
            skip++;
        }
    }
    
    function reverse(data, start, length){
        if (length <= 1){
            return data;
        }
    
        data = [...data.slice(start), ...data.slice(0, start)];             // move end to start
        data = [...data.slice(0, length).reverse(), ...data.slice(length)]; // reverse the portion from start
        data = [...data.slice(-start), ...data.slice(0, -start)];           // move end back
    
        return data;
    }
    
    var hash = [];
    var running = 0;
    
    for (var i=0; i < 16; i++){
        hash.push(list.slice(i * 16, i * 16 + 16).reduce((acc, val) => acc ^ val));
    }
    
    function leadingZero(num){
        return ("0" + num).substr(-2);
    }

    hash = hash.map(x => leadingZero(x.toString(16))).join("");

    return hash;
}