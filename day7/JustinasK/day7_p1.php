<?php
$input = file_get_contents('input.txt');
$rows = explode("\n", $input);

foreach ($rows as $row) {
    $parts = explode('->', $row);
    $name = reset(explode(' ', trim($parts[0])));
    if (!empty($parts[1])) {
        $children = explode(', ', trim($parts[1]));
        $data[$name] = $children;
    }
}

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
echo reset(array_keys($data));
