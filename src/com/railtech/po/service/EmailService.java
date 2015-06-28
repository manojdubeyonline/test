package com.railtech.po.service;



public interface EmailService {

	void sendNotification(String from, String[] to, String subject, String mailText);
	
}
