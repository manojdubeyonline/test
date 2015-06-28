package com.railtech.po.entity;

import java.util.Arrays;

public class Email {
	
	private String host;
	private int port;
	private boolean smtps;
	private String userName;
	private String password;
	private String subject; 
	private String mailText; 
	private String from; 
	private String[] to;
	
	public Email() {}
	
	public Email(Email email) {
		this.host = email.getHost();
		this.port = email.getPort();
		this.smtps = email.isSmtps();
		this.userName = email.getUserName();
		this.password = email.getPassword();
		this.subject = email.getSubject();
		this.mailText = email.getMailText();
		this.from = email.getFrom();
		this.to = email.getTo();
	}
	
	public String getHost() {
		return host;
	}
	public void setHost(String host) {
		this.host = host;
	}
	public int getPort() {
		return port;
	}
	public void setPort(int port) {
		this.port = port;
	}
	public boolean isSmtps() {
		return smtps;
	}
	public void setSmtps(boolean smtps) {
		this.smtps = smtps;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getMailText() {
		return mailText;
	}
	public void setMailText(String mailText) {
		this.mailText = mailText;
	}
	public String getFrom() {
		return from;
	}
	public void setFrom(String from) {
		this.from = from;
	}
	public String[] getTo() {
		return to;
	}
	public void setTo(String[] to) {
		this.to = to;
	}
	
	@Override
	public String toString() {
		return "Email [host=" + host + ", port=" + port + ", smtps=" + smtps
				+ ", userName=" + userName + ", password=" + password
				+ ", subject=" + subject + ", mailText=" + mailText + ", from="
				+ from + ", to=" + Arrays.toString(to) + "]";
	}
	
	
}
