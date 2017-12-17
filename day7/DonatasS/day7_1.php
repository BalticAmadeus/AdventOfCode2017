<?php

$input = file_get_contents("input.txt");
$input = explode("\n", $input);

$towers = [];
$tower = 0;
$rootTower = 0;


foreach ($input as $value){
    $temp = explode(" -> ", $value);

    $temp[0] = substr($temp[0], 0, strpos($temp[0], ' ('));
    $temp[2] = substr($temp[0], strpos($temp[0], ' ('), strpos($temp[0], ')'));
    if(isset($temp[1]) && $temp[1] !== "") {
        $temp[1] = explode(', ', $temp[1]);
    }
    else{
        $temp[1] = [];
    }
    $towers[] = $temp;
}
function findNextRoot($offset, $towers)
{
    while (true) {
        $tower = $offset;
        foreach ($towers as $key => $value) {
            if (isset($towers[$tower]) && array_search($towers[$tower][0], $value[1]) !== false) {
                $offset = $key;
                return $offset;
            } else {
                $offset = 0;
            }
        }
        if ($offset == 0) {
            return 0;
        }
    }
}

while (true){
    $temp = findNextRoot($rootTower, $towers);
    if($temp > 0){
        $rootTower = $temp;
    }
    else{
        echo $towers[$rootTower][0];
        exit;
    }
}