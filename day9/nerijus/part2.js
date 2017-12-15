const fs = require("fs");

var input = fs.readFileSync('input.dat', 'utf-8');

var garbage = false;
var gScore = 0;
var score = 0;
var depth = 0;

for (let i = 0; i < input.length; i++){
    var char = input[i];
    if (char == '!'){
        i++;//skip next char, so it does not hit falowing expression
    } else if (char == ">") {
        garbage = false; //garbage end, negtion will be scipped
    } else if (garbage) { //do not allow another options
        gScore++;
    } else if (char == "<"){
        garbage = true; //garbage start 
    } else if (char == "{") {
        depth++;
        score+= depth;
    } else if (char == "}") {
        depth--;
    }

    //ignore ','
}

console.log(score, gScore);