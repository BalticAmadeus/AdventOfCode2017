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
    
    public static void main(String[] args) {
        String file = "input.txt";
        int severity = 0;
        ArrayList<Firewall> oFirewalls = new ArrayList<>();
        
        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = br.readLine()) != null) {
               String splited[] = line.split(": ");
               
               Firewall oFw = new Firewall();
               
               oFw.depth = Integer.parseInt(splited[0]);
               oFw.range = Integer.parseInt(splited[1]);
               oFirewalls.add(oFw);
            }
        } catch (Exception ex) {
            //who cares
        }
        
        for (int i=0; i < oFirewalls.get(oFirewalls.size() -1).depth; i++){           
            for (Firewall oFw: oFirewalls){
                if (oFw.depth == i){
                    
                    if (oFw.position == 1)
                        severity += oFw.depth * oFw.range;
                    
                    break;
                }
            }
            
            for (Firewall oFw: oFirewalls){
                if (oFw.range == oFw.position)
                    oFw.down = false;
                else if (oFw.position == 1)
                    oFw.down = true;
                
                if (oFw.down) ++oFw.position;
                else --oFw.position;
            }
        }
        
        System.out.println(severity);
    }   
}
