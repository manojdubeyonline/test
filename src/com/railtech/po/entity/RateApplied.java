package com.railtech.po.entity;

import java.io.Serializable;

import javax.persistence.CascadeType;
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
import org.codehaus.jackson.annotate.JsonIgnoreProperties;

@Entity
@Table(name="rate_applied")
public class RateApplied implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="rate_applied_id")
	private Integer rateAppliedId;
	
	
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name="rate_id")
	private Rate rate;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="masterKeyId")
	@JsonBackReference
	private PurchaseOrder masterKeyId;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="itemKeyId")
	@JsonBackReference
	private PurchaseOrderItem itemKeyId;
	private Double appliedAmount;
	
	private String levelStatus;
	/**
	 * @return the rate
	 */
	public Rate getRate() {
		return rate;
	}
	/**
	 * @param rate the rate to set
	 */
	public void setRate(Rate rate) {
		this.rate = rate;
	}
	/**
	 * @return the masterKeyId
	 */
	public PurchaseOrder getMasterKeyId() {
		return masterKeyId;
	}
	/**
	 * @param masterKeyId the masterKeyId to set
	 */
	public void setMasterKeyId(PurchaseOrder masterKeyId) {
		this.masterKeyId = masterKeyId;
	}
	/**
	 * @return the itemKeyId
	 */
	public PurchaseOrderItem getItemKeyId() {
		return itemKeyId;
	}
	/**
	 * @param itemKeyId the itemKeyId to set
	 */
	public void setItemKeyId(PurchaseOrderItem itemKeyId) {
		this.itemKeyId = itemKeyId;
	}
	/**
	 * @return the appliedAmount
	 */
	public Double getAppliedAmount() {
		return appliedAmount;
	}
	/**
	 * @param appliedAmount the appliedAmount to set
	 */
	public void setAppliedAmount(Double appliedAmount) {
		this.appliedAmount = appliedAmount;
	}
	/**
	 * @return the rateAppliedId
	 */
	public Integer getRateAppliedId() {
		return rateAppliedId;
	}
	/**
	 * @param rateAppliedId the rateAppliedId to set
	 */
	public void setRateAppliedId(Integer rateAppliedId) {
		this.rateAppliedId = rateAppliedId;
	}
	/**
	 * @return the levelStatus
	 */
	public String getLevelStatus() {
		return levelStatus;
	}
	/**
	 * @param levelStatus the levelStatus to set
	 */
	public void setLevelStatus(String levelStatus) {
		this.levelStatus = levelStatus;
	}
	

}
