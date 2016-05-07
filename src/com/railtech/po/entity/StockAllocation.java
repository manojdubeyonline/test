/**
 * 
 */
package com.railtech.po.entity;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * @author sachin

 *
 */


/**
 * The persistent class for the stock allocation database table.
 * 
 */
@Entity
@Table(name="stock_allocation")
public class StockAllocation implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="stock_id")
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer stockId;
	
	@Column(name="stock_number")
	private String stockNo;

	@ManyToOne
	@JoinColumn(name="order_id")
	private PurchaseOrder order;
	
	@ManyToOne
	@JoinColumn(name="grpo_id")
	private GRPO grpo;
	
	@Column(name="status")
	private String status;
	
	
	@ManyToOne
	@JoinColumn(name="firm_id")
	private Firm firm;
	
	@ManyToOne
	@JoinColumn(name="allocatedBy")
	private User allocatedBy;
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="allocated_date")
	private Date allocatedDate;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "stockId", cascade=CascadeType.ALL)
	private Set<StockAllocationItem> stockItems;
	
	@Column(name="last_modified")
	private Timestamp lastModified;

	/**
	 * @return the stockId
	 */
	public Integer getStockId() {
		return stockId;
	}

	/**
	 * @param stockId the stockId to set
	 */
	public void setStockId(Integer stockId) {
		this.stockId = stockId;
	}

	/**
	 * @return the stockNo
	 */
	public String getStockNo() {
		return stockNo;
	}

	/**
	 * @param stockNo the stockNo to set
	 */
	public void setStockNo(String stockNo) {
		this.stockNo = stockNo;
	}

	/**
	 * @return the order
	 */
	public PurchaseOrder getOrder() {
		return order;
	}

	/**
	 * @param order the order to set
	 */
	public void setOrder(PurchaseOrder order) {
		this.order = order;
	}

	/**
	 * @return the grpo
	 */
	public GRPO getGrpo() {
		return grpo;
	}

	/**
	 * @param grpo the grpo to set
	 */
	public void setGrpo(GRPO grpo) {
		this.grpo = grpo;
	}

	

	/**
	 * @return the firm
	 */
	public Firm getFirm() {
		return firm;
	}

	/**
	 * @param firm the firm to set
	 */
	public void setFirm(Firm firm) {
		this.firm = firm;
	}

	/**
	 * @return the allocatedBy
	 */
	public User getAllocatedBy() {
		return allocatedBy;
	}

	/**
	 * @param allocatedBy the allocatedBy to set
	 */
	public void setAllocatedBy(User allocatedBy) {
		this.allocatedBy = allocatedBy;
	}

	/**
	 * @return the allocatedDate
	 */
	public Date getAllocatedDate() {
		return allocatedDate;
	}

	/**
	 * @param allocatedDate the allocatedDate to set
	 */
	public void setAllocatedDate(Date allocatedDate) {
		this.allocatedDate = allocatedDate;
	}

	

	/**
	 * @return the stockItems
	 */
	public Set<StockAllocationItem> getStockItems() {
		return stockItems;
	}

	/**
	 * @param stockItems the stockItems to set
	 */
	public void setStockItems(Set<StockAllocationItem> stockItems) {
		this.stockItems = stockItems;
	}

	/**
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}

	/**
	 * @param status the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}

	/**
	 * @return the lastModified
	 */
	public Timestamp getLastModified() {
		return lastModified;
	}

	/**
	 * @param lastModified the lastModified to set
	 */
	public void setLastModified(Timestamp lastModified) {
		this.lastModified = lastModified;
	}

	
	
}
