package com.railtech.po.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.sql.Timestamp;


/**
 * The persistent class for the vender_tbl_po_code database table.
 * 
 */
@Entity
@Table(name="vender_tbl_po_code")
public class Vender implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="drawing_id")
	private int drawingId;

	@Column(name="a_id")
	private int aId;

	@Column(name="b_id")
	private int bId;

	@Column(name="brand_id")
	private int brandId;

	@Column(name="c_id")
	private int cId;

	@Column(name="d_id")
	private int dId;

	@Column(name="drawing_details")
	private String drawingDetails;

	@Column(name="e_id")
	private int eId;

	@Column(name="f_id")
	private int fId;

	@Column(name="file_no")
	private String fileNo;

	@Column(name="item_id")
	private int itemId;

	@Column(name="item_name")
	private String itemName;

	@Column(name="last_modified")
	private Timestamp lastModified;

	@Column(name="modified_by")
	private int modifiedBy;

	@Column(name="new_item_code")
	private String newItemCode;

	@Column(name="new_item_desc")
	private String newItemDesc;

	@Lob
	private String remarks;

	@Column(name="shelf_no")
	private String shelfNo;

	public Vender() {
	}

	public int getDrawingId() {
		return this.drawingId;
	}

	public void setDrawingId(int drawingId) {
		this.drawingId = drawingId;
	}

	public int getAId() {
		return this.aId;
	}

	public void setAId(int aId) {
		this.aId = aId;
	}

	public int getBId() {
		return this.bId;
	}

	public void setBId(int bId) {
		this.bId = bId;
	}

	public int getBrandId() {
		return this.brandId;
	}

	public void setBrandId(int brandId) {
		this.brandId = brandId;
	}

	public int getCId() {
		return this.cId;
	}

	public void setCId(int cId) {
		this.cId = cId;
	}

	public int getDId() {
		return this.dId;
	}

	public void setDId(int dId) {
		this.dId = dId;
	}

	public String getDrawingDetails() {
		return this.drawingDetails;
	}

	public void setDrawingDetails(String drawingDetails) {
		this.drawingDetails = drawingDetails;
	}

	public int getEId() {
		return this.eId;
	}

	public void setEId(int eId) {
		this.eId = eId;
	}

	public int getFId() {
		return this.fId;
	}

	public void setFId(int fId) {
		this.fId = fId;
	}

	public String getFileNo() {
		return this.fileNo;
	}

	public void setFileNo(String fileNo) {
		this.fileNo = fileNo;
	}

	public int getItemId() {
		return this.itemId;
	}

	public void setItemId(int itemId) {
		this.itemId = itemId;
	}

	public String getItemName() {
		return this.itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public Timestamp getLastModified() {
		return this.lastModified;
	}

	public void setLastModified(Timestamp lastModified) {
		this.lastModified = lastModified;
	}

	public int getModifiedBy() {
		return this.modifiedBy;
	}

	public void setModifiedBy(int modifiedBy) {
		this.modifiedBy = modifiedBy;
	}

	public String getNewItemCode() {
		return this.newItemCode;
	}

	public void setNewItemCode(String newItemCode) {
		this.newItemCode = newItemCode;
	}

	public String getNewItemDesc() {
		return this.newItemDesc;
	}

	public void setNewItemDesc(String newItemDesc) {
		this.newItemDesc = newItemDesc;
	}

	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getShelfNo() {
		return this.shelfNo;
	}

	public void setShelfNo(String shelfNo) {
		this.shelfNo = shelfNo;
	}

}