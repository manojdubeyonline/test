package com.railtech.po.entity;

import java.io.Serializable;

import javax.persistence.*;

import org.codehaus.jackson.annotate.JsonBackReference;

import java.util.Date;
import java.util.Set;
import java.sql.Timestamp;


/**
 * The persistent class for the grpo database table.
 * 
 */
@Entity
@Table(name="grpo")
public class GRPO implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="grpo_id")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer grpoId;

	@Column(name="goods_reciept_number")
	private String goodsRecieptNo;

	@ManyToOne
	@JoinColumn(name="order_id")
	private PurchaseOrder orderId;
	
	
	
	@ManyToOne
	@JoinColumn(name="firm_id")
	private Firm firm;
	
	
	
	@ManyToOne
	@JoinColumn(name="ware_id")
	private Warehouse warehouse;
	
	
	@ManyToOne
	@JoinColumn(name="inward_added_by")
	private User addedBy;

	@Column(name="approval_comments")
	private String approvalComments;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="approval_date")
	private Date approvalDate;

	@Column(name="approval_status")
	private String approvalStatus;

	@ManyToOne
	@JoinColumn(name="approved_by")
	private User approvedBy;
	
	@Column(name="bill_amount")
	private Float billAmount;


	@Column(name="inward_comments")
	private String inwardComments;


	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="gr_date")
	private Date grDate;
	
	
	private String isdisbursed;
	
	private String grType;
	
	@ManyToOne
	@JoinColumn(name="vendor_id")
	private Vendor vendor;
	
	@ManyToOne
	@JoinColumn(name="location_id")
	private VendorDetails vendorDetail;
	
	@Column(name="vendor_invoice_no")
	private String vendorInvoiceNo;
	
	@Column(name="vendor_invoice_date")
	private Date vendorInvoiceDate;
	
	@Column(name="vehicle_no")
	private String vehicleNo;
	
	@Column(name="rejection_comments")
	private String rejectionComments;
	
	@ManyToOne
	@JoinColumn(name="last_modified_by")
	private User lastModifiedBy;

	@Column(name="last_updated")
	private Timestamp lastUpdated;

	@OneToMany(fetch = FetchType.LAZY, mappedBy ="grId", cascade=CascadeType.ALL)
	private Set<GRRateApplied> grLevelRates;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "grpo", cascade=CascadeType.ALL)
	private Set<GRPOReceiptEntry> grpoReceiptItems;

	public GRPO() {
	}

	/**
	 * @return the grpoId
	 */
	public Integer getGrpoId() {
		return grpoId;
	}

	/**
	 * @param grpoId the grpoId to set
	 */
	public void setGrpoId(Integer grpoId) {
		this.grpoId = grpoId;
	}

	/**
	 * @return the goodsRecieptNo
	 */
	public String getGoodsRecieptNo() {
		return goodsRecieptNo;
	}

	/**
	 * @param goodsRecieptNo the goodsRecieptNo to set
	 */
	public void setGoodsRecieptNo(String goodsRecieptNo) {
		this.goodsRecieptNo = goodsRecieptNo;
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

	/**
	 * @return the billAmount
	 */
	public Float getBillAmount() {
		return billAmount;
	}

	/**
	 * @param billAmount the billAmount to set
	 */
	public void setBillAmount(Float billAmount) {
		this.billAmount = billAmount;
	}

	/**
	 * @return the inwardComments
	 */
	public String getInwardComments() {
		return inwardComments;
	}

	/**
	 * @param inwardComments the inwardComments to set
	 */
	public void setInwardComments(String inwardComments) {
		this.inwardComments = inwardComments;
	}

	/**
	 * @return the grDate
	 */
	public Date getGrDate() {
		return grDate;
	}

	/**
	 * @param grDate the grDate to set
	 */
	public void setGrDate(Date grDate) {
		this.grDate = grDate;
	}

	/**
	 * @return the vendorInvoiceNo
	 */
	public String getVendorInvoiceNo() {
		return vendorInvoiceNo;
	}

	/**
	 * @param vendorInvoiceNo the vendorInvoiceNo to set
	 */
	public void setVendorInvoiceNo(String vendorInvoiceNo) {
		this.vendorInvoiceNo = vendorInvoiceNo;
	}

	/**
	 * @return the vendorInvoiceDate
	 */
	public Date getVendorInvoiceDate() {
		return vendorInvoiceDate;
	}

	/**
	 * @param vendorInvoiceDate the vendorInvoiceDate to set
	 */
	public void setVendorInvoiceDate(Date vendorInvoiceDate) {
		this.vendorInvoiceDate = vendorInvoiceDate;
	}

	/**
	 * @return the vihicleNo
	 */
	public String getVehicleNo() {
		return vehicleNo;
	}

	/**
	 * @param vihicleNo the vihicleNo to set
	 */
	public void setVehicleNo(String vehicleNo) {
		this.vehicleNo = vehicleNo;
	}

	/**
	 * @return the rejectionReason
	 */
	public String getRejectionComments() {
		return rejectionComments;
	}

	/**
	 * @param rejectionReason the rejectionReason to set
	 */
	public void setRejectionComments(String rejectionComments) {
		this.rejectionComments = rejectionComments;
	}

	/**
	 * @return the isdisbursed
	 */
	public String getIsdisbursed() {
		return isdisbursed;
	}

	/**
	 * @param isdisbursed the isdisbursed to set
	 */
	public void setIsdisbursed(String isdisbursed) {
		this.isdisbursed = isdisbursed;
	}

	public String getGrType() {
		return grType;
	}

	public void setGrType(String grType) {
		this.grType = grType;
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
	 * @return the lastModifiedBy
	 */
	public User getLastModifiedBy() {
		return lastModifiedBy;
	}

	/**
	 * @param lastModifiedBy the lastModifiedBy to set
	 */
	public void setLastModifiedBy(User lastModifiedBy) {
		this.lastModifiedBy = lastModifiedBy;
	}

	/**
	 * @return the lastUpdated
	 */
	public Timestamp getLastUpdated() {
		return lastUpdated;
	}

	/**
	 * @param lastUpdated the lastUpdated to set
	 */
	public void setLastUpdated(Timestamp lastUpdated) {
		this.lastUpdated = lastUpdated;
	}




	/**
	 * @return the grLevelRates
	 */
	public Set<GRRateApplied> getGrLevelRates() {
		return grLevelRates;
	}

	/**
	 * @param grLevelRates the grLevelRates to set
	 */
	public void setGrLevelRates(Set<GRRateApplied> grLevelRates) {
		this.grLevelRates = grLevelRates;
	}

	

	/**
	 * @return the grpoReceiptItems
	 */
	public Set<GRPOReceiptEntry> getGrpoReceiptItems() {
		return grpoReceiptItems;
	}

	/**
	 * @param grpoReceiptItems the grpoReceiptItems to set
	 */
	public void setGrpoReceiptItems(Set<GRPOReceiptEntry> grpoReceiptItems) {
		this.grpoReceiptItems = grpoReceiptItems;
	}

	


}