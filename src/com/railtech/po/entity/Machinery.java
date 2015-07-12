package com.railtech.po.entity;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the machinery_detail database table.
 * 
 */
@Entity
@Table(name="machinery_detail")
public class Machinery implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="machin_id")
	private int machinId;

	@Column(name="firm_id")
	private String firmId;

	private String machinery;

	private String name1;

	private String name2;

	public Machinery() {
	}

	public int getMachinId() {
		return this.machinId;
	}

	public void setMachinId(int machinId) {
		this.machinId = machinId;
	}

	public String getFirmId() {
		return this.firmId;
	}

	public void setFirmId(String firmId) {
		this.firmId = firmId;
	}

	public String getMachinery() {
		return this.machinery;
	}

	public void setMachinery(String machinery) {
		this.machinery = machinery;
	}

	public String getName1() {
		return this.name1;
	}

	public void setName1(String name1) {
		this.name1 = name1;
	}

	public String getName2() {
		return this.name2;
	}

	public void setName2(String name2) {
		this.name2 = name2;
	}

}