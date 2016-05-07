/**
 * 
 */
package com.railtech.po.service;

import java.util.List;
import java.util.Set;

import com.railtech.po.entity.Code;
import com.railtech.po.entity.Firm;
import com.railtech.po.entity.FlexiBean;
import com.railtech.po.entity.Item;
import com.railtech.po.entity.PL;
import com.railtech.po.entity.PurchaseOrder;
import com.railtech.po.entity.Rate;
import com.railtech.po.entity.Role;
import com.railtech.po.entity.Unit;
import com.railtech.po.entity.User;
import com.railtech.po.entity.Vendor;
import com.railtech.po.entity.VendorDetails;
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

	public User getUserById(String userId, boolean loadDetails) throws RailtechException;
	public Set<PL> getPLList() throws RailtechException;

	public Set<Code> getCodeList() throws RailtechException;

	public Code getCodeById(Integer codeId);

	public User getUserById(Integer userId) throws RailtechException;

	public List<Vendor> getVendors() throws RailtechException;

	public Vendor getVendorById(String id);

	public Rate getRateById(Integer rateId);

	public List<Rate> getRates();

	public Set<VendorDetails> getAddresses(String vendorId) throws RailtechException;

	public VendorDetails getVendorDetailsById(String locationId);

	public List<Code> getCodeList(FlexiBean requestParams);

	public Role getUserRoleByRoleId(String roleId) throws RailtechException;
	
	

}
