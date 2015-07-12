package com.railtech.po.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.sql.Timestamp;


/**
 * The persistent class for the tbl_items database table.
 * 
 */
@Entity
@Table(name="tbl_items")
public class Item implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="item_id")
	private Integer itemId;

	private Integer cat;

	@Column(name="item_desc")
	private String itemDesc;

	@Column(name="item_name")
	private String itemName;

	@Column(name="item_spec")
	private String itemSpec;

	@Column(name="last_modified")
	private Timestamp lastModified;

	@Column(name="modified_by")
	private Integer modifiedBy;

	@Column(name="pl_no")
	private String plNo;

	@Lob
	private String remarks;

	private String status;

	private Integer subcat;

	public Item() {
	}

	

	/**
	 * @return the itemId
	 */
	public Integer getItemId() {
		return itemId;
	}



	/**
	 * @param itemId the itemId to set
	 */
	public void setItemId(Integer itemId) {
		this.itemId = itemId;
	}



	public Integer getCat() {
		return this.cat;
	}

	public void setCat(Integer cat) {
		this.cat = cat;
	}

	public String getItemDesc() {
		return this.itemDesc;
	}

	public void setItemDesc(String itemDesc) {
		this.itemDesc = itemDesc;
	}

	public String getItemName() {
		return this.itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getItemSpec() {
		return this.itemSpec;
	}

	public void setItemSpec(String itemSpec) {
		this.itemSpec = itemSpec;
	}

	public Timestamp getLastModified() {
		return this.lastModified;
	}

	public void setLastModified(Timestamp lastModified) {
		this.lastModified = lastModified;
	}

	public Integer getModifiedBy() {
		return this.modifiedBy;
	}

	public void setModifiedBy(Integer modifiedBy) {
		this.modifiedBy = modifiedBy;
	}

	public String getPlNo() {
		return this.plNo;
	}

	public void setPlNo(String plNo) {
		this.plNo = plNo;
	}

	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Integer getSubcat() {
		return this.subcat;
	}

	public void setSubcat(Integer subcat) {
		this.subcat = subcat;
	}

}