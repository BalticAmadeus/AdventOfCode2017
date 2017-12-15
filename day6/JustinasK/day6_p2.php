<?php
$input = '0	5	10	0	11	14	13	4	11	8	8	7	1	4	12	11';

$banks = explode("\t", $input);
$cache = [];
$total = count($banks) - 1;
$i = 0;

while (!in_array(implode('|', $banks), $cache)) {
    $cache[] = implode('|', $banks);
    $key = reset(array_keys($banks, max($banks)));
    $value = $banks[$key];
    $banks[$key] = 0;

    while ($value > 0) {
        $key++;
        if ($key > $total) {
            $key = 0;
        }
        $banks[$key]++;
        $value--;
    }

    $i++;
}

$key = implode('|', $banks);
$found = false;
$i = 0;
while (!$found || empty($cache)) {

    $last = array_pop($cache);
    if ($last == $key) {

        $found = true;
    }
    $i++;
}
echo $i;
