package com.railtech.po.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.sql.Timestamp;


/**
 * The persistent class for the tbl_firms database table.
 * 
 */
@Entity
@Table(name="tbl_firms")
public class Firm implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="firm_id")
	private Integer firmId;

	@Column(name="central_no")
	private String centralNo;

	private String colleborate;

	private String division;

	@Column(name="firm_code")
	private String firmCode;

	@Column(name="firm_contact")
	private String firmContact;

	@Column(name="firm_email")
	private String firmEmail;

	@Column(name="firm_fax")
	private String firmFax;

	@Column(name="firm_headoffice")
	private String firmHeadoffice;

	@Column(name="firm_location")
	private String firmLocation;

	@Column(name="firm_location1")
	private String firmLocation1;

	@Column(name="firm_logo")
	private String firmLogo;

	@Column(name="firm_name")
	private String firmName;

	@Column(name="firm_phone")
	private String firmPhone;

	@Column(name="last_modified")
	private Timestamp lastModified;

	@Column(name="modified_by")
	private Integer modifiedBy;

	@Column(name="pan_no")
	private String panNo;

	private String range1;

	@Lob
	private String remarks;

	@Column(name="service_no")
	private String serviceNo;

	private String status;

	@Column(name="tin_no")
	private String tinNo;

	public Firm() {
	}

	public Integer getFirmId() {
		return this.firmId;
	}

	public void setFirmId(Integer firmId) {
		this.firmId = firmId;
	}

	public String getCentralNo() {
		return this.centralNo;
	}

	public void setCentralNo(String centralNo) {
		this.centralNo = centralNo;
	}

	public String getColleborate() {
		return this.colleborate;
	}

	public void setColleborate(String colleborate) {
		this.colleborate = colleborate;
	}

	public String getDivision() {
		return this.division;
	}

	public void setDivision(String division) {
		this.division = division;
	}

	public String getFirmCode() {
		return this.firmCode;
	}

	public void setFirmCode(String firmCode) {
		this.firmCode = firmCode;
	}

	public String getFirmContact() {
		return this.firmContact;
	}

	public void setFirmContact(String firmContact) {
		this.firmContact = firmContact;
	}

	public String getFirmEmail() {
		return this.firmEmail;
	}

	public void setFirmEmail(String firmEmail) {
		this.firmEmail = firmEmail;
	}

	public String getFirmFax() {
		return this.firmFax;
	}

	public void setFirmFax(String firmFax) {
		this.firmFax = firmFax;
	}

	public String getFirmHeadoffice() {
		return this.firmHeadoffice;
	}

	public void setFirmHeadoffice(String firmHeadoffice) {
		this.firmHeadoffice = firmHeadoffice;
	}

	public String getFirmLocation() {
		return this.firmLocation;
	}

	public void setFirmLocation(String firmLocation) {
		this.firmLocation = firmLocation;
	}

	public String getFirmLocation1() {
		return this.firmLocation1;
	}

	public void setFirmLocation1(String firmLocation1) {
		this.firmLocation1 = firmLocation1;
	}

	public String getFirmLogo() {
		return this.firmLogo;
	}

	public void setFirmLogo(String firmLogo) {
		this.firmLogo = firmLogo;
	}

	public String getFirmName() {
		return this.firmName;
	}

	public void setFirmName(String firmName) {
		this.firmName = firmName;
	}

	public String getFirmPhone() {
		return this.firmPhone;
	}

	public void setFirmPhone(String firmPhone) {
		this.firmPhone = firmPhone;
	}

	public Timestamp getLastModified() {
		return this.lastModified;
	}

	public void setLastModified(Timestamp lastModified) {
		this.lastModified = lastModified;
	}

	public Integer getModifiedBy() {
		return this.modifiedBy;
	}

	public void setModifiedBy(Integer modifiedBy) {
		this.modifiedBy = modifiedBy;
	}

	public String getPanNo() {
		return this.panNo;
	}

	public void setPanNo(String panNo) {
		this.panNo = panNo;
	}

	public String getRange1() {
		return this.range1;
	}

	public void setRange1(String range1) {
		this.range1 = range1;
	}

	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getServiceNo() {
		return this.serviceNo;
	}

	public void setServiceNo(String serviceNo) {
		this.serviceNo = serviceNo;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getTinNo() {
		return this.tinNo;
	}

	public void setTinNo(String tinNo) {
		this.tinNo = tinNo;
	}

}