/**
 * 
 */
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
 * @author sachin
 *
 */


/**
 * The persistent class for the stock allocation item database table.
 * 
 */
@Entity
@Table(name="stock_allocation_item")
public class StockAllocationItem implements Serializable{
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="stock_item_id")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer stockItemId;
	
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="stock_id")
	@JsonBackReference
	private StockAllocation stockId;
	
	@ManyToOne
	@JoinColumn(name="item_code")
	private Code allocatedItem;
	
	@Column(name="allocated_qty")
	private Float allocatedQty;

	@ManyToOne
	@JoinColumn(name="unit_id")
	private Unit unit;
	
	@ManyToOne
	@JoinColumn(name="grpo_reciept_id")
	private GRPOReceiptEntry grpoRecieptId;
	
	@Column(name="last_modified")
	private Timestamp lastModified;

	/**
	 * @return the stockItemId
	 */
	public Integer getStockItemId() {
		return stockItemId;
	}

	/**
	 * @param stockItemId the stockItemId to set
	 */
	public void setStockItemId(Integer stockItemId) {
		this.stockItemId = stockItemId;
	}

	/**
	 * @return the stockId
	 */
	public StockAllocation getStockId() {
		return stockId;
	}

	/**
	 * @param stockId the stockId to set
	 */
	public void setStockId(StockAllocation stockId) {
		this.stockId = stockId;
	}

	/**
	 * @return the allocatedItem
	 */
	public Code getAllocatedItem() {
		return allocatedItem;
	}

	/**
	 * @param allocatedItem the allocatedItem to set
	 */
	public void setAllocatedItem(Code allocatedItem) {
		this.allocatedItem = allocatedItem;
	}

	/**
	 * @return the allocatedQty
	 */
	public Float getAllocatedQty() {
		return allocatedQty;
	}

	/**
	 * @param allocatedQty the allocatedQty to set
	 */
	public void setAllocatedQty(Float allocatedQty) {
		this.allocatedQty = allocatedQty;
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
	 * @return the grpoRecieptId
	 */
	public GRPOReceiptEntry getGrpoRecieptId() {
		return grpoRecieptId;
	}

	/**
	 * @param grpoRecieptId the grpoRecieptId to set
	 */
	public void setGrpoRecieptId(GRPOReceiptEntry grpoRecieptId) {
		this.grpoRecieptId = grpoRecieptId;
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

}
