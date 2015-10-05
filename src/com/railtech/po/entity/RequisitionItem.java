package com.railtech.po.entity;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonBackReference;


/**
 * The persistent class for the requisition_item database table.
 * 
 */
@Entity
@Table(name="requisition_item")
public class RequisitionItem implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="item_key")
	private Integer itemKey;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="RequisitionId")
	@JsonBackReference
	private Requisition requisition;

	@ManyToOne
	@JoinColumn(name="code_id")
	private Code itemCode;
	
	@Column(name="last_modified")
	private Timestamp lastModified;

	@ManyToOne
	@JoinColumn(name="modifiedby")
	private User modifiedByUser;


	private Integer priority;

	private double qty;

	@Column(name="hist_qty")
	private double histQty;
	
	@ManyToOne
	@JoinColumn(name="unit_id")
	private Unit unit;

	
	@ManyToOne
	@JoinColumn(name="FullFilledByUser")
	private User fullFilledByUser;

	private String fullFillmentComments;

	private String fullFillmentStatus;

	private String remarks;

	public RequisitionItem() {
	}

	/**
	 * @return the itemKey
	 */
	public Integer getItemKey() {
		return itemKey;
	}

	/**
	 * @param itemKey the itemKey to set
	 */
	public void setItemKey(Integer itemKey) {
		this.itemKey = itemKey;
	}

	/**
	 * @return the requisition
	 */
	public Requisition getRequisition() {
		return requisition;
	}

	/**
	 * @param requisition the requisition to set
	 */
	public void setRequisition(Requisition requisition) {
		this.requisition = requisition;
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
	 * @return the lastModified
	 */
	public Timestamp getLastModified() {
		return lastModified;
	}

	/**
	 * @param lastModified the lastModified to set
	 */
	public void setLastModified(Timestamp lastModified) {
		this.lastModified = lastModified;
	}

	

	/**
	 * @return the modifiedByUser
	 */
	public User getModifiedByUser() {
		return modifiedByUser;
	}

	/**
	 * @param modifiedByUser the modifiedByUser to set
	 */
	public void setModifiedByUser(User modifiedByUser) {
		this.modifiedByUser = modifiedByUser;
	}

	/**
	 * @return the priority
	 */
	public Integer getPriority() {
		return priority;
	}

	/**
	 * @param priority the priority to set
	 */
	public void setPriority(Integer priority) {
		this.priority = priority;
	}

	/**
	 * @return the qty
	 */
	public double getQty() {
		return qty;
	}

	/**
	 * @param qty the qty to set
	 */
	public void setQty(double qty) {
		this.qty = qty;
	}

	
	public double getHistQty() {
		return histQty;
	}

	public void setHistQty(double histQty) {
		this.histQty = histQty;
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
	 * @return the fullFillmentComments
	 */
	public String getFullFillmentComments() {
		return fullFillmentComments;
	}

	/**
	 * @param fullFillmentComments the fullFillmentComments to set
	 */
	public void setFullFillmentComments(String fullFillmentComments) {
		this.fullFillmentComments = fullFillmentComments;
	}

	/**
	 * @return the fullFillmentStatus
	 */
	public String getFullFillmentStatus() {
		return fullFillmentStatus;
	}

	/**
	 * @param fullFillmentStatus the fullFillmentStatus to set
	 */
	public void setFullFillmentStatus(String fullFillmentStatus) {
		this.fullFillmentStatus = fullFillmentStatus;
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

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((itemCode == null) ? 0 : itemCode.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		RequisitionItem other = (RequisitionItem) obj;
		if (itemCode == null) {
			if (other.itemCode != null)
				return false;
		} else if (!itemCode.equals(other.itemCode))
			return false;
		return true;
	}

	
	
}