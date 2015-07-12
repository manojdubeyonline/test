package com.railtech.po.entity;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the store_master database table.
 * 
 */
@Entity
@Table(name="store_master")
public class Store implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int store_id;

	private String code;

	private int firm_id;

	private String store_name;

	public Store() {
	}

	public int getStore_id() {
		return this.store_id;
	}

	public void setStore_id(int store_id) {
		this.store_id = store_id;
	}

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public int getFirm_id() {
		return this.firm_id;
	}

	public void setFirm_id(int firm_id) {
		this.firm_id = firm_id;
	}

	public String getStore_name() {
		return this.store_name;
	}

	public void setStore_name(String store_name) {
		this.store_name = store_name;
	}

}