var input = process.argv[2];

console.log(input);

function leadingZero4(num){
    return ("000" + num).substr(-4);
}

var memory = [];

for (var i=0; i < 128; i++){
    let hash = knotHash(input + "-" + i);
    hash = hash.split("").map(x => leadingZero4(parseInt(x, 16).toString(2)));
    console.log(hash.join(""));
}

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