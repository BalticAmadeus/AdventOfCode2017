<?php
    $input = file_get_contents("input.txt");
    $banks = explode("	", $input);

    $steps = 0;
    $max = 0;
    $endless = false;
    $previousSteps = [];
    $previousSteps[$steps] = implode(',', $banks);
    while (!$endless){
        $max = max($banks);
        $index = array_search($max, $banks);
        $banks[$index] = 0;
        $index++;
        while($max > 0){
            if(isset($banks[$index])){
                $banks[$index]++;
                $index++;
                $max--;
            }
            else{
                $index = 0;
            }
        }
        if(array_search(implode(',', $banks), $previousSteps)){
            $stepsDiff = $steps - array_search(implode(',', $banks), $previousSteps) + 1 ;
            echo $stepsDiff; exit;
        }
        $steps++;
        $previousSteps[$steps] = implode(',', $banks);
    }
