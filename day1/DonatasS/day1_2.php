<?php

    $input = file_get_contents("input.txt");
    $numbers = str_split($input);
    $numbersCount = count($numbers) - 1;
    $numbersHalf = (count($numbers) / 2) - 1;
    $sum = 0;

    for($i = 0; $i <  $numbersHalf+1; $i++){
        if($numbers[$i] === $numbers[$numbersHalf+$i + 1]){
            echo "added number[$i]: " . $numbers[$i] . ", number[" . ($numbersHalf+$i + 1) . "]: " . $numbers[$numbersHalf+$i + 1] . '<br/>';
            $sum += (int)$numbers[$i];
        }
    }

    for($i = $numbersHalf + 1; $i <=  $numbersCount; $i++){
        if($numbers[$i] === $numbers[$i - $numbersHalf - 1]){
            echo "added number[$i]: " . $numbers[$i] . ", number[" . ($i - $numbersHalf - 1) . "]: " . $numbers[$i - $numbersHalf - 1] . '<br/>';
            $sum += (int)$numbers[$i];
        }
    }

    echo "<pre>", var_dump($sum), "</pre>"; exit;