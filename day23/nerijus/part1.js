const fs = require('fs');


var regs = {
    a: 0,
    b: 0,
    c: 0,
    d: 0,
    e: 0,
    f: 0,
    g: 0,
    h: 0
};

var instructions = fs.readFileSync('input.dat', 'utf-8').split("\n").map(x => {
    let ins = x.split(' ');
    return {
        inst: ins[0],
        reg1: ins[1],
        reg2: ins[2]
    };
});

let i = 0;
let answer = 0;
let steps = 0;

while(i < instructions.length){
    let ins = instructions[i];
    let delta = 1;
    
    switch (ins.inst) {
        case 'set':
            regs[ins.reg1] = getVal(ins.reg2);
            break;
        case 'sub': 
            regs[ins.reg1] = getVal(ins.reg1) - getVal(ins.reg2);
            break;
        case 'mul':
            regs[ins.reg1] = getVal(ins.reg1) * getVal(ins.reg2);
            answer++;
            break;
        case 'jnz':
            if (getVal(ins.reg1) != 0){
                delta = getVal(ins.reg2);
            }
            break;
    }

    i += delta;
    steps++;
}

console.log(steps, answer);

function getVal(reg){
    if (isNaN(reg)){
        return regs[reg];
    } else {
        return parseInt(reg);
    }
}