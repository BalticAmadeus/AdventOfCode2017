const fs = require('fs');


var regs = {};

var instructions = fs.readFileSync('input.dat', 'utf-8').split("\n").map(x => {
    regs[x.split(' ')[1]] = 0;

    if (match = x.match(/set (\w+) (-?\w+)/)){
        return {
            inst: 'set',
            reg1: match[1],
            reg2: match[2]
        };
    } else if (match = x.match(/mul (\w+) (-?\w+)/)){
        return {
            inst: 'mul',
            reg1: match[1],
            reg2: match[2]
        };
    } else if (match = x.match(/add (\w+) (-?\w+)/)){
        return {
            inst: 'add',
            reg1: match[1],
            reg2: match[2]
        };
    } else if (match = x.match(/jgz (\w+) (-?\w+)/)){
        return {
            inst: 'jgz',
            reg1: match[1],
            reg2: match[2]
        };
    } else if (match = x.match(/rcv (\w+)/)){
        return {
            inst: 'rcv',
            reg1: match[1],
            reg2: null
        };
    } else if (match = x.match(/mod (\w+) (-?\w+)/)){
        return {
            inst: 'mod',
            reg1: match[1],
            reg2: match[2]
        };
    } else if (match = x.match(/snd (\w+)/)){
        return {
            inst: 'snd',
            reg1: match[1],
            reg2: null
        };
    }
});


var i = 0;
var recover = null;
var sound = null;

main:{
    while(i < instructions.length){
        let ins = instructions[i];
        let delta = 1;
        
        switch (ins.inst) {
            case 'snd': 
                sound = getVal(ins.reg1);
                break;
            case 'mod':
                regs[ins.reg1] = getVal(ins.reg1) % getVal(ins.reg2);
                break;
            case 'set':
                regs[ins.reg1] = getVal(ins.reg2);
                break;
            case 'add':
                regs[ins.reg1] = getVal(ins.reg1) + getVal(ins.reg2);
                break;
            case 'mul':
                regs[ins.reg1] = getVal(ins.reg1) * getVal(ins.reg2);
                break;
            case 'jgz':
                if (getVal(ins.reg1) > 0){
                    delta = getVal(ins.reg2);
                }
                break;
            case 'rcv':
                if (getVal(ins.reg1) > 0){
                    console.log("rcv", sound);
                    break main;
                }
                break;
        }
    
        i += delta;
    }
}
function getVal(reg){
    if (isNaN(reg)){
        return regs[reg];
    } else {
        return parseInt(reg);
    }
}