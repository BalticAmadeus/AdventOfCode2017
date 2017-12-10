const fs = require("fs");

var input = fs.readFileSync('input.dat', 'utf-8').split("").map(x=> x.charCodeAt(0));
var listLength = process.argv[2];

input = [...input, 17, 31, 73, 47, 23];

console.log(input);

var list = [];

for (var i=0; i< listLength; i++){
    list.push(i);
}

var pos = 0;
var skip = 0;
for (var z=0; z < 64; z++){
    for (var i=0; i < input.length; i++){
        // process.stdout.write(input[i] + "|");
        // for (var j = 0; j < list.length; j++){
        //     if (j == pos){
        //         process.stdout.write("[" + list[j] + "]");
        //     } else {
        //         process.stdout.write(" " + list[j] + " ");
        //     }
        // }

        // process.stdout.write("\n");

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

// process.stdout.write(" |");
// for (var j = 0; j < list.length; j++){
//     process.stdout.write(" " + list[j] + " ");
// }
// process.stdout.write("\n");

var hash = [];
var running = 0;

for (var i=0; i < 16; i++){
    hash.push(list.slice(i * 16, i * 16 + 16).reduce((acc, val) => acc ^ val));
}

function leadingZero(num){
    return ("0" + num).substring(-2);
}

hash = hash.map(x => x.toString(16)).join("");

console.log(hash, hash.length);


console.log(list[0] * list[1]);