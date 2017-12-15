<?php

$input = file_get_contents('input.txt');

$sum = 0;
for ($i = 1, $c = strlen($input); $i < $c; $i++) {
    if ($input[$i - 1] === $input[$i]) {
        $sum += $input[$i];
    }
}

if ($input[0] == $input[$c - 1]) {
    $sum += $input[0];
}

echo $sum;
