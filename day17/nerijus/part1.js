var mem = [0], 
    pos = 0, 
    length = 2017,
    steps = parseInt(process.argv[2]); //Parse the number!!!!!

for (let i = 0; i < length; i++){
    pos = (pos + steps) % (i + 1);
    mem.splice(++pos, 0, i + 1);
}

console.log(mem[pos + 1]);