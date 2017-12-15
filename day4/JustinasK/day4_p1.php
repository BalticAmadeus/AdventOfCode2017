<?php

$input = file_get_contents('input.txt');
$rows = explode("\n", $input);
$count = 0;

foreach ($rows as $row) {

    $row = explode(' ', $row);
    $row2 = array_unique($row);
    if (count($row) == count($row2)) {
        $count++;
    }
}

echo $count;
