package com.railtech.po.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name="rate")
public class Rate implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="rate_id")
	private Integer rateId;
	
	private String rateName;
	private String rateApplicableType;
	private String percentage;
	private String applicableFinancialYear;
	private Integer lastModifiedBy;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date lastModified;
	
	
	public Integer getRateId() {
		return rateId;
	}

	public void setRateId(Integer rateId) {
		this.rateId = rateId;
	}

	public String getRateName() {
		return rateName;
	}
	
	public void setRateName(String rateName) {
		this.rateName = rateName;
	}
	
	public String getRateApplicableType() {
		return rateApplicableType;
	}
	
	public void setRateApplicableType(String rateApplicableType) {
		this.rateApplicableType = rateApplicableType;
	}

	public String getPercentage() {
		return percentage;
	}

	public void setPercentage(String percentage) {
		this.percentage = percentage;
	}
	
	public String getApplicableFinancialYear() {
		return applicableFinancialYear;
	}
	
	public void setApplicableFinancialYear(String applicableFinancialYear) {
		this.applicableFinancialYear = applicableFinancialYear;
	}

	/**
	 * @return the lastModifiedBy
	 */
	public Integer getLastModifiedBy() {
		return lastModifiedBy;
	}

	/**
	 * @param lastModifiedBy the lastModifiedBy to set
	 */
	public void setLastModifiedBy(Integer lastModifiedBy) {
		this.lastModifiedBy = lastModifiedBy;
	}

	/**
	 * @return the lastModified
	 */
	public Date getLastModified() {
		return lastModified;
	}

	/**
	 * @param lastModified the lastModified to set
	 */
	public void setLastModified(Date lastModified) {
		this.lastModified = lastModified;
	}
	

	
	
}
