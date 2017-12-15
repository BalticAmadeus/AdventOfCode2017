<?php

$number = 325489;

function map($x, $y)
{

    return [5000 + $x, 5000 + $y];
}

function remap($x, $y)
{

    return [$x - 5000, $y - 5000];
}

function getNb($x, $y)
{
    global $field;

    list($x, $y) = map($x, $y);
    $sum = 0;
    for ($i = $x - 1; $i <= $x + 1; $i++) {
        for ($j = $y - 1; $j <= $y + 1; $j++) {
            $sum += isset($field[$i][$j]) ? $field[$i][$j] : 0;
        }
    }

    return $sum;
}

function setNb($x, $y, $sum)
{

    global $field;
    list($x, $y) = map($x, $y);
    $field[$x][$y] = $sum;
}

function getNextMove($x, $y)
{

    global $field;
    list($x, $y) = map($x, $y);

    $left = !isset($field[$x - 1][$y]);
    $right = !isset($field[$x + 1][$y]);
    $top = !isset($field[$x][$y + 1]);
    $bottom = !isset($field[$x][$y - 1]);

    if ($left && $right && $top && $bottom) {
        $x += 1;
        return remap($x, $y);
    }

    if ($top && !$left) {

        $y += 1;
        return remap($x, $y);
    }

    if ($left && !$bottom) {

        $x -= 1;
        return remap($x, $y);
    }

    if ($bottom && !$right) {

        $y -= 1;
        return remap($x, $y);
    }

    if ($right && !$top) {

        $x += 1;
        return remap($x, $y);

    }
}


$field = [];
$x = $y = 0;
$val = 1;
setNb($x, $y, $val);

$i = 0;
while ($val <= $number) {
    list($x, $y) = getNextMove($x, $y);
    $val = getNb($x, $y);
    setNb($x, $y, $val);
    $i++;
}

echo $val . PHP_EOL;
