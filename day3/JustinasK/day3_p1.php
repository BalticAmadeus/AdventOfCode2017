<?php

$number = 325489;
$iteration = 0;
$sum = 1;

while ($sum <= $number) {
    $sum += (3 + ($iteration * 2)) * 2 + (1 + ($iteration * 2)) * 2;
    $iteration++;
}

$iteration--;
$line = 3 + $iteration * 2 - 1;
$left_bottom_corner = $sum - $line;

if ($lft_bottom_corner <= $number && $number <= $sum) {

    $middle = $sum - ($sum - $left_bottom_corner) / 2;
    $to_middle = abs($number - $middle);
    $total = $iteration + $to_middle + 1;
}

echo $total;
