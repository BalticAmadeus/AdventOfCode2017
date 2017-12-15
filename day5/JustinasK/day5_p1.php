<?php
$input = file_get_contents('input.txt');
$instructions = explode("\n", $input);

$pos = 0;
$steps = 0;

while (isset($instructions[$pos])) {
    $next = $instructions[$pos];
    $instructions[$pos]++;
    $pos += $next;
    $steps++;
}

echo $steps;
