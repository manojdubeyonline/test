package com.railtech.po.entity;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * The persistent class for the synch_pl_list database table.
 * 
 */
@Entity
@Table(name="synch_pl_list")

public class PL implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="pl_id")
	private Integer plId;

	@Column(name="firm_id")
	private String firmId;

	@Column(name="item_desc")
	private String itemDesc;

	@Column(name="item_id")
	private Integer itemId;

	/*@Column(name="last_updated", columnDefinition="DATETIME",nullable=true)
	@Temporal(TemporalType.TIMESTAMP)
	private Date lastUpdated;*/

	@Column(name="pl_no")
	private String plNo;

	public PL() {
	}

	public Integer getPlId() {
		return this.plId;
	}

	public void setPlId(Integer plId) {
		this.plId = plId;
	}

	public String getFirmId() {
		return this.firmId;
	}

	public void setFirmId(String firmId) {
		this.firmId = firmId;
	}

	public String getItemDesc() {
		return this.itemDesc;
	}

	public void setItemDesc(String itemDesc) {
		this.itemDesc = itemDesc;
	}

	public Integer getItemId() {
		return this.itemId;
	}

	public void setItemId(Integer itemId) {
		this.itemId = itemId;
	}

/*	public Date getLastUpdated() {
		return this.lastUpdated;
	}

	public void setLastUpdated(Date lastUpdated) {
		this.lastUpdated = lastUpdated;
	}
*/
	public String getPlNo() {
		return this.plNo;
	}

	public void setPlNo(String plNo) {
		this.plNo = plNo;
	}

}