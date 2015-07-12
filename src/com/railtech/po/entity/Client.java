package com.railtech.po.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.sql.Timestamp;


/**
 * The persistent class for the client_master database table.
 * 
 */
@Entity
@Table(name="client_master")
public class Client implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="client_id")
	private int clientId;

	@Column(name="client_name")
	private String clientName;

	@Column(name="last_modified")
	private Timestamp lastModified;

	@Column(name="modified_by")
	private int modifiedBy;

	@Column(name="rnote_app")
	private String rnoteApp;

	public Client() {
	}

	public int getClientId() {
		return this.clientId;
	}

	public void setClientId(int clientId) {
		this.clientId = clientId;
	}

	public String getClientName() {
		return this.clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	public Timestamp getLastModified() {
		return this.lastModified;
	}

	public void setLastModified(Timestamp lastModified) {
		this.lastModified = lastModified;
	}

	public int getModifiedBy() {
		return this.modifiedBy;
	}

	public void setModifiedBy(int modifiedBy) {
		this.modifiedBy = modifiedBy;
	}

	public String getRnoteApp() {
		return this.rnoteApp;
	}

	public void setRnoteApp(String rnoteApp) {
		this.rnoteApp = rnoteApp;
	}

}