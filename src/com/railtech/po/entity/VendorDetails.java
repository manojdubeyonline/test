package com.railtech.po.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.codehaus.jackson.annotate.JsonBackReference;



/**
 * The persistent class for the vender_master database table.
 * 
 */
@Entity
@Table(name="vender_details")
public class VendorDetails  implements Serializable{
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="location_id")
	private int locationId;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="client_id")
	@JsonBackReference
	private Vendor vendorId;
	
	@Column(name="client_City")
	private String clientCity;
	
	@Column(name="sap_client_code")
	private String sapClientCode;
	
	@Column(name="client_Address")
	private String clientAddress;
	
	@Column(name="client_Tel")
	private String clientTel;
	
	@Column(name="client_tin")
	private String clientTin;
	
	@Column(name="client_stc")
	private String clientStc;
	
	@Column(name="client_cec")
	private String clientCec;
	
	@Column(name="client_Email")
	private String clientEmail;
	
	@Column(name="location_remarks")
	private String locationRemaks;
	
	@Column(name="vendor_state")
	private String vendorState;
	
	@Column(name="vendor_pin")
	private String vendorPin;
	
	
	@Column(name="modified_by")
	private String modifiedBy;
	
	@Column(name="last_modified")
	@Temporal(TemporalType.TIMESTAMP)
	private Date lastModified;

	/**
	 * @return the locationId
	 */
	public int getLocationId() {
		return locationId;
	}

	/**
	 * @param locationId the locationId to set
	 */
	public void setLocationId(int locationId) {
		this.locationId = locationId;
	}

	/**
	 * @return the vendorId
	 */
	public Vendor getVendorId() {
		return vendorId;
	}

	/**
	 * @param vendorId the vendorId to set
	 */
	public void setVendorId(Vendor vendorId) {
		this.vendorId = vendorId;
	}

	/**
	 * @return the clientCity
	 */
	public String getClientCity() {
		return clientCity;
	}

	/**
	 * @param clientCity the clientCity to set
	 */
	public void setClientCity(String clientCity) {
		this.clientCity = clientCity;
	}

	/**
	 * @return the sapClientCode
	 */
	public String getSapClientCode() {
		return sapClientCode;
	}

	/**
	 * @param sapClientCode the sapClientCode to set
	 */
	public void setSapClientCode(String sapClientCode) {
		this.sapClientCode = sapClientCode;
	}

	/**
	 * @return the clientAddress
	 */
	public String getClientAddress() {
		return clientAddress;
	}

	/**
	 * @param clientAddress the clientAddress to set
	 */
	public void setClientAddress(String clientAddress) {
		this.clientAddress = clientAddress;
	}

	/**
	 * @return the clientTel
	 */
	public String getClientTel() {
		return clientTel;
	}

	/**
	 * @param clientTel the clientTel to set
	 */
	public void setClientTel(String clientTel) {
		this.clientTel = clientTel;
	}

	/**
	 * @return the clientTin
	 */
	public String getClientTin() {
		return clientTin;
	}

	/**
	 * @param clientTin the clientTin to set
	 */
	public void setClientTin(String clientTin) {
		this.clientTin = clientTin;
	}

	/**
	 * @return the clientStc
	 */
	public String getClientStc() {
		return clientStc;
	}

	/**
	 * @param clientStc the clientStc to set
	 */
	public void setClientStc(String clientStc) {
		this.clientStc = clientStc;
	}

	/**
	 * @return the clientCec
	 */
	public String getClientCec() {
		return clientCec;
	}

	/**
	 * @param clientCec the clientCec to set
	 */
	public void setClientCec(String clientCec) {
		this.clientCec = clientCec;
	}

	/**
	 * @return the clientEmail
	 */
	public String getClientEmail() {
		return clientEmail;
	}

	/**
	 * @param clientEmail the clientEmail to set
	 */
	public void setClientEmail(String clientEmail) {
		this.clientEmail = clientEmail;
	}

	/**
	 * @return the locationRemaks
	 */
	public String getLocationRemaks() {
		return locationRemaks;
	}

	/**
	 * @param locationRemaks the locationRemaks to set
	 */
	public void setLocationRemaks(String locationRemaks) {
		this.locationRemaks = locationRemaks;
	}

	/**
	 * @return the vendorState
	 */
	public String getVendorState() {
		return vendorState;
	}

	/**
	 * @param vendorState the vendorState to set
	 */
	public void setVendorState(String vendorState) {
		this.vendorState = vendorState;
	}

	/**
	 * @return the vendorPin
	 */
	public String getVendorPin() {
		return vendorPin;
	}

	/**
	 * @param vendorPin the vendorPin to set
	 */
	public void setVendorPin(String vendorPin) {
		this.vendorPin = vendorPin;
	}

	

	/**
	 * @return the modifiedBy
	 */
	public String getModifiedBy() {
		return modifiedBy;
	}

	/**
	 * @param modifiedBy the modifiedBy to set
	 */
	public void setModifiedBy(String modifiedBy) {
		this.modifiedBy = modifiedBy;
	}

	/**
	 * @return the lastModified
	 */
	public Date getLastModified() {
		return lastModified;
	}

	/**
	 * @param lastModified the lastModified to set
	 */
	public void setLastModified(Date lastModified) {
		this.lastModified = lastModified;
	}
	
	
}
