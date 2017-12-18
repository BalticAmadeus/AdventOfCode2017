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

var instructions = JSON.parse(JSON.stringify(instructions));

var programs = [
{
    step: 0,
    waiting: null,
    regs: JSON.parse(JSON.stringify(regs)),
    sending: [],
    send: 0
}, 
{
    step: 0,
    waiting: null, 
    regs: JSON.parse(JSON.stringify(regs)),
    sending: [],
    send: 0
}];

programs[0].regs.p = 0;
programs[1].regs.p = 1;

var current = 0;

while(
    (programs[0].sending.length > 0 || programs[0].waiting === null) || 
    (programs[1].sending.length > 0 || programs[1].waiting === null)){
    let ins = instructions[programs[current].step];
    let delta = 1;
    let other = current == 1 ? 0 : 1;
    
    if (programs[current].waiting){
        if (programs[other].sending.length > 1){
            programs[current].regs[programs[current].waiting] = programs[other].sending.shift();
            programs[current].waiting = null;
        } else {
            current = current == 1 ? 0 : 1;
        }
    }

    switch (ins.inst) {
        case 'snd': 
            programs[current].sending.push(getVal(programs[current].regs, ins.reg1));
            programs[current].send++;
            break;
        case 'mod':
            programs[current].regs[ins.reg1] = getVal(programs[current].regs, ins.reg1) % getVal(programs[current].regs, ins.reg2);
            break;
        case 'set':
            programs[current].regs[ins.reg1] = getVal(programs[current].regs, ins.reg2);
            break;
        case 'add':
            programs[current].regs[ins.reg1] = getVal(programs[current].regs, ins.reg1) + getVal(programs[current].regs, ins.reg2);
            break;
        case 'mul':
            programs[current].regs[ins.reg1] = getVal(programs[current].regs, ins.reg1) * getVal(programs[current].regs, ins.reg2);
            break;
        case 'jgz':
            if (getVal(programs[current].regs, ins.reg1) > 0){
                delta = getVal(programs[current].regs, ins.reg2);
            }
            break;
        case 'rcv':
            if (programs[other].sending.length > 0){
                programs[current].regs[ins.reg1] = programs[other].sending.shift();
            } else {
                programs[current].waiting = ins.reg1;
                current = current == 1 ? 0 : 1;
            }
            break;
    }

    programs[current].step += delta;
}

console.log(programs[1].send);

function getVal(regs, reg){
    if (isNaN(reg)){
        return regs[reg];
    } else {
        return parseInt(reg);
    }
}