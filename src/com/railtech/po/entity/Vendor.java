package com.railtech.po.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * The persistent class for the vender_tbl_po_code database table.
 * 
 */
@Entity
@Table(name="vendor")
public class Vendor implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="vendor_id")
	private int vendorId;

	@Column(name="vendor_name")
	private String vendorName;

	@Column(name="vendor_address")
	private String vendorAddress;

	@Column(name="vendor_city")
	private String vendorCity;

	@Column(name="primary_contact")
	private String primaryContact;

	@Column(name="contact_details")
	private String contactDetails;

	@Column(name="blackListed")
	private String isBlackListed;

	public int getVendorId() {
		return vendorId;
	}

	public void setVendorId(int vendorId) {
		this.vendorId = vendorId;
	}

	public String getVendorName() {
		return vendorName;
	}

	public void setVendorName(String vendorName) {
		this.vendorName = vendorName;
	}

	public String getVendorAddress() {
		return vendorAddress;
	}

	public void setVendorAddress(String vendorAddress) {
		this.vendorAddress = vendorAddress;
	}

	public String getVendorCity() {
		return vendorCity;
	}

	public void setVendorCity(String vendorCity) {
		this.vendorCity = vendorCity;
	}

	public String getPrimaryContact() {
		return primaryContact;
	}

	public void setPrimaryContact(String primaryContact) {
		this.primaryContact = primaryContact;
	}

	public String getContactDetails() {
		return contactDetails;
	}

	public void setContactDetails(String contactDetails) {
		this.contactDetails = contactDetails;
	}

	public String getIsBlackListed() {
		return isBlackListed;
	}

	public void setIsBlackListed(String isBlackListed) {
		this.isBlackListed = isBlackListed;
	}

}