/**
 * 
 */
package com.railtech.po.service;

import java.util.Set;

import com.railtech.po.entity.Code;
import com.railtech.po.entity.Firm;
import com.railtech.po.entity.Item;
import com.railtech.po.entity.PL;
import com.railtech.po.entity.Unit;
import com.railtech.po.entity.User;
import com.railtech.po.entity.Warehouse;
import com.railtech.po.exeception.RailtechException;

/**
 * @author MANOJ
 *
 */
public interface MasterInfoService {

	public Set<User> getUsers() throws RailtechException;

	public Set<Firm> getFirms() throws RailtechException;

	public Set<Warehouse> getWareHouses() throws RailtechException;
	
	public Set<Warehouse> getWareHouses(String firmId) throws RailtechException;
	
	public Set<Item> getItems() throws RailtechException;

	public Item getItemById(String itemId) throws RailtechException;
	
	public User getUserById(String userId) throws RailtechException;

	public Firm getFirmById(String firmId) throws RailtechException;
	
	public Firm getFirmByCode(String firmCode) throws RailtechException;

	public Warehouse getWareHouseById(String warehouseId) throws RailtechException;

	public Set<Unit> getUnits() throws RailtechException;

	public Unit getUnitById(Integer unitId) throws RailtechException;

	public Set<PL> getPLList() throws RailtechException;

	public Set<Code> getCodeList() throws RailtechException;

	public Code getCodeById(Integer codeId);

	public User getUserById(Integer userId) throws RailtechException;
	
	

}
