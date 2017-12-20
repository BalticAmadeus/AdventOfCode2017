const fs = require('fs');

var particles = fs.readFileSync('input.dat', 'utf-8').split('\n').map(x => {
    //p=<-520,2504,414>, v=<-74,354,60>, a=<-2,-25,-7>
    x = x.split(', ');

    return {
        p: x[0].substr(3,x[0].length-4).split(",").map(y=>Number(y)),
        v: x[1].substr(3,x[1].length-4).split(",").map(y=>Number(y)),
        a: x[2].substr(3,x[2].length-4).split(",").map(y=>Number(y))
    }
});

console.log(particles);

var part = null;


for (let i=0; i < 10000000; i++){
    let minPart = null;
    let min = 999999999999999;
    let positions = [];

    for (let j=0; j < particles.length; j++){
        let p = particles[j];
        if (Math.abs(p.p[0]) + Math.abs(p.p[1]) + Math.abs(p.p[2]) < min){
            min = Math.abs(p.p[0]) + Math.abs(p.p[1]) + Math.abs(p.p[2]);

            minPart = j;
        }

        p.v[0] += p.a[0];
        p.v[1] += p.a[1];
        p.v[2] += p.a[2];

        p.p[0] += p.v[0];
        p.p[1] += p.v[1];
        p.p[2] += p.v[2];

        let pos = p.p.join(',');
        particles.forEach((x, k) => {
            if (j !== k && x.p.join(',') === pos){
                x.kill = true;
                p.kill = true;
            }
        });
    }

    particles = particles.filter(p => {
        return p.kill !== true;
    });

    console.log(i, min, minPart, particles.length);
}