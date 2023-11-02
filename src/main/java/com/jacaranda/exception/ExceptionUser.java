package com.jacaranda.exception;

public class ExceptionUser extends Exception {

	private static final long serialVersionUID = 1L;

	public ExceptionUser() {
	}

	public ExceptionUser(String message) {
		super(message);
	}

	public ExceptionUser(Throwable cause) {
		super(cause);
	}


}
