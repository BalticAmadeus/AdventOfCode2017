<?php

$input = file_get_contents('input.txt');
$rows = explode("\n", $input);

$sum = 0;
foreach ($rows as $row) {
    $numbers = explode("\t", $row);
    rsort($numbers);

    for ($i = 0; $i < count($numbers); $i++) {
        for ($j = $i + 1; $j < count($numbers); $j++) {
            $val = $numbers[$i] / $numbers[$j];
            if (is_int($val)) {
                $sum += $val;
                break;
            }
        }
    }
}

echo $sum;
