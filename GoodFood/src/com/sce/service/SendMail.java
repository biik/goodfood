package com.sce.service;

import java.util.Properties;

import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

public class SendMail
{
	private static String HOST = "smtp.gmail.com";
	private static String USER = "goodfoodjava@gmail.com";//"yourmail.com";
	private static String PASSWORD = "java@goodfood";
	private static String PORT = "465";
	private static String FROM = "mail.com";
	private static String TO;
	private static String STARTTLS = "true";
	private static String AUTH = "true";
	private static String DEBUG = "true";
	private static String SOCKET_FACTORY = "javax.net.ssl.SSLSocketFactory";
	private static String SUBJECT;
	private static String TEXT;
	
	public SendMail() {
		super();
	}

	public synchronized void send(String to, String subject, String text)
	{
		TO = to;
		SUBJECT = subject;
		TEXT = text;
		//Use Properties object to set environment properties
		Properties props = new Properties();
		props.put("mail.smtp.host", HOST);
		props.put("mail.smtp.port", PORT);
		props.put("mail.smtp.user", USER);
		props.put("mail.smtp.auth", AUTH);
		props.put("mail.smtp.starttls.enable", STARTTLS);
		props.put("mail.smtp.debug", DEBUG);
		props.put("mail.smtp.socketFactory.port", PORT);
		props.put("mail.smtp.socketFactory.class", SOCKET_FACTORY);
		props.put("mail.smtp.socketFactory.fallback", "false");
		
		try
		{
			//Obtain the default mail session
			Session session = Session.getDefaultInstance(props, null);
			//session.setDebug(true);
			//Construct the mail message
			MimeMessage message = new MimeMessage(session);
			message.setText(TEXT);
			message.setSubject(SUBJECT);
			message.setFrom(new InternetAddress(FROM));
			message.addRecipient(RecipientType.TO, new InternetAddress(TO));
			message.saveChanges();
			
			//Use Transport to deliver the message
			Transport transport = session.getTransport("smtp");
			transport.connect(HOST, USER, PASSWORD);
			transport.sendMessage(message, message.getAllRecipients());
			
			transport.close();
			
		} catch (Exception e){
			e.printStackTrace();
		}
	}
}
