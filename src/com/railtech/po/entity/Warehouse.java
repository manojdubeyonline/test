package com.railtech.po.entity;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnore;


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
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "itemStockPK.warehouse", cascade=CascadeType.ALL)
	@JsonIgnore
	Set<ItemStock> warehouseStock;

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

	public Set<ItemStock> getWarehouseStock() {
		return warehouseStock;
	}

	public void setWarehouseStock(Set<ItemStock> warehouseStock) {
		this.warehouseStock = warehouseStock;
	}

	

	
}