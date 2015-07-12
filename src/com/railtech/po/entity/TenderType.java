package com.railtech.po.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.sql.Timestamp;


/**
 * The persistent class for the tbl_tender_type database table.
 * 
 */
@Entity
@Table(name="tbl_tender_type")
public class TenderType implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="tender_type_id")
	private int tenderTypeId;

	@Column(name="last_modified")
	private Timestamp lastModified;

	@Column(name="modified_by")
	private int modifiedBy;

	private String remarks;

	@Column(name="tender_type")
	private String tenderType;

	public TenderType() {
	}

	public int getTenderTypeId() {
		return this.tenderTypeId;
	}

	public void setTenderTypeId(int tenderTypeId) {
		this.tenderTypeId = tenderTypeId;
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

	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getTenderType() {
		return this.tenderType;
	}

	public void setTenderType(String tenderType) {
		this.tenderType = tenderType;
	}

}