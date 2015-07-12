package com.railtech.po.entity;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the loading_receipt database table.
 * 
 */
@Entity
@Table(name="loading_receipt")
public class LoadingReceipt implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="loading_id")
	private int loadingId;

	@Column(name="dispatch_id")
	private int dispatchId;

	private int fid;

	@Column(name="installment_no")
	private int installmentNo;

	@Column(name="item_desc")
	private String itemDesc;

	@Column(name="item_id")
	private int itemId;

	@Column(name="last_modified")
	private String lastModified;

	@Column(name="loading_receipt")
	private String loadingReceipt;

	@Column(name="modified_by")
	private int modifiedBy;

	@Column(name="production_file_no")
	private String productionFileNo;

	@Column(name="purchase_order_no")
	private String purchaseOrderNo;

	private String remarks;

	public LoadingReceipt() {
	}

	public int getLoadingId() {
		return this.loadingId;
	}

	public void setLoadingId(int loadingId) {
		this.loadingId = loadingId;
	}

	public int getDispatchId() {
		return this.dispatchId;
	}

	public void setDispatchId(int dispatchId) {
		this.dispatchId = dispatchId;
	}

	public int getFid() {
		return this.fid;
	}

	public void setFid(int fid) {
		this.fid = fid;
	}

	public int getInstallmentNo() {
		return this.installmentNo;
	}

	public void setInstallmentNo(int installmentNo) {
		this.installmentNo = installmentNo;
	}

	public String getItemDesc() {
		return this.itemDesc;
	}

	public void setItemDesc(String itemDesc) {
		this.itemDesc = itemDesc;
	}

	public int getItemId() {
		return this.itemId;
	}

	public void setItemId(int itemId) {
		this.itemId = itemId;
	}

	public String getLastModified() {
		return this.lastModified;
	}

	public void setLastModified(String lastModified) {
		this.lastModified = lastModified;
	}

	public String getLoadingReceipt() {
		return this.loadingReceipt;
	}

	public void setLoadingReceipt(String loadingReceipt) {
		this.loadingReceipt = loadingReceipt;
	}

	public int getModifiedBy() {
		return this.modifiedBy;
	}

	public void setModifiedBy(int modifiedBy) {
		this.modifiedBy = modifiedBy;
	}

	public String getProductionFileNo() {
		return this.productionFileNo;
	}

	public void setProductionFileNo(String productionFileNo) {
		this.productionFileNo = productionFileNo;
	}

	public String getPurchaseOrderNo() {
		return this.purchaseOrderNo;
	}

	public void setPurchaseOrderNo(String purchaseOrderNo) {
		this.purchaseOrderNo = purchaseOrderNo;
	}

	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

}