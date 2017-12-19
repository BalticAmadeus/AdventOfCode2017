<?php
$input = file_get_contents("input.txt");
$garbage = false;
$removed = 0;

for($i = 0; $i < strlen($input); $i++){
    if($input[$i] == '!'){
        $i++;
        continue;
    } elseif($input[$i] == '{' && !$garbage){
        continue;
    } elseif($input[$i] == '}' && !$garbage){
        continue;
    } elseif ($input[$i] == '<' && !$garbage){
        $garbage = true;
        continue;
    } elseif($input[$i] == '>' && $garbage){
        $garbage = false;
        continue;
    }
    if($garbage){
        $removed++;
    }
}
echo $removed; exit;