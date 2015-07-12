package com.railtech.po.entity;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the transporter_master database table.
 * 
 */
@Entity
@Table(name="transporter_master")
public class Transporter implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="transporter_id")
	private int transporterId;

	private String active;

	private String contact;

	@Column(name="contact_person")
	private String contactPerson;

	private String email;

	@Column(name="transporter_address")
	private String transporterAddress;

	@Column(name="transporter_name")
	private String transporterName;

	public Transporter() {
	}

	public int getTransporterId() {
		return this.transporterId;
	}

	public void setTransporterId(int transporterId) {
		this.transporterId = transporterId;
	}

	public String getActive() {
		return this.active;
	}

	public void setActive(String active) {
		this.active = active;
	}

	public String getContact() {
		return this.contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getContactPerson() {
		return this.contactPerson;
	}

	public void setContactPerson(String contactPerson) {
		this.contactPerson = contactPerson;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTransporterAddress() {
		return this.transporterAddress;
	}

	public void setTransporterAddress(String transporterAddress) {
		this.transporterAddress = transporterAddress;
	}

	public String getTransporterName() {
		return this.transporterName;
	}

	public void setTransporterName(String transporterName) {
		this.transporterName = transporterName;
	}

}