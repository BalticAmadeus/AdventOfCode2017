<?php

$input = file_get_contents('input.txt');

$input = preg_replace('/!./U', '', $input );
$input = preg_replace( '/<.*>/U', '', $input);

$cnt = 0; $value = 1;
for( $i = 0; $i < strlen( $input ); $i++ ) {
    if( $input[$i] == '{' ) $cnt += $value++;
    if( $input[$i] == '}' ) $value--;
}

echo $cnt . PHP_EOL ;
