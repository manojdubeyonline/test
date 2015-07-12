package com.railtech.po.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the payment database table.
 * 
 */
@Entity
public class Payment implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="payment_id")
	private int paymentId;

	@Column(name="challon_no_new")
	private String challonNoNew;

	private String dedction;

	@Column(name="deduction_id")
	private int deductionId;

	@Column(name="internal_ref_no")
	private String internalRefNo;

	@Column(name="modified_by")
	private int modifiedBy;

	@Column(name="payment_no")
	private String paymentNo;

	@Column(name="payment_qty")
	private BigDecimal paymentQty;

	@Column(name="payment_type")
	private String paymentType;

	@Column(name="po_no")
	private String poNo;

	@Temporal(TemporalType.DATE)
	private Date submission_Date;

	public Payment() {
	}

	public int getPaymentId() {
		return this.paymentId;
	}

	public void setPaymentId(int paymentId) {
		this.paymentId = paymentId;
	}

	public String getChallonNoNew() {
		return this.challonNoNew;
	}

	public void setChallonNoNew(String challonNoNew) {
		this.challonNoNew = challonNoNew;
	}

	public String getDedction() {
		return this.dedction;
	}

	public void setDedction(String dedction) {
		this.dedction = dedction;
	}

	public int getDeductionId() {
		return this.deductionId;
	}

	public void setDeductionId(int deductionId) {
		this.deductionId = deductionId;
	}

	public String getInternalRefNo() {
		return this.internalRefNo;
	}

	public void setInternalRefNo(String internalRefNo) {
		this.internalRefNo = internalRefNo;
	}

	public int getModifiedBy() {
		return this.modifiedBy;
	}

	public void setModifiedBy(int modifiedBy) {
		this.modifiedBy = modifiedBy;
	}

	public String getPaymentNo() {
		return this.paymentNo;
	}

	public void setPaymentNo(String paymentNo) {
		this.paymentNo = paymentNo;
	}

	public BigDecimal getPaymentQty() {
		return this.paymentQty;
	}

	public void setPaymentQty(BigDecimal paymentQty) {
		this.paymentQty = paymentQty;
	}

	public String getPaymentType() {
		return this.paymentType;
	}

	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}

	public String getPoNo() {
		return this.poNo;
	}

	public void setPoNo(String poNo) {
		this.poNo = poNo;
	}

	public Date getSubmission_Date() {
		return this.submission_Date;
	}

	public void setSubmission_Date(Date submission_Date) {
		this.submission_Date = submission_Date;
	}

}