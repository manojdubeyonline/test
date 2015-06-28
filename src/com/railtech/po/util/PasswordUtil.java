/**
 * 
 */
package com.railtech.po.util;

/**
 * @author MANOJ
 * Random Password Generator
 */
import java.util.Random;

public class PasswordUtil {
	// ToDo- the fields can be populated with values from property files at a
	// later date- if needed
	private static final String ALPHA_CAPS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	private static final String ALPHA = "abcdefghijklmnopqrstuvwxyz";
	private static final String NUM = "0123456789";
	private static final String SPL_CHARS = "!@#$%^&*_=+-/";
	private static final int NALPHACAPS = 1;
	private static final int NDIGITS = 1;
	private static final int NSPCL = 1;
	private static final int MINLEN = 8;
	private static final int MAXLEN = 12;

	public static String generatePassword() {
		return generatePassword(MINLEN, MAXLEN, NALPHACAPS, NDIGITS,
				NSPCL);
	}

	public static String generatePassword(int minLen, int maxLen,
			int noOfCAPSAlpha, int noOfDigits, int noOfSplChars) {
		if (minLen > maxLen)
			throw new IllegalArgumentException("Min. Length > Max. Length!");
		if ((noOfCAPSAlpha + noOfDigits + noOfSplChars) > minLen)
			throw new IllegalArgumentException(
					"Min. Length should be atleast sum of (CAPS, DIGITS, SPL CHARS) Length!");
		Random rnd = new Random();
		int len = rnd.nextInt(maxLen - minLen + 1) + minLen;
		char[] pswd = new char[len];
		int index = 0;
		for (int i = 0; i < noOfCAPSAlpha; i++) {
			index = getNextIndex(rnd, len, pswd);
			pswd[index] = ALPHA_CAPS.charAt(rnd.nextInt(ALPHA_CAPS.length()));
		}
		for (int i = 0; i < noOfDigits; i++) {
			index = getNextIndex(rnd, len, pswd);
			pswd[index] = NUM.charAt(rnd.nextInt(NUM.length()));
		}
		for (int i = 0; i < noOfSplChars; i++) {
			index = getNextIndex(rnd, len, pswd);
			pswd[index] = SPL_CHARS.charAt(rnd.nextInt(SPL_CHARS.length()));
		}
		for (int i = 0; i < len; i++) {
			if (pswd[i] == 0) {
				pswd[i] = ALPHA.charAt(rnd.nextInt(ALPHA.length()));
			}
		}
		return new String(pswd);
	}

	private static int getNextIndex(Random rnd, int len, char[] pswd) {
		int index = rnd.nextInt(len);
		while (pswd[index = rnd.nextInt(len)] != 0)
			;
		return index;
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {

		String pswd = PasswordUtil.generatePassword(MINLEN, MAXLEN,
				NALPHACAPS, NDIGITS, NSPCL);
		System.out.println("Len = " + pswd.length() + ", " + pswd);

	}

}
