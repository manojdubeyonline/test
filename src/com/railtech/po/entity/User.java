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

	@Column(name="role_id")
	private Integer roleId;

	private String status;

	@Column(name="user_name")
	private String userName;

	@Column(name="user_password")
	private String userPassword;
	
	@ManyToMany(cascade = {CascadeType.ALL})
    @JoinTable(name="USER_FIRMS", 
                joinColumns={@JoinColumn(name="user_id")}, 
                inverseJoinColumns={@JoinColumn(name="firm_id")})
    private Set<Firm> userFirms = new HashSet<Firm>();
	
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

	public Integer getRoleId() {
		return this.roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
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

	
}