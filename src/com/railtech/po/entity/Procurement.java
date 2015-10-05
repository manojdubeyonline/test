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
@Table(name="requisition_procurement_marking")
public class Procurement implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="marking_id")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer markingId;
	
	@ManyToOne
	@JoinColumn(name="item_code_id")
	private Code itemCode;
	
	@ManyToOne
	@JoinColumn(name="warehouse_id")
	private Warehouse warehouse;
	
	@ManyToOne
	@JoinColumn(name="marked_by")
	private User markedBy;

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
	
	@Column(name="procurement_qty")
	private double procurementQty;
	
	@ManyToOne
	@JoinColumn(name="unit")
	private Unit unit;
	
	@Column(name="due_date")
	private Date dueDate;
	
	@Column(name="approval_date")
	private Date approvalDate;
	
	@Column(name="marking_date")
	private Date markingDate;
	
	@Column(name="last_modified")
	@Temporal(TemporalType.TIMESTAMP)
	private Date lastModified;

	
	public Procurement() {
	}


	public Integer getMarkingId() {
		return markingId;
	}


	public void setMarkingId(Integer markingId) {
		this.markingId = markingId;
	}


	public Code getItemCode() {
		return itemCode;
	}


	public void setItemCode(Code itemCode) {
		this.itemCode = itemCode;
	}


	public Warehouse getWarehouse() {
		return warehouse;
	}


	public void setWarehouse(Warehouse warehouse) {
		this.warehouse = warehouse;
	}


	public User getMarkedBy() {
		return markedBy;
	}


	public void setMarkedBy(User markedBy) {
		this.markedBy = markedBy;
	}


	public User getApprovedBy() {
		return approvedBy;
	}


	public void setApprovedBy(User approvedBy) {
		this.approvedBy = approvedBy;
	}


	public String getProcurementType() {
		return procurementType;
	}


	public void setProcurementType(String procurementType) {
		this.procurementType = procurementType;
	}


	public String getRemarks() {
		return remarks;
	}


	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}


	public String getApprovalStatus() {
		return approvalStatus;
	}


	public void setApprovalStatus(String approvalStatus) {
		this.approvalStatus = approvalStatus;
	}


	public String getProcurementStatus() {
		return procurementStatus;
	}


	public void setProcurementStatus(String procurementStatus) {
		this.procurementStatus = procurementStatus;
	}


	public double getProcurementQty() {
		return procurementQty;
	}


	public void setProcurementQty(double procurementQty) {
		this.procurementQty = procurementQty;
	}


	public Date getApprovalDate() {
		return approvalDate;
	}


	public void setApprovalDate(Date approvalDate) {
		this.approvalDate = approvalDate;
	}


	public Date getMarkingDate() {
		return markingDate;
	}


	public void setMarkingDate(Date markingDate) {
		this.markingDate = markingDate;
	}


	public Date getLastModified() {
		return lastModified;
	}


	public void setLastModified(Date lastModified) {
		this.lastModified = lastModified;
	}


	public Date getDueDate() {
		return dueDate;
	}


	public void setDueDate(Date dueDate) {
		this.dueDate = dueDate;
	}


	public Unit getUnit() {
		return unit;
	}


	public void setUnit(Unit unit) {
		this.unit = unit;
	}

	

}