/**
 * 
 */
package com.railtech.po.entity;

import java.io.Serializable;
import java.sql.Timestamp;
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
	private Procurement procurementMarking;
	
	

	@ManyToOne
	@JoinColumn(name="item_code_id")
	private Code itemCode;
	

	@Column(name="inward_qty")
	private Float inwardQty;
	
	@Column(name="gr_approve_qty")
	private Float grApproveQty;

	@ManyToOne
	@JoinColumn(name="unit_id")
	private Unit unit;
	
	
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy ="grRecieptId", cascade=CascadeType.ALL)
	private Set<GRRateApplied> itemLevelGRRates;
	
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
	 * @return the grApproveQty
	 */
	public Float getGrApproveQty() {
		return grApproveQty;
	}

	/**
	 * @param grApproveQty the grApproveQty to set
	 */
	public void setGrApproveQty(Float grApproveQty) {
		this.grApproveQty = grApproveQty;
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
	 * @return the itemLevelGRRates
	 */
	public Set<GRRateApplied> getItemLevelGRRates() {
		return itemLevelGRRates;
	}

	/**
	 * @param itemLevelGRRates the itemLevelGRRates to set
	 */
	public void setItemLevelGRRates(Set<GRRateApplied> itemLevelGRRates) {
		this.itemLevelGRRates = itemLevelGRRates;
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
	 * @return the procurementMarking
	 */
	public Procurement getProcurementMarking() {
		return procurementMarking;
	}

	/**
	 * @param procurementMarking the procurementMarking to set
	 */
	public void setProcurementMarking(Procurement procurementMarking) {
		this.procurementMarking = procurementMarking;
	}
	
	
	
}
