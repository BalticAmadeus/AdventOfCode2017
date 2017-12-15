var gen1 = process.argv[2];
var gen2 = process.argv[3];

var factor1 = 16807;
var factor2 = 48271;

var magicNumber = 2147483647;

console.log(gen1, gen2);

var score = 0;

for (var i=0; i < 40000000; i++){
    gen1 = getNext(gen1, factor1);
    gen2 = getNext(gen2, factor2);
    if ((gen1 & 0xFFFF) == (gen2 & 0xFFFF)){
        score++;
    }
}

function getNext(gen, factor){
    return (gen * factor) % magicNumber;
}

console.log(score);