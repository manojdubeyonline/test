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


/**
 * The persistent class for the requisition database table.
 * 
 */
@Entity
public class Requisition implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Long requisitionId;
	
	@Column(name="requisition_ref_no")
	private String requisitionRefNo;


	private String approvalComments;

	private String approvalStatus;

	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="ApprovedByUser")
	private User approvedByUser;

	private Date dueDate;

	private String fullFillmentStatus;

	private String remarks;

	@ManyToOne
	@JoinColumn(name="RequestedByUserId")
	private User requestedByUser;

	private Date requestedDate;
	
	@ManyToOne
	@JoinColumn(name="RequestedForFirm")
	private Firm requestedForFirm;
	
	@ManyToOne
	@JoinColumn(name="RequestedAtWareHouse")
	private Warehouse requestedAtWareHouse;
	
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "requisition", cascade=CascadeType.ALL)
	private Set<RequisitionItem> requisitionItems;
	

	public Requisition() {
	}

	public Long getRequisitionId() {
		return this.requisitionId;
	}

	public void setRequisitionId(Long requisitionId) {
		this.requisitionId = requisitionId;
	}

	public String getApprovalComments() {
		return this.approvalComments;
	}

	public void setApprovalComments(String approvalComments) {
		this.approvalComments = approvalComments;
	}

	public String getApprovalStatus() {
		return this.approvalStatus;
	}

	public void setApprovalStatus(String approvalStatus) {
		this.approvalStatus = approvalStatus;
	}



	public Date getDueDate() {
		return this.dueDate;
	}

	public void setDueDate(Date dueDate) {
		this.dueDate = dueDate;
	}

	
	public String getFullFillmentStatus() {
		return this.fullFillmentStatus;
	}

	public void setFullFillmentStatus(String fullFillmentStatus) {
		this.fullFillmentStatus = fullFillmentStatus;
	}

	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public Date getRequestedDate() {
		return this.requestedDate;
	}

	public void setRequestedDate(Date requestedDate) {
		this.requestedDate = requestedDate;
	}

	/**
	 * @return the approvedByUser
	 */
	public User getApprovedByUser() {
		return approvedByUser;
	}

	/**
	 * @param approvedByUser the approvedByUser to set
	 */
	public void setApprovedByUser(User approvedByUser) {
		this.approvedByUser = approvedByUser;
	}

	/**
	 * @return the requestedByUser
	 */
	public User getRequestedByUser() {
		return requestedByUser;
	}

	/**
	 * @param requestedByUser the requestedByUser to set
	 */
	public void setRequestedByUser(User requestedByUser) {
		this.requestedByUser = requestedByUser;
	}

	/**
	 * @return the requestedForFirm
	 */
	public Firm getRequestedForFirm() {
		return requestedForFirm;
	}

	/**
	 * @param requestedForFirm the requestedForFirm to set
	 */
	public void setRequestedForFirm(Firm requestedForFirm) {
		this.requestedForFirm = requestedForFirm;
	}

	/**
	 * @return the requestedAtWareHouse
	 */
	public Warehouse getRequestedAtWareHouse() {
		return requestedAtWareHouse;
	}

	/**
	 * @param requestedAtWareHouse the requestedAtWareHouse to set
	 */
	public void setRequestedAtWareHouse(Warehouse requestedAtWareHouse) {
		this.requestedAtWareHouse = requestedAtWareHouse;
	}

	/**
	 * @return the requisitionRefNo
	 */
	public String getRequisitionRefNo() {
		return requisitionRefNo;
	}

	/**
	 * @param requisitionRefNo the requisitionRefNo to set
	 */
	public void setRequisitionRefNo(String requisitionRefNo) {
		this.requisitionRefNo = requisitionRefNo;
	}

	/**
	 * @return the requisitionItems
	 */
	public Set<RequisitionItem> getRequisitionItems() {
		return requisitionItems;
	}

	/**
	 * @param requisitionItems the requisitionItems to set
	 */
	public void setRequisitionItems(Set<RequisitionItem> requisitionItems) {
		this.requisitionItems = requisitionItems;
	}

	
	
	
	
}