package com.railtech.po.exeception;

public class RailtechException extends RuntimeException {


	private static final long serialVersionUID = 1L;
	
	public RailtechException() {
		super();
	}
	
	public RailtechException(String msg) {
		super(msg);
	}

}
