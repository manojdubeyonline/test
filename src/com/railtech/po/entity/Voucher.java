package com.railtech.po.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;
import java.sql.Timestamp;


/**
 * The persistent class for the voucher_details database table.
 * 
 */
@Entity
@Table(name="voucher_details")
public class Voucher implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="voucher_id")
	private int voucherId;

	@Column(name="approved_rejected")
	private String approvedRejected;

	@Column(name="firm_id")
	private int firmId;

	@Column(name="internal_ref_no")
	private String internalRefNo;

	private String isCashVoucher;

	@Column(name="last_modified")
	private Timestamp lastModified;

	@Column(name="modified_by")
	private int modifiedBy;

	@Column(name="voucher_amount")
	private BigDecimal voucherAmount;

	@Temporal(TemporalType.DATE)
	@Column(name="voucher_date")
	private Date voucherDate;

	@Column(name="voucher_description")
	private String voucherDescription;

	@Temporal(TemporalType.DATE)
	@Column(name="voucher_entry_date")
	private Date voucherEntryDate;

	@Column(name="voucher_no")
	private String voucherNo;

	@Column(name="voucher_number")
	private String voucherNumber;

	@Column(name="voucher_project")
	private String voucherProject;

	@Column(name="voucher_type")
	private String voucherType;

	public Voucher() {
	}

	public int getVoucherId() {
		return this.voucherId;
	}

	public void setVoucherId(int voucherId) {
		this.voucherId = voucherId;
	}

	public String getApprovedRejected() {
		return this.approvedRejected;
	}

	public void setApprovedRejected(String approvedRejected) {
		this.approvedRejected = approvedRejected;
	}

	public int getFirmId() {
		return this.firmId;
	}

	public void setFirmId(int firmId) {
		this.firmId = firmId;
	}

	public String getInternalRefNo() {
		return this.internalRefNo;
	}

	public void setInternalRefNo(String internalRefNo) {
		this.internalRefNo = internalRefNo;
	}

	public String getIsCashVoucher() {
		return this.isCashVoucher;
	}

	public void setIsCashVoucher(String isCashVoucher) {
		this.isCashVoucher = isCashVoucher;
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

	public BigDecimal getVoucherAmount() {
		return this.voucherAmount;
	}

	public void setVoucherAmount(BigDecimal voucherAmount) {
		this.voucherAmount = voucherAmount;
	}

	public Date getVoucherDate() {
		return this.voucherDate;
	}

	public void setVoucherDate(Date voucherDate) {
		this.voucherDate = voucherDate;
	}

	public String getVoucherDescription() {
		return this.voucherDescription;
	}

	public void setVoucherDescription(String voucherDescription) {
		this.voucherDescription = voucherDescription;
	}

	public Date getVoucherEntryDate() {
		return this.voucherEntryDate;
	}

	public void setVoucherEntryDate(Date voucherEntryDate) {
		this.voucherEntryDate = voucherEntryDate;
	}

	public String getVoucherNo() {
		return this.voucherNo;
	}

	public void setVoucherNo(String voucherNo) {
		this.voucherNo = voucherNo;
	}

	public String getVoucherNumber() {
		return this.voucherNumber;
	}

	public void setVoucherNumber(String voucherNumber) {
		this.voucherNumber = voucherNumber;
	}

	public String getVoucherProject() {
		return this.voucherProject;
	}

	public void setVoucherProject(String voucherProject) {
		this.voucherProject = voucherProject;
	}

	public String getVoucherType() {
		return this.voucherType;
	}

	public void setVoucherType(String voucherType) {
		this.voucherType = voucherType;
	}

}