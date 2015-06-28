package com.railtech.po.util;

import java.security.SecureRandom;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;


public class Crypto {

	private final static String HEX = "0123456789ABCDEF";
	private final static String SEED = "0192837465alksjdhfg";
	
	public static String encrypt(String cleartext) throws Exception {
		return encrypt(SEED, cleartext);
	}
	
	public static String decrypt(String encrypted) throws Exception {
		return decrypt(SEED, encrypted);
	}
	
	public static String encrypt(String seed, String cleartext) throws Exception {
        byte[] rawKey = getRawKey(seed.getBytes());
        byte[] result = encrypt(rawKey, cleartext.getBytes());
        return toHex(result);
    }

    public static String decrypt(String seed, String encrypted) throws Exception {
        byte[] rawKey = getRawKey(seed.getBytes());
        byte[] enc = toByte(encrypted);
        byte[] result = decrypt(rawKey, enc);
        return new String(result);
    }

    private static byte[] getRawKey(byte[] seed) throws Exception {
        KeyGenerator kgen = KeyGenerator.getInstance("AES");
        SecureRandom sr = SecureRandom.getInstance("SHA1PRNG");
        sr.setSeed(seed);
        kgen.init(128, sr); // 192 and 256 bits may not be available
        SecretKey skey = kgen.generateKey();
        byte[] raw = skey.getEncoded();
        return raw;
    }


    private static byte[] encrypt(byte[] raw, byte[] clear) throws Exception {
        SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");
        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.ENCRYPT_MODE, skeySpec);
        byte[] encrypted = cipher.doFinal(clear);
        return encrypted;
    }

    private static byte[] decrypt(byte[] raw, byte[] encrypted) throws Exception {
        SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");
        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.DECRYPT_MODE, skeySpec);
        byte[] decrypted = cipher.doFinal(encrypted);
        return decrypted;
    }

    public static String toHex(String txt) {
        return toHex(txt.getBytes());
    }
    public static String fromHex(String hex) {
        return new String(toByte(hex));
    }

    public static byte[] toByte(String hexString) {
        int len = hexString.length()/2;
        byte[] result = new byte[len];
        for (int i = 0; i < len; i++)
            result[i] = Integer.valueOf(hexString.substring(2*i, 2*i+2), 16).byteValue();
        return result;
    }

    public static String toHex(byte[] buf) {
        if (buf == null)
            return "";
        StringBuffer result = new StringBuffer(2*buf.length);
        for (int i = 0; i < buf.length; i++) {
            appendHex(result, buf[i]);
        }
        return result.toString();
    }
    
    private static void appendHex(StringBuffer sb, byte b) {
        sb.append(HEX.charAt((b>>4)&0x0f)).append(HEX.charAt(b&0x0f));
    }
    
    public static final class Base64 {
    	private static char[] alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="
    			.toCharArray();
    	private static byte[] codes = new byte[256];
    	static {
    		for (int i = 0; i < 256; i++)
    			codes[i] = -1;
    		for (int i = 'A'; i <= 'Z'; i++)
    			codes[i] = (byte) (i - 'A');
    		for (int i = 'a'; i <= 'z'; i++)
    			codes[i] = (byte) (26 + i - 'a');
    		for (int i = '0'; i <= '9'; i++)
    			codes[i] = (byte) (52 + i - '0');
    		codes['+'] = 62;
    		codes['/'] = 63;
    	}

    	/**
    	 * Returns the encoded data.
    	 */
    	public static String encode(String data) {
    		byte[] plain = data.getBytes();
    		char[] encoded = new char[((plain.length + 2) / 3) * 4];
    		for (int i = 0, index = 0; i < plain.length; i += 3, index += 4) {
    			boolean quad = false;
    			boolean trip = false;
    			int val = (0xFF & (int) plain[i]);
    			val <<= 8;
    			if ((i + 1) < plain.length) {
    				val |= (0xFF & (int) plain[i + 1]);
    				trip = true;
    			}
    			val <<= 8;
    			if ((i + 2) < plain.length) {
    				val |= (0xFF & (int) plain[i + 2]);
    				quad = true;
    			}

    			encoded[index + 3] = alphabet[(quad ? (val & 0x3F) : 64)];
    			val >>= 6;
    			encoded[index + 2] = alphabet[(trip ? (val & 0x3F) : 64)];
    			val >>= 6;
    			encoded[index + 1] = alphabet[val & 0x3F];
    			val >>= 6;
    			encoded[index + 0] = alphabet[val & 0x3F];
    		}

    		return (new String(encoded));
    	}



    	/**
    	 * Returns the decoded data which is encoded by encode().
    	 */
    	public static String decode(String data) {
    		byte[] encoded = data.getBytes();
    		int tempLen = encoded.length;
    		for (int i = 0; i < encoded.length; i++) {
    			if ((encoded[i] > 255) || codes[encoded[i]] < 0) {
    				--tempLen;
    			}
    		}
    		int len = (tempLen / 4) * 3;
    		if ((tempLen % 4) == 3)
    			len += 2;
    		if ((tempLen % 4) == 2)
    			len += 1;
    		byte[] plain = new byte[len];
    		int shift = 0;
    		int accum = 0;
    		int index = 0;
    		for (int i = 0; i < encoded.length; i++) {
    			int value = (encoded[i] > 255) ? -1 : codes[encoded[i]];
    			if (value >= 0) {
    				accum <<= 6;
    				shift += 6;
    				accum |= value;
    				if (shift >= 8) {
    					shift -= 8;
    					plain[index++] = (byte) ((accum >> shift) & 0xff);
    				}
    			}
    		}
    		if (index != plain.length) {
    			throw new Error("Miscalculated data length (wrote " + index
    					+ " instead of " + plain.length + ")");
    		}

    		return (new String(plain));
    	}

    	public static void main(String[] args) {
    		String data = "c3lz";
    		String decodedData = decode(data);
    		System.out
    				.println("decoding: [" + data + "] --> [" + decodedData + "]");

    	}
    }

}
