<?php
$input = file_get_contents('input.txt');

$totals = $weights = $data = [];

// prepare data
$rows = explode("\n", $input);

foreach ($rows as $row) {
    $parts = explode('->', $row);
    list($name, $weight) = explode(' ', trim($parts[0]));

    $children = [];
    if (!empty($parts[1])) {
        $children = explode(', ', trim($parts[1]));
        $data[$name] = $children;
    }
    $weights[$name] = trim($weight, '()');
}

$start = getStart($data);

countTotals($start);
list($overweight, $parent) = findAnomalies($start, '');
$level = getLevelValues($parent);
$weight = $weights[$overweight] - (max($level) - min($level));

echo $weight . PHP_EOL;

function getStart($data)
{
    while (count($data) > 1) {
        foreach ($data as $name => $children) {
            foreach ($children as $k => $child) {
                if (!isset($data[$child])) {
                    unset($data[$name][$k]);
                }
            }
            if (empty($data[$name])) {
                unset($data[$name]);
            }
        }
    }
    return reset(array_keys($data));
}

function countTotals($name)
{

    global $data, $totals, $weights;

    $total = 0;
    if (!empty($data[$name])) {
        foreach ($data[$name] as $child) {
            $total += countTotals($child);
        }
        $totals[$name] = $total + $weights[$name];
        return $totals[$name];
    } else {

        return $weights[$name];
    }
}


function getLevelValues($start)
{
    global $data, $totals;

    $values = [];
    foreach ($data[$start] as $child) {
        $values[$child] = $totals[$child];
    }
    return $values;
}


function findAnomalies($start, $parent)
{
    global $data;

    if (!empty($data[$start])) {
        $values = getLevelValues($start);

        // asume it's overweight :)
        $max = (array_keys($values, max($values)));
        if (count($max) == 1) {

            return findAnomalies(reset($max), $start);
        }
    }

    return [$start, $parent];
}

