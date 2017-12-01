import java.util.*;
import java.lang.*;
import java.io.*;

public class MyClass {
	public static void main (String[] args) throws java.lang.Exception
	{
		ArrayList<Integer> oSum = new ArrayList<>();
 
		String sInput = "12131415";
		int nFirstIndex = 0;
		int nLastNumber = -1;
		int nNum = 0;
		int nSum = 0;
		int nNextIndex = 0;
		int nDelta = sInput.length() / 2;
		
		for (int i = 0; i < sInput.length(); i++){
		    nNextIndex = (nDelta + i) % sInput.length();

		    nLastNumber = Character.getNumericValue(sInput.charAt(i));
		    
			nNum = Character.getNumericValue(sInput.charAt(nNextIndex));
			
			if (nLastNumber == nNum){
				oSum.add(nNum);
			}
			
		}
 
		for (int nNumber: oSum) {
		  nSum += nNumber;
		}
 
		System.out.println(nSum);
 
	}
}
