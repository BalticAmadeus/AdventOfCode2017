<?php
$input = file_get_contents('input.txt');

$rows = explode("\n", $input);

$sum = 0;
foreach ($rows as $row) {
    $numbers = explode("\t", $row);
    $sum += max($numbers) - min($numbers);
}

echo $sum;
