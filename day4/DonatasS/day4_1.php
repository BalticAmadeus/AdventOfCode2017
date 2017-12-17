<?php

    function isKeyphraseValid($keyphrase){
        $keyphrase = explode(" ", $keyphrase);
        for($i = 0; $i < count($keyphrase); $i++){
            for($j = $i; $j < count($keyphrase); $j++){
                if($i !== $j && $keyphrase[$i] === $keyphrase[$j]){
                    return 0;
                }
            }
        }
        return 1;
    }

    $input = file_get_contents("input.txt");
    $rows = explode("\n", $input);
    $valid = 0;
    foreach ($rows as $key => $row){
        $valid += isKeyphraseValid($row);
    }


    echo "<pre>", var_dump($valid), "</pre>"; exit;
