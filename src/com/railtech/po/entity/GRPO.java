package com.railtech.po.entity;

import java.io.Serializable;

import javax.persistence.*;

import java.util.Date;
import java.sql.Timestamp;


/**
 * The persistent class for the grpo database table.
 * 
 */
@Entity
@Table(name="grpo")
public class GRPO implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="grpo_id")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer grpoId;

	@ManyToOne
	@JoinColumn(name="marking_id")
	private Procurement markingId;

	@ManyToOne
	@JoinColumn(name="order_id")
	private PurchaseOrder orderId;
	
	@ManyToOne
	@JoinColumn(name="item_code_id")
	private Code itemCode;
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="inward_date")
	private Date inwardDate;

	@Column(name="inward_qty")
	private Float inwardQty;

	@ManyToOne
	@JoinColumn(name="unit_id")
	private Unit unit;
	
	
	@ManyToOne
	@JoinColumn(name="inward_added_by")
	private User addedBy;

	@Column(name="approval_comments")
	private String approvalComments;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="approval_date")
	private Date approvalDate;

	@Column(name="approval_status")
	private String approvalStatus;

	@ManyToOne
	@JoinColumn(name="approved_by")
	private User approvedBy;
	
	@Column(name="bill_amount")
	private Float billAmount;


	@Column(name="inward_comments")
	private String inwardComments;


	private String isdisbursed;
	
	@ManyToOne
	@JoinColumn(name="last_modified_by")
	private User lastModifiedBy;

	@Column(name="last_updated")
	private Timestamp lastUpdated;

	@Column(name="vendor_details")
	private String vendorDetails;

	public GRPO() {
	}

	/**
	 * @return the grpoId
	 */
	public Integer getGrpoId() {
		return grpoId;
	}

	/**
	 * @param grpoId the grpoId to set
	 */
	public void setGrpoId(Integer grpoId) {
		this.grpoId = grpoId;
	}

	/**
	 * @return the markingId
	 */
	public Procurement getMarkingId() {
		return markingId;
	}

	/**
	 * @param markingId the markingId to set
	 */
	public void setMarkingId(Procurement markingId) {
		this.markingId = markingId;
	}

	/**
	 * @return the orderId
	 */
	public PurchaseOrder getOrderId() {
		return orderId;
	}

	/**
	 * @param orderId the orderId to set
	 */
	public void setOrderId(PurchaseOrder orderId) {
		this.orderId = orderId;
	}

	/**
	 * @return the itemCode
	 */
	public Code getItemCode() {
		return itemCode;
	}

	/**
	 * @param itemCode the itemCode to set
	 */
	public void setItemCode(Code itemCode) {
		this.itemCode = itemCode;
	}

	/**
	 * @return the inwardDate
	 */
	public Date getInwardDate() {
		return inwardDate;
	}

	/**
	 * @param inwardDate the inwardDate to set
	 */
	public void setInwardDate(Date inwardDate) {
		this.inwardDate = inwardDate;
	}

	/**
	 * @return the inwardQty
	 */
	public Float getInwardQty() {
		return inwardQty;
	}

	/**
	 * @param inwardQty the inwardQty to set
	 */
	public void setInwardQty(Float inwardQty) {
		this.inwardQty = inwardQty;
	}

	/**
	 * @return the unit
	 */
	public Unit getUnit() {
		return unit;
	}

	/**
	 * @param unit the unit to set
	 */
	public void setUnit(Unit unit) {
		this.unit = unit;
	}

	/**
	 * @return the addedBy
	 */
	public User getAddedBy() {
		return addedBy;
	}

	/**
	 * @param addedBy the addedBy to set
	 */
	public void setAddedBy(User addedBy) {
		this.addedBy = addedBy;
	}

	/**
	 * @return the approvalComments
	 */
	public String getApprovalComments() {
		return approvalComments;
	}

	/**
	 * @param approvalComments the approvalComments to set
	 */
	public void setApprovalComments(String approvalComments) {
		this.approvalComments = approvalComments;
	}

	/**
	 * @return the approvalDate
	 */
	public Date getApprovalDate() {
		return approvalDate;
	}

	/**
	 * @param approvalDate the approvalDate to set
	 */
	public void setApprovalDate(Date approvalDate) {
		this.approvalDate = approvalDate;
	}

	/**
	 * @return the approvalStatus
	 */
	public String getApprovalStatus() {
		return approvalStatus;
	}

	/**
	 * @param approvalStatus the approvalStatus to set
	 */
	public void setApprovalStatus(String approvalStatus) {
		this.approvalStatus = approvalStatus;
	}

	/**
	 * @return the approvedBy
	 */
	public User getApprovedBy() {
		return approvedBy;
	}

	/**
	 * @param approvedBy the approvedBy to set
	 */
	public void setApprovedBy(User approvedBy) {
		this.approvedBy = approvedBy;
	}

	/**
	 * @return the billAmount
	 */
	public Float getBillAmount() {
		return billAmount;
	}

	/**
	 * @param billAmount the billAmount to set
	 */
	public void setBillAmount(Float billAmount) {
		this.billAmount = billAmount;
	}

	/**
	 * @return the inwardComments
	 */
	public String getInwardComments() {
		return inwardComments;
	}

	/**
	 * @param inwardComments the inwardComments to set
	 */
	public void setInwardComments(String inwardComments) {
		this.inwardComments = inwardComments;
	}

	/**
	 * @return the isdisbursed
	 */
	public String getIsdisbursed() {
		return isdisbursed;
	}

	/**
	 * @param isdisbursed the isdisbursed to set
	 */
	public void setIsdisbursed(String isdisbursed) {
		this.isdisbursed = isdisbursed;
	}

	/**
	 * @return the lastModifiedBy
	 */
	public User getLastModifiedBy() {
		return lastModifiedBy;
	}

	/**
	 * @param lastModifiedBy the lastModifiedBy to set
	 */
	public void setLastModifiedBy(User lastModifiedBy) {
		this.lastModifiedBy = lastModifiedBy;
	}

	/**
	 * @return the lastUpdated
	 */
	public Timestamp getLastUpdated() {
		return lastUpdated;
	}

	/**
	 * @param lastUpdated the lastUpdated to set
	 */
	public void setLastUpdated(Timestamp lastUpdated) {
		this.lastUpdated = lastUpdated;
	}

	/**
	 * @return the vendorDetails
	 */
	public String getVendorDetails() {
		return vendorDetails;
	}

	/**
	 * @param vendorDetails the vendorDetails to set
	 */
	public void setVendorDetails(String vendorDetails) {
		this.vendorDetails = vendorDetails;
	}


}