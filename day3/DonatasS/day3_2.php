<?php
    function getSegmentCoordinates()
    {
        $number = 277678;
        $arr[0][0] = 1;
        $xPos = 0;
        $xNeg = 0;
        $yPos = 0;
        $yNeg = 0;
        $ring = 2;
        $direction = 0; //0 - R, 1 - U, 2 - L, 3 - D
        $current = 1;
        while ($current <= $number) {
            switch ($direction) {
                case 0:
                    if ($xNeg == 0) {
                        $xPos++;
                        $current++;
                        $arr[$xPos][$yNeg] = getSquareValue($xPos, $yNeg, $arr);
                        if ($arr[$xPos][$yNeg] >= $number) {
                            return $arr[$xPos][$yNeg];
                        }
                        if ($xPos + 1 == $ring) {
                            $direction = 1;
                        }
                    } else {
                        $xNeg++;
                        $current++;
                        $arr[$xNeg][$yNeg] = getSquareValue($xNeg, $yNeg, $arr);
                        if ($arr[$xNeg][$yNeg] >= $number) {
                            return $arr[$xNeg][$yNeg];
                        }
                    }
                    break;
                case 1:
                    if ($yNeg == 0) {
                        $yPos++;
                        $current++;
                        $arr[$xPos][$yPos] = getSquareValue($xPos, $yPos, $arr);
                        if ($arr[$xPos][$yPos] >= $number) {
                            return $arr[$xPos][$yPos];
                        }
                        if ($yPos + 1 == $ring) {
                            $direction = 2;
                        }
                    } else {
                        $yNeg++;
                        $current++;
                        $arr[$xPos][$yNeg] = getSquareValue($xPos, $yNeg, $arr);
                        if ($arr[$xPos][$yNeg] >= $number) {
                            return $arr[$xPos][$yNeg];
                        }
                    }
                    break;
                case 2:
                    if ($xPos > 0) {
                        $xPos--;
                        $current++;
                        $arr[$xPos][$yPos] = getSquareValue($xPos, $yPos, $arr);
                        if ($arr[$xPos][$yPos] >= $number) {
                            return $arr[$xPos][$yPos];
                        }
                    } else {
                        $xNeg--;
                        $current++;
                        $arr[$xNeg][$yPos] = getSquareValue($xNeg, $yPos, $arr);
                        if ($arr[$xNeg][$yPos] >= $number) {
                            return $arr[$xNeg][$yPos];
                        }
                        if ($xNeg - 1 == (-1 * $ring)) {
                            $direction = 3;
                        }
                    }
                    break;
                case 3:
                    if ($yPos > 0) {
                        $yPos--;
                        $current++;
                        $arr[$xNeg][$yPos] = getSquareValue($xNeg, $yPos, $arr);
                        if ($arr[$xNeg][$yPos] >= $number) {
                            return $arr[$xNeg][$yPos];
                        }
                    } else {
                        $yNeg--;
                        $current++;
                        $arr[$xNeg][$yNeg] = getSquareValue($xNeg, $yNeg, $arr);
                        if ($arr[$xNeg][$yNeg] >= $number) {
                            return $arr[$xNeg][$yNeg];
                        }
                        if ($yNeg - 1 == (-1 * $ring)) {
                            $direction = 0;
                            $ring++;
                        }
                    }
                    break;
            }
        }
    }

    function getSquareValue($x, $y, $arr){
        $sum = 0;
        if(isset($arr[$x-1][$y])){
            $sum += $arr[$x-1][$y];
        }
        if(isset($arr[$x-1][$y-1])){
            $sum += $arr[$x-1][$y-1];
        }
        if(isset($arr[$x+1][$y])){
            $sum += $arr[$x+1][$y];
        }
        if(isset($arr[$x+1][$y+1])){
            $sum += $arr[$x+1][$y+1];
        }
        if(isset($arr[$x-1][$y+1])){
            $sum += $arr[$x-1][$y+1];
        }
        if(isset($arr[$x+1][$y-1])){
            $sum += $arr[$x+1][$y-1];
        }
        if(isset($arr[$x][$y-1])){
            $sum += $arr[$x][$y-1];
        }
        if(isset($arr[$x][$y+1])){
            $sum += $arr[$x][$y+1];
        }
        return $sum;
    }

    $result = getSegmentCoordinates();
    echo $result; exit;
