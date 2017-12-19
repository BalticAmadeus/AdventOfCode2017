<?php
$input = file_get_contents("input.txt");
$garbage = false;
$score = 0;
$depth = 0;

for($i = 0; $i < strlen($input); $i++){
    if($input[$i] == '!'){
        $i++;
        continue;
    }
    if($input[$i] == '{' && !$garbage){
        $depth++;
        $score += $depth;
    }
    if($input[$i] == '}' && !$garbage){
        $depth--;
    }
    if($input[$i] == '<'){
        $garbage = true;
    }
    if($input[$i] == '>'){
        $garbage = false;
    }
}
echo $score; exit;