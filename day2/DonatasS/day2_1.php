<?php

    $input = file_get_contents("input.txt");
    $rows = explode("\n", $input);
    $checksum = 0;
    foreach ($rows as $key => $row){
        $rows[$key] = explode("	", $row);
        $min = 0;
        $max = 0;
        $min = min($rows[$key]);
        $max = max($rows[$key]);
        $checksum += ((int)$max - (int)$min);
    }

    echo "<pre>", var_dump($checksum), "</pre>"; exit;
