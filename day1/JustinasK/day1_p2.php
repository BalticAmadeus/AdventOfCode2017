<?php

$input = file_get_contents('input.txt');

$sum = 0;
for( $i = 0, $c = strlen($input) ; $i<$c; $i++){
  $pos = $i + $c/2;
  if( $pos >= $c) $pos -= $c;
  if( $input[$i] ===  $input[$pos] ){
      $sum += $input[$i];
    }
}

echo $sum;
