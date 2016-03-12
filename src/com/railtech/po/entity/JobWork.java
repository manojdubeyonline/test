/**
 * 
 */
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
 * The persistent class for the job_work_order database table.
 * 
 */
@Entity
@Table(name="job_work_order")
public class JobWork implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="job_work_id")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer jobWorkId;
	
	@Column(name="job_work_order_No")
	private String jobWorkOrderNo;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "jobWork", cascade=CascadeType.ALL)
	private Set<JobWorkItemMaster> masterItems;
	
	@ManyToOne
	@JoinColumn(name="firm_id")
	private Firm firm;
	

	@Column(name="quotation_no")
	private String quotationNo;
	
	@ManyToOne
	@JoinColumn(name="vendor_id")
	private Vendor vendor;
	
	@Column(name="quotation_date")
	private Date quotationDate;
	
	@Column(name="job_work_date")
	private Date jobWorkDate;
	
	
	
	@Column(name="total_amount")
	private double totalAmount;
	
	@Column(name="remarks")
	private String remarks;
	
	@Column(name="instructor_name")
	private String instructorName;
	
	@Column(name="instructor_contact")
	private String instructorContactNo;
	
	@Column(name="instructor_mail")
	private String instructorMail;
	
	@ManyToOne
	@JoinColumn(name="added_by")
	private User addByUser;
	
	@Column(name="last_modified")
	@Temporal(TemporalType.TIMESTAMP)
	private Date lastModified;

	/**
	 * @return the jobWorkId
	 */
	public Integer getJobWorkId() {
		return jobWorkId;
	}

	/**
	 * @param jobWorkId the jobWorkId to set
	 */
	public void setJobWorkId(Integer jobWorkId) {
		this.jobWorkId = jobWorkId;
	}

	/**
	 * @return the jobWorkOrderNo
	 */
	public String getJobWorkOrderNo() {
		return jobWorkOrderNo;
	}

	/**
	 * @param jobWorkOrderNo the jobWorkOrderNo to set
	 */
	public void setJobWorkOrderNo(String jobWorkOrderNo) {
		this.jobWorkOrderNo = jobWorkOrderNo;
	}

	/**
	 * @return the masterItems
	 */
	public Set<JobWorkItemMaster> getMasterItems() {
		return masterItems;
	}

	/**
	 * @param masterItems the masterItems to set
	 */
	public void setMasterItems(Set<JobWorkItemMaster> masterItems) {
		this.masterItems = masterItems;
	}

	/**
	 * @return the firm
	 */
	public Firm getFirm() {
		return firm;
	}

	/**
	 * @param firm the firm to set
	 */
	public void setFirm(Firm firm) {
		this.firm = firm;
	}

	/**
	 * @return the quotationNo
	 */
	public String getQuotationNo() {
		return quotationNo;
	}

	/**
	 * @param quotationNo the quotationNo to set
	 */
	public void setQuotationNo(String quotationNo) {
		this.quotationNo = quotationNo;
	}

	/**
	 * @return the vendor
	 */
	public Vendor getVendor() {
		return vendor;
	}

	/**
	 * @param vendor the vendor to set
	 */
	public void setVendor(Vendor vendor) {
		this.vendor = vendor;
	}

	/**
	 * @return the quotationDate
	 */
	public Date getQuotationDate() {
		return quotationDate;
	}

	/**
	 * @param quotationDate the quotationDate to set
	 */
	public void setQuotationDate(Date quotationDate) {
		this.quotationDate = quotationDate;
	}

	/**
	 * @return the jobWorkDate
	 */
	public Date getJobWorkDate() {
		return jobWorkDate;
	}

	/**
	 * @param jobWorkDate the jobWorkDate to set
	 */
	public void setJobWorkDate(Date jobWorkDate) {
		this.jobWorkDate = jobWorkDate;
	}

	
	/**
	 * @return the totalAmount
	 */
	public double getTotalAmount() {
		return totalAmount;
	}

	/**
	 * @param totalAmount the totalAmount to set
	 */
	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}

	/**
	 * @return the remarks
	 */
	public String getRemarks() {
		return remarks;
	}

	/**
	 * @param remarks the remarks to set
	 */
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	/**
	 * @return the instructorName
	 */
	public String getInstructorName() {
		return instructorName;
	}

	/**
	 * @param instructorName the instructorName to set
	 */
	public void setInstructorName(String instructorName) {
		this.instructorName = instructorName;
	}

	/**
	 * @return the instructorContactNo
	 */
	public String getInstructorContactNo() {
		return instructorContactNo;
	}

	/**
	 * @param instructorContactNo the instructorContactNo to set
	 */
	public void setInstructorContactNo(String instructorContactNo) {
		this.instructorContactNo = instructorContactNo;
	}

	/**
	 * @return the instructorMail
	 */
	public String getInstructorMail() {
		return instructorMail;
	}

	/**
	 * @param instructorMail the instructorMail to set
	 */
	public void setInstructorMail(String instructorMail) {
		this.instructorMail = instructorMail;
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

	/**
	 * @return the addByUser
	 */
	public User getAddByUser() {
		return addByUser;
	}

	/**
	 * @param addByUser the addByUser to set
	 */
	public void setAddByUser(User addByUser) {
		this.addByUser = addByUser;
	}

	
	
	
	
}
