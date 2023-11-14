package com.jacaranda.model;

import org.apache.commons.codec.digest.DigestUtils;

public class Pruebamd5 {

	public static void main(String[] args) {

		String cadenaEncriptada = DigestUtils.md5Hex("jesus");
		System.out.println(cadenaEncriptada);
	}

}
