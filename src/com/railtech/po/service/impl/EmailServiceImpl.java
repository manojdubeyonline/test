package com.railtech.po.service.impl;

import java.util.concurrent.Executor;
import java.util.concurrent.Executors;

import javax.annotation.PostConstruct;

import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.HtmlEmail;
import org.apache.commons.mail.MultiPartEmail;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.railtech.po.entity.Email;
import com.railtech.po.exeception.RailtechException;
import com.railtech.po.service.EmailService;
import com.railtech.po.util.DaemonThreadFactory;




@Repository(value = "EmailServiceImpl")
@Service
public class EmailServiceImpl implements EmailService {

	protected final Logger log = Logger.getLogger(EmailServiceImpl.class);



	private static final int NUM_THREADS = 5;
	private Executor executor;

	@Autowired
	Environment env;

	private Email _email;

	private boolean sendNotification = false;

	@PostConstruct
	public void init() {
		log.debug("EmailServiceImpl init called...");
		log.debug("@@ Creating email service thread pool with "  + NUM_THREADS + " threads.");
		executor = Executors.newFixedThreadPool(NUM_THREADS, new DaemonThreadFactory());
		String smtpHost = env.getProperty("app.email.smtp.host");
		String smtpPort = env.getProperty("app.email.smtp.port");
		String userName = env.getProperty("app.email.username");
		String password = env.getProperty("app.email.password");
		String fromAddress = env.getProperty("app.email.from");
		String smtps = env.getProperty("app.email.smtps");
		sendNotification = "true".equals(env.getProperty("app.email.notification", "false"));
		if(!sendNotification) log.info("@@ Email Notification has been turned off.");

		_email = new Email();
		_email.setHost(smtpHost);
		if(!"".equals(smtpPort) && smtpPort != null) {
			_email.setPort(Integer.parseInt(smtpPort));
		}
		_email.setUserName(userName);
		_email.setPassword(password);
		_email.setSmtps(("true".equals(smtps)));
		_email.setFrom(fromAddress);
	}



	/**
	 * Send notification with custom message, subject and from address
	 */
	public void sendNotification(String from, String[] to, String subject, String mailText) {
		if(!sendNotification) return;
		log.info("@@ Sending Email Notification generic.");
		Email email = new Email(_email);
		email.setFrom(from);
		email.setTo(to);
		email.setSubject(subject);
		email.setMailText(mailText);
		sendMail(email);
	}


	/**
	 * Single method to send report ready for download notification.
	 */
	private void sendMail(final Email email)
			throws RailtechException {
		executor.execute(new Runnable() {
			public void run() {
				try {

					log.debug("@@ Sending email to : " + email.getTo());
					log.debug("@@ Sending Text : " + email.getMailText());

				    MultiPartEmail mpe = new HtmlEmail();
				    mpe.setDebug(false);
				    if(email.getUserName() != null && !"".equals(email.getUserName())) {
				    	mpe.setAuthenticator(new DefaultAuthenticator(email.getUserName(), email.getPassword()));
				    }
				    mpe.setDebug(true);
				    mpe.setHostName(email.getHost());
				    if(email.getPort() > 10) {
				    	mpe.setSmtpPort(email.getPort());
				    }
				    mpe.addTo(email.getTo());
					mpe.setFrom(email.getFrom());
				    mpe.setSubject(email.getSubject());
				    mpe.setMsg(email.getMailText());
				    /*
				    if(email.getAttachment() != null) {
				    	InputStream is = new BufferedInputStream(
				    			new ByteArrayInputStream(email.getAttachment()));
				    	DataSource source = new ByteArrayDataSource(is, attachMimeType);
				    	mpe.attach(source, attachFileName, email.getSubject());
					}
					*/
				    //mpe.setStartTLSRequired(email.isSmtps() ? true: false);
				    mpe.setStartTLSEnabled(email.isSmtps() ? true: false);
				    mpe.setSSLOnConnect(email.isSmtps() ? true: false);

				    mpe.send();
				}
				catch(Exception e) {
					log.error(e);
					throw new RailtechException(
							e.getMessage());
				}
			}
		});
	}


}
