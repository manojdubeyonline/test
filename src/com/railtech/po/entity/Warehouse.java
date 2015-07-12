package com.railtech.po.entity;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the warehouse_master database table.
 * 
 */
@Entity
@Table(name="warehouse_master")
public class Warehouse implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="ware_id")
	private Integer wareId;

	@Column(name="firm_id")
	private Integer firmId;

	@Column(name="warehouse_address")
	private String warehouseAddress;

	@Column(name="warehouse_code")
	private String warehouseCode;

	@Column(name="warehouse_name")
	private String warehouseName;

	public Warehouse() {
	}

	public Integer getWareId() {
		return this.wareId;
	}

	public void setWareId(Integer wareId) {
		this.wareId = wareId;
	}

	public Integer getFirmId() {
		return this.firmId;
	}

	public void setFirmId(Integer firmId) {
		this.firmId = firmId;
	}

	public String getWarehouseAddress() {
		return this.warehouseAddress;
	}

	public void setWarehouseAddress(String warehouseAddress) {
		this.warehouseAddress = warehouseAddress;
	}

	public String getWarehouseCode() {
		return this.warehouseCode;
	}

	public void setWarehouseCode(String warehouseCode) {
		this.warehouseCode = warehouseCode;
	}

	public String getWarehouseName() {
		return this.warehouseName;
	}

	public void setWarehouseName(String warehouseName) {
		this.warehouseName = warehouseName;
	}

}