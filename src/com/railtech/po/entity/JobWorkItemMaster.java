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
 * The persistent class for the job_work_item_master database table.
 * 
 */
@Entity
@Table(name="job_work_item_master")
public class JobWorkItemMaster implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="item_master_key")
	private Integer itemMasterKey;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="job_work_id")
	@JsonBackReference
	private JobWork jobWork;
	

	@ManyToOne
	@JoinColumn(name="item_code_id")
	private Code itemCode;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "jobWorkItemMaster", cascade=CascadeType.ALL)
	private Set<JobWorkItems> jobWorkItem;
	
	private double qty;
	
	@ManyToOne
	@JoinColumn(name="unit_id")
	private Unit unit;

	
	

	@Column(name="last_modified")
	private Timestamp lastModified;


	/**
	 * @return the itemMasterKey
	 */
	public Integer getItemMasterKey() {
		return itemMasterKey;
	}


	/**
	 * @param itemMasterKey the itemMasterKey to set
	 */
	public void setItemMasterKey(Integer itemMasterKey) {
		this.itemMasterKey = itemMasterKey;
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
	 * @return the jobWorkItem
	 */
	public Set<JobWorkItems> getJobWorkItem() {
		return jobWorkItem;
	}


	/**
	 * @param jobWorkItem the jobWorkItem to set
	 */
	public void setJobWorkItem(Set<JobWorkItems> jobWorkItem) {
		this.jobWorkItem = jobWorkItem;
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

	

}
