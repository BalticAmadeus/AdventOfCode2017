var r = {
    a: 1,
    b: 93,
    c: 0,
    d: 0,
    e: 0,
    f: 0,
    g: 0,
    h: 0
};

const isPrime = num => {
    for(let i = 2, s = Math.sqrt(num); i <= s; i++)
        if(num % i === 0) return false; 
    return num !== 1;
}

r.b = (r.b * 100) + 100000
r.c = r.b + 17000;
for (let i = r.b; i <= r.c; i += 17) { //from r.b to r.c
    console.log(i);
    if (!isPrime(i)){
        r.h++;
    }
}

console.log(r);
