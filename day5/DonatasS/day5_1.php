<?php
    $input = file_get_contents("input.txt");
    $instructions = explode("\n", $input);
    $steps = 0;
    $position = 0;
    $escaped = false;
    while (!$escaped){
        if($steps == 0){
            $jump = $instructions[$position];
            $instructions[$position] = (int)$instructions[$position] + 1;
            $steps++;
        }
        else{
            if(isset($instructions[$position])){
                $temp = (int)$instructions[$position];
                $instructions[$position] = (int)$instructions[$position] + 1;
                $position += $temp;
                $steps++;
            }
            else{
                $escaped = true;
            }
        }
    }
    echo "<pre>", var_dump($steps), "</pre>"; exit;
