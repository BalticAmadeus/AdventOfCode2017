import java.util.*;
import java.lang.*;
import java.io.*;
 
/* Name of the class has to be "Main" only if the class is public. */
class MyClass
{
	public static void main (String[] args) throws java.lang.Exception
	{
		ArrayList<Integer> oSum = new ArrayList<>();
 
		String sInput = "112233";
		int nFirstIndex = 0;
		int nLastNumber = -1;
		int nNum = 0;
		int nSum = 0;
		for (int i = 0; i < sInput.length(); i++){
			nNum = Character.getNumericValue(sInput.charAt(i));
			if (nLastNumber == nNum){
				oSum.add(nNum);
			}
		}
 
		for (int nNumber: oSum) {
		  nSum += nNumber;
		}
 
         //nepamirstam paziuret ar paskutinis skaiciukas sutampa su 1 ir ji pridedam :)
		System.out.println(nSum);
 
	}
}