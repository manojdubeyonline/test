/**
 * 
 */
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

/**
 * @author Sachin
 *
 */
/**
 * The persistent class for the gr_rate_applied database table.
 * 
 */
@Entity
@Table(name="gr_rate_applied")
public class GRRateApplied implements Serializable{
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="gr_rate_id")
	private Integer grRateId;
	
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name="rate_id")
	private Rate rate;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="grId")
	@JsonBackReference
	private GRPO grId;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="grRecieptId")
	@JsonBackReference
	private GRPOReceiptEntry grRecieptId;
	
	private Double appliedAmount;
	
	private String levelStatus;

	/**
	 * @return the grRateId
	 */
	public Integer getGrRateId() {
		return grRateId;
	}

	/**
	 * @param grRateId the grRateId to set
	 */
	public void setGrRateId(Integer grRateId) {
		this.grRateId = grRateId;
	}

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
	 * @return the grId
	 */
	public GRPO getGrId() {
		return grId;
	}

	/**
	 * @param grId the grId to set
	 */
	public void setGrId(GRPO grId) {
		this.grId = grId;
	}

	/**
	 * @return the grRecieptId
	 */
	public GRPOReceiptEntry getGrRecieptId() {
		return grRecieptId;
	}

	/**
	 * @param grRecieptId the grRecieptId to set
	 */
	public void setGrRecieptId(GRPOReceiptEntry grRecieptId) {
		this.grRecieptId = grRecieptId;
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
