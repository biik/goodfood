package com.sce.service;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Hex {

	public Hex() {
		super();
	}
	
	public String getHexMD5(String message) throws NoSuchAlgorithmException {
		StringBuffer stringBuffer = new StringBuffer();
        MessageDigest messageDigest = MessageDigest.getInstance("MD5");
        messageDigest.update(message.getBytes());
        byte byteData[] = messageDigest.digest();
        stringBuffer.setLength(0);
    	for (int i=0;i<byteData.length;i++) {
    		String hex=Integer.toHexString(0xff & byteData[i]);
   	     	if(hex.length()==1) stringBuffer.append('0');
   	     	stringBuffer.append(hex);
    	}
    	return stringBuffer.toString();
	}
}
