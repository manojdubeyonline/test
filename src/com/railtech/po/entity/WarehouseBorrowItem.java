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

@Entity
@Table(name="warehouse_borrow_item")
public class WarehouseBorrowItem implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="borrow_item_id")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer borrowItemId;
	
	@ManyToOne
	@JoinColumn(name="item_code_id")
	private Code itemCode;
	
	@Column(name="borrow_qty")
	private double borrowQty;
	
	@ManyToOne
	@JoinColumn(name="unit_id")
	private Unit unit;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="borrow_id")
	@JsonBackReference
	private WarehouseBorrow warehouseBorrow;
	
	@ManyToOne
	@JoinColumn(name="requisitionId")
	private Requisition requisition;
	
	@ManyToOne
	@JoinColumn(name="requisitionItemId")
	private RequisitionItem requisitionItem;
	
	@ManyToOne
	@JoinColumn(name="procurementId")
	private Procurement procurement;
	
	@Column(name="last_modified")
	private Timestamp lastModified;

	@ManyToOne
	@JoinColumn(name="modifiedby")
	private User modifiedByUser;

	/**
	 * @return the borrowItemId
	 */
	public Integer getBorrowItemId() {
		return borrowItemId;
	}

	/**
	 * @param borrowItemId the borrowItemId to set
	 */
	public void setBorrowItemId(Integer borrowItemId) {
		this.borrowItemId = borrowItemId;
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
	 * @return the borrowQty
	 */
	public double getBorrowQty() {
		return borrowQty;
	}

	/**
	 * @param borrowQty the borrowQty to set
	 */
	public void setBorrowQty(double borrowQty) {
		this.borrowQty = borrowQty;
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
	 * @return the warehouseBorrow
	 */
	public WarehouseBorrow getWarehouseBorrow() {
		return warehouseBorrow;
	}

	/**
	 * @param warehouseBorrow the warehouseBorrow to set
	 */
	public void setWarehouseBorrow(WarehouseBorrow warehouseBorrow) {
		this.warehouseBorrow = warehouseBorrow;
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
	 * @return the requisitionItem
	 */
	public RequisitionItem getRequisitionItem() {
		return requisitionItem;
	}

	/**
	 * @param requisitionItem the requisitionItem to set
	 */
	public void setRequisitionItem(RequisitionItem requisitionItem) {
		this.requisitionItem = requisitionItem;
	}

	/**
	 * @return the procurement
	 */
	public Procurement getProcurement() {
		return procurement;
	}

	/**
	 * @param procurement the procurement to set
	 */
	public void setProcurement(Procurement procurement) {
		this.procurement = procurement;
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

}
