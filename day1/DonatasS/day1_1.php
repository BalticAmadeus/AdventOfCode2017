<?php

    $input = file_get_contents("input.txt");
    $numbers = str_split($input);
    $numbersCount = count($numbers) - 1;
    $sum = 0;

    for($i = 0; $i < $numbersCount; $i++){
        if($i+1 <  $numbersCount){
            if($numbers[$i] === $numbers[$i+1]){
                echo "number[$i]: " . $numbers[$i] . ', number[i+1]: ' . $numbers[$i+1] . '<br/>';
                $sum += (int)$numbers[$i];
            }
            elseif ($i === 0  && $numbers[$i] === $numbers[$numbersCount]){
                echo "number[$i]: " . $numbers[$i] . ', number[last]: ' . $numbers[$numbersCount] . '<br/>';
                $sum += (int)$numbers[$i];
            }
        }
    }
    echo "<pre>", var_dump($sum), "</pre>"; exit;