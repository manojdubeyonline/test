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

@Entity
@Table(name="item_issue")
public class ItemIssue implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="item_issue_id")
	private Integer itemIssueId;
	
	@Column(name="issueRefNo")
	private String issueRefNo;
	
	@ManyToOne
	@JoinColumn(name="requisition_id")
	private Requisition requisition;
	
	@ManyToOne
	@JoinColumn(name="requisition_item_key")
	private RequisitionItem requisitionItem;
	
	@ManyToOne
	@JoinColumn(name="code_id")
	private Code itemCode;

	@ManyToOne
	@JoinColumn(name="issued_by_user")
	private User issuedBy;

	@Column(name="issue_date")
	private Date issueDate;
	
	@Column(name="issue_qty")
	public Double issueQty;

	public Integer getItemIssueId() {
		return itemIssueId;
	}

	public void setItemIssueId(Integer itemIssueId) {
		this.itemIssueId = itemIssueId;
	}

	/**
	 * @return the issueRefNo
	 */
	public String getIssueRefNo() {
		return issueRefNo;
	}

	/**
	 * @param issueRefNo the issueRefNo to set
	 */
	public void setIssueRefNo(String issueRefNo) {
		this.issueRefNo = issueRefNo;
	}

	public Requisition getRequisition() {
		return requisition;
	}

	public void setRequisition(Requisition requisition) {
		this.requisition = requisition;
	}

	public RequisitionItem getRequisitionItem() {
		return requisitionItem;
	}

	public void setRequisitionItem(RequisitionItem requisitionItem) {
		this.requisitionItem = requisitionItem;
	}

	public Code getItemCode() {
		return itemCode;
	}

	public void setItemCode(Code itemCode) {
		this.itemCode = itemCode;
	}

	public User getIssuedBy() {
		return issuedBy;
	}

	public void setIssuedBy(User issuedBy) {
		this.issuedBy = issuedBy;
	}

	public Date getIssueDate() {
		return issueDate;
	}

	public void setIssueDate(Date issueDate) {
		this.issueDate = issueDate;
	}

	public Double getIssueQty() {
		return issueQty;
	}

	public void setIssueQty(Double issueQty) {
		this.issueQty = issueQty;
	}
	
	

}
