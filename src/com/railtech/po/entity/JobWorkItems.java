/**
 * 
 */
package com.railtech.po.entity;

import java.io.Serializable;
import java.sql.Timestamp;
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

import org.codehaus.jackson.annotate.JsonBackReference;

/**
 * The persistent class for the job_work_items database table.
 * 
 */
@Entity
@Table(name="job_work_items")
public class JobWorkItems implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="item_key_id")
	private Integer itemKeyId;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="job_work_id")
	@JsonBackReference
	private JobWork jobWork;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="job_work_item_master_id")
	@JsonBackReference
	private JobWorkItemMaster jobWorkItemMaster;
	

	@ManyToOne
	@JoinColumn(name="item_code_id")
	private Code itemCode;
	
	
	private double qty;
	
	@ManyToOne
	@JoinColumn(name="unit_id")
	private Unit unit;

	@Column(name="basic_rate")
	private double basicRate;

	@Column(name="last_modified")
	private Timestamp lastModified;


	/**
	 * @return the itemKeyId
	 */
	public Integer getItemKeyId() {
		return itemKeyId;
	}


	/**
	 * @param itemKeyId the itemKeyId to set
	 */
	public void setItemKeyId(Integer itemKeyId) {
		this.itemKeyId = itemKeyId;
	}


	/**
	 * @return the jobWork
	 */
	public JobWork getJobWork() {
		return jobWork;
	}


	/**
	 * @param jobWork the jobWork to set
	 */
	public void setJobWork(JobWork jobWork) {
		this.jobWork = jobWork;
	}


	/**
	 * @return the jobWorkItemMaster
	 */
	public JobWorkItemMaster getJobWorkItemMaster() {
		return jobWorkItemMaster;
	}


	/**
	 * @param jobWorkItemMaster the jobWorkItemMaster to set
	 */
	public void setJobWorkItemMaster(JobWorkItemMaster jobWorkItemMaster) {
		this.jobWorkItemMaster = jobWorkItemMaster;
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
	 * @return the basicRate
	 */
	public double getBasicRate() {
		return basicRate;
	}


	/**
	 * @param basicRate the basicRate to set
	 */
	public void setBasicRate(double basicRate) {
		this.basicRate = basicRate;
	}

	

}
