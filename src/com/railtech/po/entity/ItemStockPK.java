package com.railtech.po.entity;

import java.io.Serializable;

import javax.persistence.Embeddable;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Embeddable
public class ItemStockPK implements Serializable {


	private static final long serialVersionUID = 1L;

	//@JsonBackReference
	@ManyToOne
	@JoinColumn(name="item_code_id")
	private Code itemCode;
	
	//@JsonBackReference
	@ManyToOne
	@JoinColumn(name="warehouse_id")
	private Warehouse warehouse;

	public Code getItemCode() {
		return itemCode;
	}

	public void setItemCode(Code itemCode) {
		this.itemCode = itemCode;
	}

	public Warehouse getWarehouse() {
		return warehouse;
	}

	public void setWarehouse(Warehouse warehouse) {
		this.warehouse = warehouse;
	}
	
	
	
	
}
