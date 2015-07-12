package com.railtech.po.entity;

import java.io.Serializable;
import javax.persistence.*;
import java.sql.Timestamp;


/**
 * The persistent class for the tbl_competitors database table.
 * 
 */
@Entity
@Table(name="tbl_competitors")
public class Competitor implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="competitor_id")
	private int competitorId;

	@Column(name="competitor_location")
	private String competitorLocation;

	@Column(name="competitor_name")
	private String competitorName;

	@Column(name="last_modified")
	private Timestamp lastModified;

	@Column(name="modified_by")
	private int modifiedBy;

	@Lob
	private String remarks;

	private String status;

	public Competitor() {
	}

	public int getCompetitorId() {
		return this.competitorId;
	}

	public void setCompetitorId(int competitorId) {
		this.competitorId = competitorId;
	}

	public String getCompetitorLocation() {
		return this.competitorLocation;
	}

	public void setCompetitorLocation(String competitorLocation) {
		this.competitorLocation = competitorLocation;
	}

	public String getCompetitorName() {
		return this.competitorName;
	}

	public void setCompetitorName(String competitorName) {
		this.competitorName = competitorName;
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

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}