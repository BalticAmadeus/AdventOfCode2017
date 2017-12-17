/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package test;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;

/**
 *
 * @author PC
 */
public class Test {
    
    public static void main(String[] args) {              
        ArrayList<Integer> buffer = new ArrayList<Integer>();
        final int steps = 394;
        int value = 0;
        
        buffer.add(0);
        
        for (int i=1; i< 2018; i++){
            value = (value + steps) % buffer.size();
            buffer.add(value + 1, i);

            ++value;
        }
        System.out.println(buffer.get(buffer.indexOf(2017) + 1));
    }
}
