const fs = require("fs");

var allChildren = [];
var nodes = {};
var parent = "";

var input = fs.readFileSync('input.dat', 'utf-8').split("\n").map(x => {
    var top = x.split(' -> ');
    var children = [];
    if (typeof top[1] !== 'undefined'){
        top[1].split(", ").map(y => {
            children.push(y);
        });
    }

    nodes[x.split(" ")[0]] = {
        weight: parseInt(x.match(/\((\d+)\)/)[1]),
        children: children
    };

    allChildren = allChildren.concat(children);

    return x.split(" ")[0];
});


input.forEach(x => {
    if (allChildren.indexOf(x) < 0){
        parent = x;
    }
});

console.log(parent);
getWeight(parent);

function getWeight(parent){
    var node = nodes[parent];
    var totalW = node.weight;

    var weights = [];

    var children = node.children.map(x => {
        var child = nodes[x];
        child.childW = getWeight(x);
        totalW += child.childW;
        weights.push(child.childW);
        //return child;
    });

    var min = Math.min.apply(null, weights),
        max = Math.max.apply(null, weights);


    if (totalW > 1000){
       // console.log(totalW, weights);
       // console.log(min, max);
    }
    
    if (min < max){
        console.log(parent, min, max, node.weight, weights);

        node.children.map(x => {
            console.log(x, nodes[x]);
        });
    }

    return totalW;
}
