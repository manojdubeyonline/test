package com.railtech.po.entity;


import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;


/**
 * The persistent class for the item_stock database table.
 * 
 */
@Entity
@Table(name="item_stock")
public class ItemStock implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private ItemStockPK itemStockPK;

	@Column(name="available_qty")
	private double availableQty;

	@Column(name="last_modified")
	private Timestamp lastModified;

	@Column(name="modified_by")
	private int modifiedBy;

	@Column(name="on_hold_qty")
	private double onHoldQty;
	
	@Column(name="requisitioned_qty")
	private double requisitionedQty;

	@Column(name="ordered_qty")
	private double orderedQty;
	
	public ItemStock() {
	}

	
	public ItemStockPK getItemStockPK() {
		return itemStockPK;
	}


	public void setItemStockPK(ItemStockPK itemStockPK) {
		this.itemStockPK = itemStockPK;
	}


	public double getAvailableQty() {
		return this.availableQty;
	}

	public void setAvailableQty(double availableQty) {
		this.availableQty = availableQty;
	}

	public Timestamp getLastModified() {
		return this.lastModified;
	}

	public void setLastModified(Timestamp lastModified) {
		this.lastModified = lastModified;
	}

	public int getModifiedBy() {
		return this.modifiedBy;
	}

	public void setModifiedBy(int modifiedBy) {
		this.modifiedBy = modifiedBy;
	}

	public double getOnHoldQty() {
		return this.onHoldQty;
	}

	public void setOnHoldQty(double onHoldQty) {
		this.onHoldQty = onHoldQty;
	}


	public double getRequisitionedQty() {
		return requisitionedQty;
	}


	public void setRequisitionedQty(double requisitionedQty) {
		this.requisitionedQty = requisitionedQty;
	}


	public double getOrderedQty() {
		return orderedQty;
	}


	public void setOrderedQty(double orderedQty) {
		this.orderedQty = orderedQty;
	}

	
		

}