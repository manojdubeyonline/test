package com.railtech.po.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.Lob;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


/**
 * The persistent class for the user database table.
 * 
 */
@Entity
@Table(name="user")
public class User implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(unique=true, nullable=false)
	private Long id;
	
	@Column(name="USERNAME", nullable=false)
	private String userName;
	
	@Column(name="PASSWORD", nullable=false)
	private String password;

	@Column(name="FIRSTNAME", nullable=false)
	private String firstName;

	@Column(name="LASTNAME", nullable=false)
	private String lastName;
	
	@Column(name="EMAIL", nullable=true)
	private String email;

	@Lob
	@Column(name="PHOTO")
	private byte[] photo;

	@Column(name="STATUS", nullable=false)
	private String status;
	
	@Column(name="CREATEDDATE", nullable=false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date createdDate;
	
	@Column(name="UPDATEDDATE")
	@Temporal(TemporalType.TIMESTAMP)
	private Date updatedDate;

	
	@OneToMany(fetch=FetchType.EAGER)
	@JoinTable(
		name="userProfile"
		, joinColumns={
			@JoinColumn(name="USERID")
			}
		, inverseJoinColumns={
			@JoinColumn(name="PROFILEID")
			}
		)
	private Set<Profile> userProfiles;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public byte[] getPhoto() {
		return photo;
	}

	public void setPhoto(byte[] photo) {
		this.photo = photo;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public Date getUpdatedDate() {
		return updatedDate;
	}

	public void setUpdatedDate(Date updatedDate) {
		this.updatedDate = updatedDate;
	}

	/**
	 * @return the userProfiles
	 */
	public Set<Profile> getUserProfiles() {
		return userProfiles;
	}

	/**
	 * @param userProfiles the userProfiles to set
	 */
	public void setUserProfiles(Set<Profile> userProfiles) {
		this.userProfiles = userProfiles;
	}
	
}