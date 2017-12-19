<?php

$input = file_get_contents("input.txt");
$input = explode("\n", $input);
$instructions = [];
$allTimeMax = 0;
foreach ($input as $instruction) {
    $vars = explode(' ', $instruction);
    $instructions[$vars[0]] = 0;
    $instructions[$vars[4]] = 0;
}
reset($input);
foreach ($input as $instruction){
    $vars = explode(' ', $instruction);
    switch ($vars[5]){
        case '>':
            if($instructions[$vars[4]] > intval($vars[6])){
                $instructions[$vars[0]] = $vars[1] === 'inc' ? ($instructions[$vars[0]] + intval($vars[2])) : ($instructions[$vars[0]] - intval($vars[2]));
            }
            break;
        case '>=':
            if($instructions[$vars[4]] >= intval($vars[6])){
                $instructions[$vars[0]] = $vars[1] === 'inc' ? ($instructions[$vars[0]] + intval($vars[2])) : ($instructions[$vars[0]] - intval($vars[2]));
            }
            break;
        case '<':
            if($instructions[$vars[4]] < intval($vars[6])){
                $instructions[$vars[0]] = $vars[1] === 'inc' ? ($instructions[$vars[0]] + intval($vars[2])) : ($instructions[$vars[0]] - intval($vars[2]));
            }
            break;
        case '<=':
            if($instructions[$vars[4]] <= intval($vars[6])){
                $instructions[$vars[0]] = $vars[1] === 'inc' ? ($instructions[$vars[0]] + intval($vars[2])) : ($instructions[$vars[0]] - intval($vars[2]));
            }
            break;
        case '!=':
            if($instructions[$vars[4]] != intval($vars[6])){
                $instructions[$vars[0]] = $vars[1] === 'inc' ? ($instructions[$vars[0]] + intval($vars[2])) : ($instructions[$vars[0]] - intval($vars[2]));
            }
            break;
        case '==':
            if($instructions[$vars[4]] == intval($vars[6])){
                $instructions[$vars[0]] = $vars[1] === 'inc' ? ($instructions[$vars[0]] + intval($vars[2])) : ($instructions[$vars[0]] - intval($vars[2]));
            }
            break;
    }
    $temp = max($instructions);
    $allTimeMax = $temp > $allTimeMax ? $temp : $allTimeMax;
}
echo $allTimeMax; exit;