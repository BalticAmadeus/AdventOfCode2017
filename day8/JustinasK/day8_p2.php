<?php

$input = file_get_contents(dirname(__FILE__) . '/input.txt');
$instructions = explode("\n", $input);

$data = [];
foreach ($instructions as $instruction) {

    $i = explode(' ', $instruction);

    if (!isset($data[$i[4]])) $data[$i[4]] = 0;

    if (assert($data[$i[4]] . ' ' . $i[5] . ' ' . $i[6])) {

        if (!isset($data[$i[0]])) $data[$i[0]] = 0;

        if ($i[1] == 'inc') {

            $data[$i[0]] += $i[2];
        } else {
            $data[$i[0]] -= $i[2];
        }

        $max = max($max, max($data));
    }
}
echo $max;
