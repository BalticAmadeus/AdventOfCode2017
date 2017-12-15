const fs = require("fs");

var input = fs.readFileSync('input.dat', 'utf-8').split(",").map(x=> parseInt(x));
var listLength = process.argv[2];

var list = [];

for (var i=0; i< listLength; i++){
    list.push(i);
}

var pos = 0;
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
    pos = (pos + input[i] + i) % listLength;
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


console.log(list[0] * list[1]);