<?php
$input = '88,88,211,106,141,1,78,254,2,111,77,255,90,0,54,205';
$lengths = explode(',', $input);
$data = array_keys(array_fill( 0, 256, ''));
$skip = 0; $pos = 0;

$total = count( $data);

foreach( $lengths as $length ){

    if(  ( $pos + $length ) >= $total ) {
        $sub = array_merge(array_slice( $data, $pos ), array_slice($data, 0, $pos+$length - $total));
    } else {
        $sub = array_slice( $data, $pos, $length);
    }

    $sub = array_reverse( $sub );

    $i = 0;
    foreach( $sub as $nr ){
        $new = $pos + $i;
        if( $new >= $total ) $new -= $total;
        $data[$new] = $nr;
        $i++;
    }

    $pos += $length + $skip;
    if( $pos >= $total){
        $pos -= $total;
    }
    $skip ++;

}

echo $data[0] * $data [1];