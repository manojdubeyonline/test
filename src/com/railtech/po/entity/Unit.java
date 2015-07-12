package com.railtech.po.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.sql.Timestamp;


/**
 * The persistent class for the unit_master database table.
 * 
 */
@Entity
@Table(name="unit_master")
public class Unit implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="unit_id")
	private int unitId;

	@Column(name="last_modified")
	private Timestamp lastModified;

	@Column(name="modified_by")
	private int modifiedBy;

	@Column(name="unit_name")
	private String unitName;

	@Lob
	@Column(name="unit_remarks")
	private String unitRemarks;

	public Unit() {
	}

	public int getUnitId() {
		return this.unitId;
	}

	public void setUnitId(int unitId) {
		this.unitId = unitId;
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

	public String getUnitName() {
		return this.unitName;
	}

	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

	public String getUnitRemarks() {
		return this.unitRemarks;
	}

	public void setUnitRemarks(String unitRemarks) {
		this.unitRemarks = unitRemarks;
	}

}