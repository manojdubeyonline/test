package com.railtech.po.entity;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;


/**
 * The persistent class for the tbl_users database table.
 * 
 */
@Entity
@Table(name="tbl_users")
public class User implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="user_id")
	private Integer userId;

	private byte access;

	private Integer access1;

	private String email;

	@Column(name="landing_page")
	private String landingPage;

	@Column(name="last_modified")
	private Timestamp lastModified;

	@Column(name="modified_by")
	private Integer modifiedBy;

	@Lob
	private String remarks;
	
	@ManyToOne
	@JoinColumn(name="role_id")
	private Role userRole;

	private String status;

	@Column(name="user_name")
	private String userName;

	@Column(name="user_password")
	private String userPassword;
	
	@ManyToMany(cascade = {CascadeType.ALL})
    @JoinTable(name="user_firms", 
                joinColumns={@JoinColumn(name="user_id")}, 
                inverseJoinColumns={@JoinColumn(name="firm_id")})
    private Set<Firm> userFirms = new HashSet<Firm>();
	
	@ManyToMany(cascade = {CascadeType.ALL})
    @JoinTable(name="user_warehouse", 
                joinColumns={@JoinColumn(name="user_id")}, 
                inverseJoinColumns={@JoinColumn(name="ware_id")})
    private Set<Warehouse> userWarehouses = new HashSet<Warehouse>();
	
	public User() {
	}

	public Integer getUserId() {
		return this.userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public byte getAccess() {
		return this.access;
	}

	public void setAccess(byte access) {
		this.access = access;
	}

	public Integer getAccess1() {
		return this.access1;
	}

	public void setAccess1(Integer access1) {
		this.access1 = access1;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getLandingPage() {
		return this.landingPage;
	}

	public void setLandingPage(String landingPage) {
		this.landingPage = landingPage;
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

	public String getRemarks() {
		return this.remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	
	public Role getUserRole() {
		return userRole;
	}

	public void setUserRole(Role userRole) {
		this.userRole = userRole;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getUserName() {
		return this.userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserPassword() {
		return this.userPassword;
	}

	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

	public Set<Firm> getUserFirms() {
		return userFirms;
	}

	public void setUserFirms(Set<Firm> userFirms) {
		this.userFirms = userFirms;
	}

	public Set<Warehouse> getUserWarehouses() {
		return userWarehouses;
	}

	public void setUserWarehouses(Set<Warehouse> userWarehouses) {
		this.userWarehouses = userWarehouses;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((userId == null) ? 0 : userId.hashCode());
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
		User other = (User) obj;
		if (userId == null) {
			if (other.userId != null)
				return false;
		} else if (!userId.equals(other.userId))
			return false;
		return true;
	}

	

	
}