package com.railtech.po.entity;

import java.io.Serializable;
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


/**
 * The persistent class for the vender_master database table.
 * 
 */
@Entity
@Table(name="vender_master")
public class Vendor implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="client_id")
	private int vendorId;

	@Column(name="client_name")
	private String vendorName;


	@Column(name="attn")
	private String attn;
	
	
	
	@Column(name="modified_by")
	private String modifiedBy;

	@Column(name="purchase")
	private String purchase;

	@Column(name="job_work")
	private String jobWork;
	
	@Column(name="repair_work")
	private String repairWork;
	
	@Column(name="last_modified")
	@Temporal(TemporalType.TIMESTAMP)
	private Date lastModified;
	
	

	/**
	 * @return the vendorId
	 */
	public int getVendorId() {
		return vendorId;
	}

	/**
	 * @param vendorId the vendorId to set
	 */
	public void setVendorId(int vendorId) {
		this.vendorId = vendorId;
	}

	/**
	 * @return the vendorName
	 */
	public String getVendorName() {
		return vendorName;
	}

	/**
	 * @param vendorName the vendorName to set
	 */
	public void setVendorName(String vendorName) {
		this.vendorName = vendorName;
	}

	/**
	 * @return the attn
	 */
	public String getAttn() {
		return attn;
	}

	/**
	 * @param attn the attn to set
	 */
	public void setAttn(String attn) {
		this.attn = attn;
	}

	

	/**
	 * @return the purchase
	 */
	public String getPurchase() {
		return purchase;
	}

	/**
	 * @return the modifiedBy
	 */
	public String getModifiedBy() {
		return modifiedBy;
	}

	/**
	 * @param modifiedBy the modifiedBy to set
	 */
	public void setModifiedBy(String modifiedBy) {
		this.modifiedBy = modifiedBy;
	}

	/**
	 * @param purchase the purchase to set
	 */
	public void setPurchase(String purchase) {
		this.purchase = purchase;
	}

	/**
	 * @return the jobWork
	 */
	public String getJobWork() {
		return jobWork;
	}

	/**
	 * @param jobWork the jobWork to set
	 */
	public void setJobWork(String jobWork) {
		this.jobWork = jobWork;
	}

	/**
	 * @return the repairWork
	 */
	public String getRepairWork() {
		return repairWork;
	}

	/**
	 * @param repairWork the repairWork to set
	 */
	public void setRepairWork(String repairWork) {
		this.repairWork = repairWork;
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