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

    /**
     * @param args the command line arguments
     */
    
    public static String replaceCharAt(String s, int pos, char c) {
        return s.substring(0, pos) + c + s.substring(pos + 1);
    }
    
    public static void main(String[] args) {
        String programs = "abcdefghijklmnop";
        
        String file = "input.txt";
        String instructions[] = null;
                
        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = br.readLine()) != null) {
                instructions = line.split(",");
            }
        } catch (Exception ex) {
            //who cares
        }
        ArrayList<String> oDances = new ArrayList<>();

        for (int j=0; j < 1000000000; j++){
            
        
            for (int i = 0; i< instructions.length; i++){
                if (instructions[i].charAt(0) == 's'){
                    int S = Integer.parseInt(instructions[i].substring(1));

                    programs = programs.substring(programs.length() - S) + programs.substring(0, programs.length() - S);
                }
                else if (instructions[i].charAt(0) == 'x'){
                    char temp;

                    String AB[] = instructions[i].substring(1).split("/");
                    int A, B;
                    A = Integer.parseInt(AB[0]);
                    B = Integer.parseInt(AB[1]);

                    temp = programs.charAt(A);
                    try{
                        programs = replaceCharAt(programs, A, programs.charAt(B));
                         programs = replaceCharAt(programs, B, temp);
                    }
                    catch (Exception ex) {
                        System.out.println(programs + " " + B);
                    }
                }
                else if (instructions[i].charAt(0) == 'p'){
                    char A, B;
                    int posA, posB;

                    A = instructions[i].charAt(1);
                    B = instructions[i].charAt(3);

                    posA = programs.indexOf(A);
                    posB = programs.indexOf(B);

                    programs = replaceCharAt(programs, posA, B);
                    programs = replaceCharAt(programs, posB, A);
                }
            }
            
            if (!oDances.contains(programs)){
                oDances.add(programs);
            }
            else break;
        }
        
        System.out.println(oDances.size());
        System.out.println(oDances.get(1000000000 % oDances.size() -1));
    }   
}
