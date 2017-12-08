const fs = require("fs");

var regs = {};
var globalMax = Math.log(0);

var input = fs.readFileSync('input.dat', 'utf-8').split("\n").map(x => {
    val = x.split(" ");

    regs[val[0]] = 0;

    return {
        reg: val[0],
        oper: val[1],
        logic: val[5],
        left: val[4],
        right: val[6],
        change: val[2]
    };
});

var BreakException = {};

input.forEach(x => {
    eval("regs[x.reg] = regs[x.left] " + x.logic + "  parseInt(x.right) ? oper(x) : regs[x.reg]");
});

function oper(x){
    var ret = x.oper == 'inc' ? regs[x.reg] + parseInt(x.change) : regs[x.reg] - parseInt(x.change);
    globalMax = ret > globalMax ? ret : globalMax;
    return ret;
}

var max = Math.log(0);

for (var reg in regs){
    max = regs[reg] > max ? regs[reg] : max;
}

console.log(max, globalMax);
