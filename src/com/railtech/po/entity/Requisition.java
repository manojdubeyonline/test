package com.railtech.po.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * The persistent class for the requisition database table.
 * 
 */
@Entity
public class Requisition implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private String requisitionId;

	private String approvalComments;

	private String approvalStatus;

	@ManyToOne
	@JoinColumn(name="ApprovedByUser")
	private User approvedByUser;

	@Temporal(TemporalType.DATE)
	private Date dueDate;

	@ManyToOne
	@JoinColumn(name="FullFilledByUser")
	private User fullFilledByUser;

	private int fullFillmentComments;

	private String fullFillmentStatus;

	@ManyToOne
	@JoinColumn(name="ItemCode")
	private Item item;

	private double qty;

	private String remarks;

	@ManyToOne
	@JoinColumn(name="RequestedByUserId")
	private User requestedByUser;

	@Temporal(TemporalType.DATE)
	private Date requestedDate;
	
	@ManyToOne
	@JoinColumn(name="RequestedForFirm")
	private Firm requestedForFirm;
	
	@ManyToOne
	@JoinColumn(name="RequestedAtWareHouse")
	private Warehouse requestedAtWareHouse;

	public Requisition() {
	}

	public String getRequisitionId() {
		return this.requisitionId;
	}

	public void setRequisitionId(String requisitionId) {
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

	
	public int getFullFillmentComments() {
		return this.fullFillmentComments;
	}

	public void setFullFillmentComments(int fullFillmentComments) {
		this.fullFillmentComments = fullFillmentComments;
	}

	public String getFullFillmentStatus() {
		return this.fullFillmentStatus;
	}

	public void setFullFillmentStatus(String fullFillmentStatus) {
		this.fullFillmentStatus = fullFillmentStatus;
	}

	public double getQty() {
		return this.qty;
	}

	public void setQty(double qty) {
		this.qty = qty;
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
	 * @return the fullFilledByUser
	 */
	public User getFullFilledByUser() {
		return fullFilledByUser;
	}

	/**
	 * @param fullFilledByUser the fullFilledByUser to set
	 */
	public void setFullFilledByUser(User fullFilledByUser) {
		this.fullFilledByUser = fullFilledByUser;
	}

	/**
	 * @return the item
	 */
	public Item getItem() {
		return item;
	}

	/**
	 * @param item the item to set
	 */
	public void setItem(Item item) {
		this.item = item;
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

	
	
	
}