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
 * The persistent class for the purchase_order database table.
 * 
 */
@Entity
@Table(name="purchase_order")
public class PurchaseOrder implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="purchase_order_id")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer orderId;
	
	@Column(name="purchase_order_number")
	private String purchaseOrderNo;
	
	@OneToMany(cascade=CascadeType.ALL, mappedBy = "purchaseOrder",fetch = FetchType.LAZY)
	private Set<PurchaseOrderItem> orderItems;
	
	@ManyToOne
	@JoinColumn(name="firm_id")
	private Firm firm;
	
	
	
	@ManyToOne
	@JoinColumn(name="ware_id")
	private Warehouse warehouse;
	
	@ManyToOne
	@JoinColumn(name="vendor_id")
	private Vendor vendor;
	
	@ManyToOne
	@JoinColumn(name="location_id")
	private VendorDetails vendorDetail;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "masterKeyId", cascade=CascadeType.ALL)
	private Set<RateApplied> orderLevelRates;
	
	/**
	 * @return the orderItems
	 */
	public Set<PurchaseOrderItem> getOrderItems() {
		return orderItems;
	}


	/**
	 * @param orderItems the orderItems to set
	 */
	public void setOrderItems(Set<PurchaseOrderItem> orderItems) {
		this.orderItems = orderItems;
	}
	
	@ManyToOne
	@JoinColumn(name="added_by")
	private User addedBy;

	@ManyToOne
	@JoinColumn(name="approved_by")
	private User approvedBy;
	
	@Column(name="order_type")
	private String orderType;

	@Column(name="remarks")
	private String remarks;
	
	@Column(name="approval_status")
	private String approvalStatus;
	
	@Column(name="approval_comments")
	private String approvalComments;
	
	@Column(name="important_details")
	private String importantDetails;
	
	@Column(name="discount")
	private String discount;
	
	@Column(name="delivery_term")
	private String deliveryTerm;
	
	@Column(name="delivery_period")
	private String deliveryPeriod;
	
	@Column(name="freight")
	private String freight;
	
	@Column(name="packing")
	private String packing;
	
	@Column(name="sale_tax")
	private String saleTax;
	
	@Column(name="insurance")
	private String insurance;
	
	@Column(name="qty_tolerance")
	private String qtyTolerance;
	
	@Column(name="quality_assurance")
	private String qualityAssurance;
	
	@Column(name="payment_term")
	private String paymentTerm;
	
	@Column(name="instruction")
	private String otherInstruction;
	
	
	@Column(name="fullfillment_status")
	private String fullFillementStatus;
	
	@Column(name="instructor_name")
	private String instructorName;
	
	@Column(name="instructor_cont")
	private String instructorContact;
	
	@Column(name="instructor_email")
	private String instructorEmail;
	
	@Column(name="quotation_Detail")
	private String quotationDetail;
	
	@Column(name="quotation_Date")
	private Date quotationDate;
	
	@Column(name="cont_person")
	private String contactPerson;
	
	
		
	@Column(name="due_date")
	private Date dueDate;
	
	@Column(name="approved_date")
	private Date approvalDate;
	
	@Column(name="added_date")
	private Date dateAdded;
	
	@Column(name="last_modified")
	@Temporal(TemporalType.TIMESTAMP)
	private Date lastModified;

	
	public PurchaseOrder() {
	}


	/**
	 * @return the markingId
	 */
	public Integer getMarkingId() {
		return orderId;
	}





	/**
	 * @return the orderId
	 */
	public Integer getOrderId() {
		return orderId;
	}


	/**
	 * @param orderId the orderId to set
	 */
	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}


	/**
	 * @return the purchaseOrderNo
	 */
	public String getPurchaseOrderNo() {
		return purchaseOrderNo;
	}


	/**
	 * @param purchaseOrderNo the purchaseOrderNo to set
	 */
	public void setPurchaseOrderNo(String purchaseOrderNo) {
		this.purchaseOrderNo = purchaseOrderNo;
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
	 * @return the warehouse
	 */
	public Warehouse getWarehouse() {
		return warehouse;
	}


	/**
	 * @param warehouse the warehouse to set
	 */
	public void setWarehouse(Warehouse warehouse) {
		this.warehouse = warehouse;
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
	 * @return the addedBy
	 */
	public User getAddedBy() {
		return addedBy;
	}


	/**
	 * @param addedBy the addedBy to set
	 */
	public void setAddedBy(User addedBy) {
		this.addedBy = addedBy;
	}


	/**
	 * @return the approvedBy
	 */
	public User getApprovedBy() {
		return approvedBy;
	}


	/**
	 * @param approvedBy the approvedBy to set
	 */
	public void setApprovedBy(User approvedBy) {
		this.approvedBy = approvedBy;
	}


	public String getRemarks() {
		return remarks;
	}


	
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}


	/**
	 * @return the approvalStatus
	 */
	public String getApprovalStatus() {
		return approvalStatus;
	}


	/**
	 * @param approvalStatus the approvalStatus to set
	 */
	public void setApprovalStatus(String approvalStatus) {
		this.approvalStatus = approvalStatus;
	}



	/**
	 * @return the fullFillementStatus
	 */
	public String getFullFillementStatus() {
		return fullFillementStatus;
	}


	/**
	 * @param fullFillementStatus the fullFillementStatus to set
	 */
	public void setFullFillementStatus(String fullFillementStatus) {
		this.fullFillementStatus = fullFillementStatus;
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
	 * @return the instructorContact
	 */
	public String getInstructorContact() {
		return instructorContact;
	}


	/**
	 * @param instructorContact the instructorContact to set
	 */
	public void setInstructorContact(String instructorContact) {
		this.instructorContact = instructorContact;
	}


	/**
	 * @return the instructorEmail
	 */
	public String getInstructorEmail() {
		return instructorEmail;
	}


	/**
	 * @param instructorEmail the instructorEmail to set
	 */
	public void setInstructorEmail(String instructorEmail) {
		this.instructorEmail = instructorEmail;
	}


	
	/**
	 * @return the dueDate
	 */
	public Date getDueDate() {
		return dueDate;
	}


	/**
	 * @param dueDate the dueDate to set
	 */
	public void setDueDate(Date dueDate) {
		this.dueDate = dueDate;
	}


	/**
	 * @return the approvalDate
	 */
	public Date getApprovalDate() {
		return approvalDate;
	}


	/**
	 * @param approvalDate the approvalDate to set
	 */
	public void setApprovalDate(Date approvalDate) {
		this.approvalDate = approvalDate;
	}


	/**
	 * @return the dateAdded
	 */
	public Date getDateAdded() {
		return dateAdded;
	}


	/**
	 * @param dateAdded the dateAdded to set
	 */
	public void setDateAdded(Date dateAdded) {
		this.dateAdded = dateAdded;
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
	 * @return the orderType
	 */
	public String getOrderType() {
		return orderType;
	}


	/**
	 * @param orderType the orderType to set
	 */
	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}


	/**
	 * @return the approvalComments
	 */
	public String getApprovalComments() {
		return approvalComments;
	}


	/**
	 * @param approvalComments the approvalComments to set
	 */
	public void setApprovalComments(String approvalComments) {
		this.approvalComments = approvalComments;
	}


	/**
	 * @return the orderLevelRates
	 */
	public Set<RateApplied> getOrderLevelRates() {
		return orderLevelRates;
	}


	/**
	 * @param orderLevelRates the orderLevelRates to set
	 */
	public void setOrderLevelRates(Set<RateApplied> orderLevelRates) {
		this.orderLevelRates = orderLevelRates;
	}


	/**
	 * @return the vendorDetail
	 */
	public VendorDetails getVendorDetail() {
		return vendorDetail;
	}


	/**
	 * @param vendorDetail the vendorDetail to set
	 */
	public void setVendorDetail(VendorDetails vendorDetail) {
		this.vendorDetail = vendorDetail;
	}


	/**
	 * @return the importantDetails
	 */
	public String getImportantDetails() {
		return importantDetails;
	}


	/**
	 * @param importantDetails the importantDetails to set
	 */
	public void setImportantDetails(String importantDetails) {
		this.importantDetails = importantDetails;
	}


	/**
	 * @return the discount
	 */
	public String getDiscount() {
		return discount;
	}


	/**
	 * @param discount the discount to set
	 */
	public void setDiscount(String discount) {
		this.discount = discount;
	}


	/**
	 * @return the deliveryTerm
	 */
	public String getDeliveryTerm() {
		return deliveryTerm;
	}


	/**
	 * @param deliveryTerm the deliveryTerm to set
	 */
	public void setDeliveryTerm(String deliveryTerm) {
		this.deliveryTerm = deliveryTerm;
	}


	/**
	 * @return the deliveryPeriod
	 */
	public String getDeliveryPeriod() {
		return deliveryPeriod;
	}


	/**
	 * @param deliveryPeriod the deliveryPeriod to set
	 */
	public void setDeliveryPeriod(String deliveryPeriod) {
		this.deliveryPeriod = deliveryPeriod;
	}


	/**
	 * @return the freight
	 */
	public String getFreight() {
		return freight;
	}


	/**
	 * @param freight the freight to set
	 */
	public void setFreight(String freight) {
		this.freight = freight;
	}


	/**
	 * @return the packing
	 */
	public String getPacking() {
		return packing;
	}


	/**
	 * @param packing the packing to set
	 */
	public void setPacking(String packing) {
		this.packing = packing;
	}


	/**
	 * @return the saleTax
	 */
	public String getSaleTax() {
		return saleTax;
	}


	/**
	 * @param saleTax the saleTax to set
	 */
	public void setSaleTax(String saleTax) {
		this.saleTax = saleTax;
	}


	/**
	 * @return the insurance
	 */
	public String getInsurance() {
		return insurance;
	}


	/**
	 * @param insurance the insurance to set
	 */
	public void setInsurance(String insurance) {
		this.insurance = insurance;
	}


	


	/**
	 * @return the qtyTolerance
	 */
	public String getQtyTolerance() {
		return qtyTolerance;
	}


	/**
	 * @param qtyTolerance the qtyTolerance to set
	 */
	public void setQtyTolerance(String qtyTolerance) {
		this.qtyTolerance = qtyTolerance;
	}


	/**
	 * @return the qualityAssurance
	 */
	public String getQualityAssurance() {
		return qualityAssurance;
	}


	/**
	 * @param qualityAssurance the qualityAssurance to set
	 */
	public void setQualityAssurance(String qualityAssurance) {
		this.qualityAssurance = qualityAssurance;
	}


	/**
	 * @return the paymentTerm
	 */
	public String getPaymentTerm() {
		return paymentTerm;
	}


	/**
	 * @param paymentTerm the paymentTerm to set
	 */
	public void setPaymentTerm(String paymentTerm) {
		this.paymentTerm = paymentTerm;
	}


	/**
	 * @return the otherInstruction
	 */
	public String getOtherInstruction() {
		return otherInstruction;
	}


	/**
	 * @param otherInstruction the otherInstruction to set
	 */
	public void setOtherInstruction(String otherInstruction) {
		this.otherInstruction = otherInstruction;
	}


	/**
	 * @return the quotationDetail
	 */
	public String getQuotationDetail() {
		return quotationDetail;
	}


	/**
	 * @param quotationDetail the quotationDetail to set
	 */
	public void setQuotationDetail(String quotationDetail) {
		this.quotationDetail = quotationDetail;
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
	 * @return the contactPerson
	 */
	public String getContactPerson() {
		return contactPerson;
	}


	/**
	 * @param contactPerson the contactPerson to set
	 */
	public void setContactPerson(String contactPerson) {
		this.contactPerson = contactPerson;
	}


	


}