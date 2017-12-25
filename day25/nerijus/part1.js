const fs = require('fs');

let input = fs.readFileSync('input.dat', 'utf-8');

let state = input.split('\n')[0].substr(15, 1);
let steps = input.split('\n')[1].match(/\d+/)[0];

let states = {};

input.split('\n').slice(3).join('\n').split('In state ').map((state, j) => {
    if (j === 0){
        return;
    }

    let stateName = state.split(':')[0];

    let instruction = {};

    state.split('If the current value is ').map((x, i) => {
        if (i === 0){
            return;
        }
        let lines = x.split('\n');
        instruction[x.split(':')[0]] = {
            val: lines[1].match(/(\w+)\.$/)[1],
            dir: lines[2].match(/(\w+)\.$/)[1],
            state: lines[3].match(/(\w+)\.$/)[1],
        }
    });

    states[stateName] = instruction;
});

let tape = {};
let cursor = 0;


for (let step = 0; step < steps; step++){
    if (typeof tape[cursor] === 'undefined'){
        tape[cursor] = '0';
    }

    let cur = tape[cursor];

    tape[cursor] = states[state][cur].val;
    cursor += states[state][cur].dir == 'right' ? 1 : -1;
    state = states[state][cur].state;
}

let checksum = 0;

for(let x in tape) {
    checksum += tape[x] === '1' ? 1 : 0;
}

console.log(checksum);