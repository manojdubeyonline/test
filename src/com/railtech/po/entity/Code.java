package com.railtech.po.entity;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnore;


/**
 * The persistent class for the vender_tbl_po_code database table.
 * 
 */
@Entity
@Table(name="vender_tbl_po_code")

public class Code implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="drawing_id")
	private Integer codeId;

	@Column(name="a_id")
	private Integer aId;

	@Column(name="b_id")
	private Integer bId;

	@Column(name="brand_id")
	private Integer brandId;

	@Column(name="c_id")
	private Integer cId;

	@Column(name="d_id")
	private Integer dId;

	@Column(name="drawing_details")
	private String code;

	@Column(name="e_id")
	private Integer eId;

	@Column(name="f_id")
	private Integer fId;

	@Column(name="file_no")
	private String fileNo;

	@Column(name="item_id")
	private Integer itemId;

	@Column(name="item_name")
	private String itemName;

	@Column(name="last_modified")
	private Timestamp lastModified;

	@Column(name="modified_by")
	private Integer modifiedBy;

	@Column(name="new_item_code")
	private String newItemCode;

	@Column(name="new_item_desc")
	private String newItemDesc;

	@Lob
	@Column(name="remarks")
	private String codeDesc ;

	@Column(name="shelf_no")
	private String shelfNo;
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "itemStockPK.itemCode", cascade=CascadeType.ALL)
	@JsonIgnore
	private Set<ItemStock> itemstocks;

	public Code() {
	}

	
	public Integer getAId() {
		return this.aId;
	}

	public void setAId(Integer aId) {
		this.aId = aId;
	}

	public Integer getBId() {
		return this.bId;
	}

	public void setBId(Integer bId) {
		this.bId = bId;
	}

	public Integer getBrandId() {
		return this.brandId;
	}

	public void setBrandId(Integer brandId) {
		this.brandId = brandId;
	}

	public Integer getCId() {
		return this.cId;
	}

	public void setCId(Integer cId) {
		this.cId = cId;
	}

	public Integer getDId() {
		return this.dId;
	}

	public void setDId(Integer dId) {
		this.dId = dId;
	}

	

	public Integer getEId() {
		return this.eId;
	}

	public void setEId(Integer eId) {
		this.eId = eId;
	}

	public Integer getFId() {
		return this.fId;
	}

	public void setFId(Integer fId) {
		this.fId = fId;
	}

	public String getFileNo() {
		return this.fileNo;
	}

	public void setFileNo(String fileNo) {
		this.fileNo = fileNo;
	}

	public Integer getItemId() {
		return this.itemId;
	}

	public void setItemId(Integer itemId) {
		this.itemId = itemId;
	}

	public String getItemName() {
		return this.itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
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

	public String getNewItemCode() {
		return this.newItemCode;
	}

	public void setNewItemCode(String newItemCode) {
		this.newItemCode = newItemCode;
	}

	public String getNewItemDesc() {
		return this.newItemDesc;
	}

	public void setNewItemDesc(String newItemDesc) {
		this.newItemDesc = newItemDesc;
	}

	
	public String getShelfNo() {
		return this.shelfNo;
	}

	public void setShelfNo(String shelfNo) {
		this.shelfNo = shelfNo;
	}


	/**
	 * @return the codeId
	 */
	public Integer getCodeId() {
		return codeId;
	}


	/**
	 * @param codeId the codeId to set
	 */
	public void setCodeId(Integer codeId) {
		this.codeId = codeId;
	}


	/**
	 * @return the aId
	 */
	public Integer getaId() {
		return aId;
	}


	/**
	 * @param aId the aId to set
	 */
	public void setaId(Integer aId) {
		this.aId = aId;
	}


	/**
	 * @return the bId
	 */
	public Integer getbId() {
		return bId;
	}


	/**
	 * @param bId the bId to set
	 */
	public void setbId(Integer bId) {
		this.bId = bId;
	}


	/**
	 * @return the cId
	 */
	public Integer getcId() {
		return cId;
	}


	/**
	 * @param cId the cId to set
	 */
	public void setcId(Integer cId) {
		this.cId = cId;
	}


	/**
	 * @return the dId
	 */
	public Integer getdId() {
		return dId;
	}


	/**
	 * @param dId the dId to set
	 */
	public void setdId(Integer dId) {
		this.dId = dId;
	}


	/**
	 * @return the code
	 */
	public String getCode() {
		return code;
	}


	/**
	 * @param code the code to set
	 */
	public void setCode(String code) {
		this.code = code;
	}


	/**
	 * @return the eId
	 */
	public Integer geteId() {
		return eId;
	}


	/**
	 * @param eId the eId to set
	 */
	public void seteId(Integer eId) {
		this.eId = eId;
	}


	/**
	 * @return the fId
	 */
	public Integer getfId() {
		return fId;
	}


	/**
	 * @param fId the fId to set
	 */
	public void setfId(Integer fId) {
		this.fId = fId;
	}


	/**
	 * @return the codeDesc
	 */
	public String getCodeDesc() {
		return codeDesc;
	}


	/**
	 * @param codeDesc the codeDesc to set
	 */
	public void setCodeDesc(String codeDesc) {
		this.codeDesc = codeDesc;
	}

	

	/**
	 * @return the itemstocks
	 */
	public Set<ItemStock> getItemstocks() {
		return itemstocks;
	}


	/**
	 * @param itemstocks the itemstocks to set
	 */
	public void setItemstocks(Set<ItemStock> itemstocks) {
		this.itemstocks = itemstocks;
	}


	/* (non-Javadoc)
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((codeId == null) ? 0 : codeId.hashCode());
		return result;
	}


	/* (non-Javadoc)
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Code other = (Code) obj;
		if (codeId == null) {
			if (other.codeId != null)
				return false;
		} else if (!codeId.equals(other.codeId))
			return false;
		return true;
	}
	
	

}