package com.railtech.po.entity;


import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * The persistent class for the requisition_procurement_marking database table.
 * 
 */
@Entity
@Table(name="purchase_order")
public class PurchaseOrder implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="purchase_order_id")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer markingId;
	
	@Column(name="purchase_order_number")
	private String purchaseOrderNo;
	
	@ManyToOne
	@JoinColumn(name="item_code_id")
	private Code itemCode;
	
	@ManyToOne
	@JoinColumn(name="firm_id")
	private Firm firm;
	
	@ManyToOne
	@JoinColumn(name="ware_id")
	private Warehouse warehouse;
	
	@ManyToOne
	@JoinColumn(name="vendor_id")
	private Vendor vendor;
	
	@ManyToOne
	@JoinColumn(name="marking_id")
	private Procurement ProcurementMarking;
	
	@Column(name="order_qty")
	private double orderQty;
	
	@ManyToOne
	@JoinColumn(name="unit")
	private Unit unit;
	
	@Column(name="basic_rate")
	private double rate;
	
	@ManyToOne
	@JoinColumn(name="added_by")
	private User addedBy;

	@ManyToOne
	@JoinColumn(name="approved_by")
	private User approvedBy;
	
	@Column(name="procurement_type")
	private String procurementType;

	@Column(name="remarks")
	private String remarks;
	
	@Column(name="approval_status")
	private String approvalStatus;
	
	@Column(name="procurement_status")
	private String procurementStatus;
		
	@Column(name="due_date")
	private Date dueDate;
	
	@Column(name="approval_date")
	private Date approvalDate;
	
	@Column(name="marking_date")
	private Date markingDate;
	
	@Column(name="last_modified")
	@Temporal(TemporalType.TIMESTAMP)
	private Date lastModified;

	
	public PurchaseOrder() {
	}


	/**
	 * @return the markingId
	 */
	public Integer getMarkingId() {
		return markingId;
	}


	/**
	 * @param markingId the markingId to set
	 */
	public void setMarkingId(Integer markingId) {
		this.markingId = markingId;
	}


	/**
	 * @return the purchaseOrderNo
	 */
	public String getPurchaseOrderNo() {
		return purchaseOrderNo;
	}


	/**
	 * @param purchaseOrderNo the purchaseOrderNo to set
	 */
	public void setPurchaseOrderNo(String purchaseOrderNo) {
		this.purchaseOrderNo = purchaseOrderNo;
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
	 * @return the firm
	 */
	public Firm getFirm() {
		return firm;
	}


	/**
	 * @param firm the firm to set
	 */
	public void setFirm(Firm firm) {
		this.firm = firm;
	}


	/**
	 * @return the warehouse
	 */
	public Warehouse getWarehouse() {
		return warehouse;
	}


	/**
	 * @param warehouse the warehouse to set
	 */
	public void setWarehouse(Warehouse warehouse) {
		this.warehouse = warehouse;
	}


	/**
	 * @return the vendor
	 */
	public Vendor getVendor() {
		return vendor;
	}


	/**
	 * @param vendor the vendor to set
	 */
	public void setVendor(Vendor vendor) {
		this.vendor = vendor;
	}


	/**
	 * @return the procurementMarking
	 */
	public Procurement getProcurementMarking() {
		return ProcurementMarking;
	}


	/**
	 * @param procurementMarking the procurementMarking to set
	 */
	public void setProcurementMarking(Procurement procurementMarking) {
		ProcurementMarking = procurementMarking;
	}


	/**
	 * @return the orderQty
	 */
	public double getOrderQty() {
		return orderQty;
	}


	/**
	 * @param orderQty the orderQty to set
	 */
	public void setOrderQty(double orderQty) {
		this.orderQty = orderQty;
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
	 * @return the rate
	 */
	public double getRate() {
		return rate;
	}


	/**
	 * @param rate the rate to set
	 */
	public void setRate(double rate) {
		this.rate = rate;
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
	 * @return the procurementType
	 */
	public String getProcurementType() {
		return procurementType;
	}


	/**
	 * @param procurementType the procurementType to set
	 */
	public void setProcurementType(String procurementType) {
		this.procurementType = procurementType;
	}


	/**
	 * @return the remarks
	 */
	public String getRemarks() {
		return remarks;
	}


	/**
	 * @param remarks the remarks to set
	 */
	public void setRemarks(String remarks) {
		this.remarks = remarks;
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
	 * @return the procurementStatus
	 */
	public String getProcurementStatus() {
		return procurementStatus;
	}


	/**
	 * @param procurementStatus the procurementStatus to set
	 */
	public void setProcurementStatus(String procurementStatus) {
		this.procurementStatus = procurementStatus;
	}


	/**
	 * @return the dueDate
	 */
	public Date getDueDate() {
		return dueDate;
	}


	/**
	 * @param dueDate the dueDate to set
	 */
	public void setDueDate(Date dueDate) {
		this.dueDate = dueDate;
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
	 * @return the markingDate
	 */
	public Date getMarkingDate() {
		return markingDate;
	}


	/**
	 * @param markingDate the markingDate to set
	 */
	public void setMarkingDate(Date markingDate) {
		this.markingDate = markingDate;
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