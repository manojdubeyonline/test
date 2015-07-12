package com.railtech.po.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.sql.Timestamp;


/**
 * The persistent class for the client_details database table.
 * 
 */
@Entity
@Table(name="client_details")
public class ClientDetail implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="location_id")
	private int locationId;

	private String client_Address;

	@Column(name="client_cec")
	private String clientCec;

	private String client_City;

	private String client_Email;

	@Column(name="client_id")
	private int clientId;

	@Column(name="client_state")
	private String clientState;

	@Column(name="client_stc")
	private String clientStc;

	private String client_Tel;

	@Column(name="client_tin")
	private String clientTin;

	@Column(name="last_modified")
	private Timestamp lastModified;

	@Column(name="location_remarks")
	private String locationRemarks;

	@Column(name="modified_by")
	private int modifiedBy;

	private int pin;

	@Column(name="sap_client_code")
	private String sapClientCode;

	public ClientDetail() {
	}

	public int getLocationId() {
		return this.locationId;
	}

	public void setLocationId(int locationId) {
		this.locationId = locationId;
	}

	public String getClient_Address() {
		return this.client_Address;
	}

	public void setClient_Address(String client_Address) {
		this.client_Address = client_Address;
	}

	public String getClientCec() {
		return this.clientCec;
	}

	public void setClientCec(String clientCec) {
		this.clientCec = clientCec;
	}

	public String getClient_City() {
		return this.client_City;
	}

	public void setClient_City(String client_City) {
		this.client_City = client_City;
	}

	public String getClient_Email() {
		return this.client_Email;
	}

	public void setClient_Email(String client_Email) {
		this.client_Email = client_Email;
	}

	public int getClientId() {
		return this.clientId;
	}

	public void setClientId(int clientId) {
		this.clientId = clientId;
	}

	public String getClientState() {
		return this.clientState;
	}

	public void setClientState(String clientState) {
		this.clientState = clientState;
	}

	public String getClientStc() {
		return this.clientStc;
	}

	public void setClientStc(String clientStc) {
		this.clientStc = clientStc;
	}

	public String getClient_Tel() {
		return this.client_Tel;
	}

	public void setClient_Tel(String client_Tel) {
		this.client_Tel = client_Tel;
	}

	public String getClientTin() {
		return this.clientTin;
	}

	public void setClientTin(String clientTin) {
		this.clientTin = clientTin;
	}

	public Timestamp getLastModified() {
		return this.lastModified;
	}

	public void setLastModified(Timestamp lastModified) {
		this.lastModified = lastModified;
	}

	public String getLocationRemarks() {
		return this.locationRemarks;
	}

	public void setLocationRemarks(String locationRemarks) {
		this.locationRemarks = locationRemarks;
	}

	public int getModifiedBy() {
		return this.modifiedBy;
	}

	public void setModifiedBy(int modifiedBy) {
		this.modifiedBy = modifiedBy;
	}

	public int getPin() {
		return this.pin;
	}

	public void setPin(int pin) {
		this.pin = pin;
	}

	public String getSapClientCode() {
		return this.sapClientCode;
	}

	public void setSapClientCode(String sapClientCode) {
		this.sapClientCode = sapClientCode;
	}

}