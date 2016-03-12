/**
 * 
 */
package com.railtech.po.entity;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.codehaus.jackson.annotate.JsonBackReference;

/**
 * The persistent class for the grpo_receipt_enrty database table.
 * 
 */
@Entity
@Table(name="grpo_receipt_enrty")
public class GRPOReceiptEntry implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="grpo_entry_id")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer grpoEntryId;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="grpo_id")
	@JsonBackReference
	private GRPO grpo;
	
	@ManyToOne
	@JoinColumn(name="order_id")
	private PurchaseOrder orderId;
	
	@ManyToOne
	@JoinColumn(name="order_item_id")
	private PurchaseOrderItem orderItemId;
	
	@ManyToOne
	@JoinColumn(name="marking_id")
	private Procurement markingId;
	
	@ManyToOne
	@JoinColumn(name="item_code_id")
	private Code itemCode;
	

	@Column(name="inward_qty")
	private Float inwardQty;

	@ManyToOne
	@JoinColumn(name="unit_id")
	private Unit unit;
	
	@Column(name="basic_rate")
	private Double basicRate;
	
	@Column(name="last_modified")
	private Timestamp lastModified;

	/**
	 * @return the grpoEntryId
	 */
	public Integer getGrpoEntryId() {
		return grpoEntryId;
	}

	/**
	 * @param grpoEntryId the grpoEntryId to set
	 */
	public void setGrpoEntryId(Integer grpoEntryId) {
		this.grpoEntryId = grpoEntryId;
	}

	/**
	 * @return the grpo
	 */
	public GRPO getGrpo() {
		return grpo;
	}

	/**
	 * @param grpo the grpo to set
	 */
	public void setGrpo(GRPO grpo) {
		this.grpo = grpo;
	}

	/**
	 * @return the orderId
	 */
	public PurchaseOrder getOrderId() {
		return orderId;
	}

	/**
	 * @param orderId the orderId to set
	 */
	public void setOrderId(PurchaseOrder orderId) {
		this.orderId = orderId;
	}

	/**
	 * @return the orderItemId
	 */
	public PurchaseOrderItem getOrderItemId() {
		return orderItemId;
	}

	/**
	 * @param orderItemId the orderItemId to set
	 */
	public void setOrderItemId(PurchaseOrderItem orderItemId) {
		this.orderItemId = orderItemId;
	}

	/**
	 * @return the markingId
	 */
	public Procurement getMarkingId() {
		return markingId;
	}

	/**
	 * @param markingId the markingId to set
	 */
	public void setMarkingId(Procurement markingId) {
		this.markingId = markingId;
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
	 * @return the inwardQty
	 */
	public Float getInwardQty() {
		return inwardQty;
	}

	/**
	 * @param inwardQty the inwardQty to set
	 */
	public void setInwardQty(Float inwardQty) {
		this.inwardQty = inwardQty;
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
	 * @return the basicRate
	 */
	public Double getBasicRate() {
		return basicRate;
	}

	/**
	 * @param basicRate the basicRate to set
	 */
	public void setBasicRate(Double basicRate) {
		this.basicRate = basicRate;
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
