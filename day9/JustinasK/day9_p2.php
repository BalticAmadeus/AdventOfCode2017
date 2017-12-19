<?php

$input = file_get_contents('input.txt');

$input = preg_replace('/!./U', '', $input);
$input = preg_match_all('/<.*>/U', $input, $matches);
$garbage = 0;

foreach ($matches[0] as $match) {

    $match = substr($match, 1, -1);
    $garbage += strlen($match);
}

echo $garbage . PHP_EOL;