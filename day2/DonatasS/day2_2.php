<?php

    $input = file_get_contents("input.txt");
    $rows = explode("\n", $input);
    $divisionSum = 0;
    foreach ($rows as $key => $row){
        $rows[$key] = explode("	", $row);
        foreach ($rows[$key] as $first){
            foreach ($rows[$key] as $second){
                if((int)$first !== (int)$second && (int)$first % (int)$second === 0){
                    $divisionSum += (int)$first / (int)$second;
                    echo "found: " . $first . ", " . $second . " division: " . ($first / $second); //exit;
                }
            }
        }
    }

    echo "<pre>", var_dump($divisionSum), "</pre>"; exit;
