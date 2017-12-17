var mem = 0, 
    pos = 0, 
    length = 50000000,
    steps = parseInt(process.argv[2]); //Parse the number!!!!!

for (let i = 0; i < length; i++){
    pos = (pos + steps) % (i + 1);

    if (++pos == 1){
        mem = i + 1;
    } 
}

console.log(mem);