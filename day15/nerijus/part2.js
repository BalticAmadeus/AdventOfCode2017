var gen1 = process.argv[2];
var gen2 = process.argv[3];

var factor1 = 16807;
var factor2 = 48271;

var div1 = 4;
var div2 = 8;

var magicNumber = 2147483647;

console.log(gen1, gen2);

var score = 0;

for (var i=0; i < 5000000; i++){
    gen1 = getNext(gen1, factor1, div1);
    gen2 = getNext(gen2, factor2, div2);
    if ((gen1 & 0xFFFF) == (gen2 & 0xFFFF)){
        score++;
    }
}

function getNext(gen, factor, divider){
    var num = (gen * factor) % magicNumber;

    if (num % divider == 0){
        return num;
    } else {
        return getNext(num, factor, divider)
    }
}

console.log(score);