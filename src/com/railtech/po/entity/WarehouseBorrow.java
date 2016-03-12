package com.railtech.po.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


@Entity
@Table(name="warehouse_borrow")
public class WarehouseBorrow implements Serializable{
	
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="borrow_id")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer borrowId;
	
	@ManyToOne
	@JoinColumn(name="item_code_id")
	private Code itemCode;
	
	@ManyToOne
	@JoinColumn(name="from_firm_id")
	private Firm fromFirm;
	
	@ManyToOne
	@JoinColumn(name="from_ware_id")
	private Warehouse fromWarehouse;
	
	@ManyToOne
	@JoinColumn(name="to_firm_id")
	private Firm toFirm;
	
	@ManyToOne
	@JoinColumn(name="to_ware_id")
	private Warehouse toWarehouse;
	
		
	@Column(name="status")
	private String status;

	


	@Column(name="borrow_qty")
	private double borrowQty;
	
	@ManyToOne
	@JoinColumn(name="unit_id")
	private Unit unit;
	
	@ManyToOne
	@JoinColumn(name="added_by")
	private User addedBy;
	
	@Column(name="borrow_due_date")
	private Date borrowDueDate;
	
	@Column(name="borrow_added_date")
	private Date dateBorrow;
	
	
	@Column(name="last_modified")
	@Temporal(TemporalType.TIMESTAMP)
	private Date lastModified;


	public Integer getBorrowId() {
		return borrowId;
	}


	public void setBorrowId(Integer borrowId) {
		this.borrowId = borrowId;
	}


	public Code getItemCode() {
		return itemCode;
	}


	public void setItemCode(Code itemCode) {
		this.itemCode = itemCode;
	}


	public Firm getFromFirm() {
		return fromFirm;
	}


	public void setFromFirm(Firm fromFirm) {
		this.fromFirm = fromFirm;
	}


	public Warehouse getFromWarehouse() {
		return fromWarehouse;
	}


	public void setFromWarehouse(Warehouse fromWarehouse) {
		this.fromWarehouse = fromWarehouse;
	}


	public Firm getToFirm() {
		return toFirm;
	}


	public void setToFirm(Firm toFirm) {
		this.toFirm = toFirm;
	}


	public Warehouse getToWarehouse() {
		return toWarehouse;
	}


	public void setToWarehouse(Warehouse toWarehouse) {
		this.toWarehouse = toWarehouse;
	}


	public double getBorrowQty() {
		return borrowQty;
	}


	public void setBorrowQty(double borrowQty) {
		this.borrowQty = borrowQty;
	}


	public Unit getUnit() {
		return unit;
	}


	public void setUnit(Unit unit) {
		this.unit = unit;
	}


	public User getAddedBy() {
		return addedBy;
	}


	public void setAddedBy(User addedBy) {
		this.addedBy = addedBy;
	}


	public Date getBorrowDueDate() {
		return borrowDueDate;
	}


	public void setBorrowDueDate(Date borrowDueDate) {
		this.borrowDueDate = borrowDueDate;
	}


	public Date getDateBorrow() {
		return dateBorrow;
	}


	public void setDateBorrow(Date dateBorrow) {
		this.dateBorrow = dateBorrow;
	}


	public Date getLastModified() {
		return lastModified;
	}


	public void setLastModified(Date lastModified) {
		this.lastModified = lastModified;
	}
	
	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


}
