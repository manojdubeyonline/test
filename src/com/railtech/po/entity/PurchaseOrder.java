package com.railtech.po.entity;


import java.io.Serializable;
import java.util.Date;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * The persistent class for the purchase_order database table.
 * 
 */
@Entity
@Table(name="purchase_order")
public class PurchaseOrder implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="purchase_order_id")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer orderId;
	
	@Column(name="purchase_order_number")
	private String purchaseOrderNo;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "purchaseOrder", cascade=CascadeType.ALL)
	private Set<PurchaseOrderItem> orderItems;
	
	@ManyToOne
	@JoinColumn(name="firm_id")
	private Firm firm;
	
	@ManyToOne
	@JoinColumn(name="ware_id")
	private Warehouse warehouse;
	
	@ManyToOne
	@JoinColumn(name="vendor_id")
	private Vendor vendor;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "masterKeyId", cascade=CascadeType.ALL)
	private Set<RateApplied> orderLevelRates;
	
	/**
	 * @return the orderItems
	 */
	public Set<PurchaseOrderItem> getOrderItems() {
		return orderItems;
	}


	/**
	 * @param orderItems the orderItems to set
	 */
	public void setOrderItems(Set<PurchaseOrderItem> orderItems) {
		this.orderItems = orderItems;
	}
	
	@ManyToOne
	@JoinColumn(name="added_by")
	private User addedBy;

	@ManyToOne
	@JoinColumn(name="approved_by")
	private User approvedBy;
	
	@Column(name="order_type")
	private String orderType;

	@Column(name="remarks")
	private String remarks;
	
	@Column(name="approval_status")
	private String approvalStatus;
	
	@Column(name="approval_comments")
	private String approvalComments;
	
	
	@Column(name="fullfillment_status")
	private String fullFillementStatus;
		
	@Column(name="due_date")
	private Date dueDate;
	
	@Column(name="approved_date")
	private Date approvalDate;
	
	@Column(name="added_date")
	private Date dateAdded;
	
	@Column(name="last_modified")
	@Temporal(TemporalType.TIMESTAMP)
	private Date lastModified;

	
	public PurchaseOrder() {
	}


	/**
	 * @return the markingId
	 */
	public Integer getMarkingId() {
		return orderId;
	}





	/**
	 * @return the orderId
	 */
	public Integer getOrderId() {
		return orderId;
	}


	/**
	 * @param orderId the orderId to set
	 */
	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
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


	public String getRemarks() {
		return remarks;
	}


	
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
	 * @return the fullFillementStatus
	 */
	public String getFullFillementStatus() {
		return fullFillementStatus;
	}


	/**
	 * @param fullFillementStatus the fullFillementStatus to set
	 */
	public void setFullFillementStatus(String fullFillementStatus) {
		this.fullFillementStatus = fullFillementStatus;
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
	 * @return the dateAdded
	 */
	public Date getDateAdded() {
		return dateAdded;
	}


	/**
	 * @param dateAdded the dateAdded to set
	 */
	public void setDateAdded(Date dateAdded) {
		this.dateAdded = dateAdded;
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


	/**
	 * @return the orderType
	 */
	public String getOrderType() {
		return orderType;
	}


	/**
	 * @param orderType the orderType to set
	 */
	public void setOrderType(String orderType) {
		this.orderType = orderType;
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


}