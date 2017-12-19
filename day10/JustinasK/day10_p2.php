<?php
$input = '88,88,211,106,141,1,78,254,2,111,77,255,90,0,54,205';
$data = array_keys(array_fill( 0, 256, ''));
$skip = 0; $pos = 0;

$total = count( $data);

$lengths = [];
for( $i = 0; $i < strlen( $input ); $i++ ){
    $lengths[] = ord($input[$i]);
}

$lengths = array_merge( $lengths, explode(',', '17,31,73,47,23'));

for( $j = 0; $j < 64; $j++ ) {

    foreach ($lengths as $length) {

        if (($pos + $length) >= $total) {
            $sub = array_merge(array_slice($data, $pos), array_slice($data, 0, $pos + $length - $total));
        } else {
            $sub = array_slice($data, $pos, $length);
        }
        $sub = array_reverse($sub);

        $i = 0;
        foreach ($sub as $nr) {
            $new = $pos + $i;
            if ($new >= $total) {
                $new -= $total;
            }
            $data[$new] = $nr;
            $i++;
        }

        $pos += $length + $skip;
        if ($pos >= $total) {
            $pos -= $total * floor( $pos / $total );
        }

        $skip++;
    }

}

$xored = [];
$i = 0;
foreach( $data as $key => $val ) {

    if( $key % 16 == 0 ) {
        $i ++;
    }
    if( empty( $xored[$i])){
        $xored[$i] = (int)$val;
    } else {
        $xored[$i] = $xored[$i] ^ (int)$val;
    }
}

$output = '';
foreach( $xored as $item ) {

    $output .= sprintf('%02x', $item );
}

echo $output . PHP_EOL;
