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
                        $arr[$xPos][$yNeg] = $current;
                        if ($current == $number) {
                            return [ 0 => $xPos, 1 => $yNeg];
                        }
                        if ($xPos + 1 == $ring) {
                            $direction = 1;
                        }
                    } else {
                        $xNeg++;
                        $current++;
                        $arr[$xNeg][$yNeg] = $current;
                        if ($current == $number) {
                            return [ 0 => $xNeg, 1 => $yNeg];
                        }
                    }
                    break;
                case 1:
                    if ($yNeg == 0) {
                        $yPos++;
                        $current++;
                        $arr[$xPos][$yPos] = $current;
                        if ($current == $number) {
                            return [ 0 => $xPos, 1 => $yPos];
                        }
                        if ($yPos + 1 == $ring) {
                            $direction = 2;
                        }
                    } else {
                        $yNeg++;
                        $current++;
                        $arr[$xPos][$yNeg] = $current;
                        if ($current == $number) {
                            return [ 0 => $xPos, 1 => $yNeg];
                        }
                    }
                    break;
                case 2:
                    if ($xPos > 0) {
                        $xPos--;
                        $current++;
                        $arr[$xPos][$yPos] = $current;
                        if ($current == $number) {
                            return [ 0 => $xPos, 1 => $yPos];
                        }
                    } else {
                        $xNeg--;
                        $current++;
                        $arr[$xNeg][$yPos] = $current;
                        if ($current == $number) {
                            return [ 0 => $xNeg, 1 => $yPos];
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
                        $arr[$xNeg][$yPos] = $current;
                        if ($current == $number) {
                            return [ 0 => $xNeg, 1 => $yPos];
                        }
                    } else {
                        $yNeg--;
                        $current++;
                        $arr[$xNeg][$yNeg] = $current;
                        if ($current == $number) {
                            return [ 0 => $xNeg, 1 => $yNeg];
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

    $result = getSegmentCoordinates();
    if($result[0] < 0){
        $result[0] = $result[0] * -1;
    }
    if($result[1] < 0){
        $result[1] = $result[1] * -1;
    }
    $result = $result[0] + $result[1];
    echo $result; exit;
