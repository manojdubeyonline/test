/**
 * 
 */
package com.railtech.po.service.impl;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

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
import com.railtech.po.service.MasterInfoService;

/**
 * @author MANOJ
 *
 */
@Repository(value = "MasterInfoServiceImpl")
@Service
@Transactional
public class MasterInfoServiceImpl implements MasterInfoService {
	@Resource(name = "sessionFactory")
    private SessionFactory sessionFactory;
	private static Logger logger = Logger.getLogger(MasterInfoServiceImpl.class);
	
	@Override
	public Set<User> getUsers() throws RailtechException {
		logger.info("entering getRequisitions");
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from User user order by user.userName");
		@SuppressWarnings("unchecked")
		Set <User> userList = new HashSet<User>(query.list());
		logger.debug("returnVal No of users:"+userList.size());
		logger.info("exiting getUsers");
		return userList;

	}
	
	@Override
	public User getUserById(Integer userId) throws RailtechException {
		logger.info("entering getRequisitions");
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from User user  where user.userId =:userId").setInteger("userId", userId);
		
		User user = (User)(query.uniqueResult());
		logger.debug("returnVal No of users:"+user);
		if(user!=null){
			Hibernate.initialize(user.getUserFirms());
		}
		logger.info("exiting getUsers");
		return user;

	}
	
	@Override
	public Set<Item> getItems() throws RailtechException {
		logger.info("entering getItems");
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from Item item order by item.itemName");
		@SuppressWarnings("unchecked")
		Set <Item> itemList = new HashSet<Item>(query.list());
		logger.debug("returnVal No of users:"+itemList.size());
		logger.info("exiting getItems");
		return itemList;

	}
		
	@Override
	public Set<Firm> getFirms() throws RailtechException {
		logger.info("entering getFirms");
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from Firm firm order by firm.firmName");
		@SuppressWarnings("unchecked")
		Set <Firm> firmList = new HashSet<Firm>(query.list());
		logger.debug("returnVal No of users:"+firmList.size());
		logger.info("exiting getFirms");
		return firmList;

	}
	
	@Override
	public Set<Unit> getUnits() throws RailtechException {
		logger.info("entering getUnits");
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from Unit unit order by unit.unitName");
		@SuppressWarnings("unchecked")
		Set <Unit> unitList = new HashSet<Unit>(query.list());
		logger.debug("returnVal No of units:"+unitList.size());
		logger.info("exiting getUnits");
		return unitList;

	}
	
	@Override
	public Set<PL> getPLList() throws RailtechException {
		logger.info("entering getPLs");
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from PL pl order by pl.itemDesc");
		@SuppressWarnings("unchecked")
		Set <PL> plList = new HashSet<PL>(query.list());
		logger.debug("returnVal No of pls:"+plList.size());
		logger.info("exiting getPLList");
		return plList;

	}
	
	@Override
	public Set<Code> getCodeList() throws RailtechException {
		logger.info("entering getCodeList");
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from Code code order by code.itemName");
		@SuppressWarnings("unchecked")
		Set <Code> codeList = new HashSet<Code>(query.list());
		logger.debug("returnVal No of codes:"+codeList.size());
		logger.info("exiting getCodeList");
		return codeList;

	}
		
	
	@Override
	public Set<Warehouse> getWareHouses() throws RailtechException {
		logger.info("entering getWareHouses");
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from Warehouse warehouse order by warehouse.warehouseName");
		@SuppressWarnings("unchecked")
		Set <Warehouse> wareHouses = new HashSet<Warehouse>(query.list());
		logger.debug("returnVal No of users:"+wareHouses.size());
		logger.info("exiting getWareHouses");
		return wareHouses;

	}
	
	@Override
	public Set<Warehouse> getWareHouses(String firmId) throws RailtechException {
		logger.info("entering getWareHouses");
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from Warehouse warehouse where warehouse.firmId=:currentFirmId order by warehouse.warehouseName").setInteger("currentFirmId", Integer.valueOf(firmId));
		@SuppressWarnings("unchecked")
		Set <Warehouse> wareHouses = new HashSet<Warehouse>(query.list());
		logger.debug("returnVal No of users:"+wareHouses.size());
		logger.info("exiting getWareHouses");
		return wareHouses;

	}
	
	@Override
	public Set<VendorDetails> getAddresses(String vendorId) throws RailtechException {
		logger.info("entering getAddresses");
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from VendorDetails vendorDetails where vendorDetails.vendorId=:vendorId order by vendorDetails.clientCity").setInteger("vendorId", Integer.valueOf(vendorId));
		@SuppressWarnings("unchecked")
		Set <VendorDetails> addresses = new HashSet<VendorDetails>(query.list());
		logger.debug("returnVal No of addresses:"+addresses.size());
		logger.info("exiting getAddresses");
		return addresses;

	}
	

	@Override
	public Item getItemById(String itemId) throws RailtechException {
		logger.info("entering getItemById");
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from Item item where item.itemId =:itemId").setInteger("itemId", Integer.parseInt(itemId));
		Item item = (Item)query.uniqueResult();
		logger.debug("returnVal item:"+item.toString());
		logger.info("exiting getItemById");
		return item;
	}

	@Override
	public Unit getUnitById(Integer unitId) throws RailtechException {
		logger.info("entering getUnitById");
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from Unit unit where unit.unitId =:unitId").setInteger("unitId", unitId);
		Unit unit = (Unit)query.uniqueResult();
		logger.debug("returnVal unit:"+unit.toString());
		logger.info("exiting getUnitById");
		return unit;
	}
	
	@Override
	public User getUserById(String userId) throws RailtechException {
		logger.info("entering getUserById");
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from User user where user.userId =:userId").setLong("userId", Long.parseLong(userId));
		User user = (User)query.uniqueResult();
		logger.debug("returnVal No of user:"+user.toString());
		logger.info("exiting getUserById");
		return user;
	}
	
	@Override
	public Role getUserRoleByRoleId(String roleId) throws RailtechException {
		logger.info("entering getUserRoleByRoleId");
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from Role role where role.roleId =:roleId").setLong("roleId", Long.parseLong(roleId));
		Role role = (Role)query.uniqueResult();
		logger.debug("returnVal No of user:"+role.toString());
		logger.info("exiting getUserRoleByRoleId");
		return role;
	}
	
	

	@Override
	public Firm getFirmById(String firmId) throws RailtechException {
		logger.info("entering getFirmById");
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from Firm firm where firm.id =:firmId").setInteger("firmId",Integer.parseInt(firmId));
		Firm firm = (Firm)query.uniqueResult();
		logger.debug("returnVal of firm:"+firm.toString());
		logger.info("exiting getFirmById");
		return firm;
	}

	@Override
	public Firm getFirmByCode(String firmCode) throws RailtechException {
		logger.info("entering getFirmByCode");
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from Firm firm where firm.firmCode =:firmCode").setString("firmCode",firmCode);
		Firm firm = (Firm)query.uniqueResult();
		logger.debug("returnVal of firm:"+firm.toString());
		logger.info("exiting getFirmByCode");
		return firm;
	}

	@Override
	public Warehouse getWareHouseById(String warehouseId)
			throws RailtechException {
		logger.info("entering getWareHouseById");
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from Warehouse warehouse where warehouse.id =:warehouseId").setInteger("warehouseId", Integer.parseInt(warehouseId));
		Warehouse warehouse = (Warehouse)query.uniqueResult();
		logger.debug("returnVal No of user:"+warehouse.toString());
		logger.info("exiting getWareHouseById");
		return warehouse;
	}

	@Override
	public Code getCodeById(Integer codeId) {
		logger.info("entering getCodeById. Param:"+codeId);
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from Code code where code =:codeId").setInteger("codeId", codeId);
		Code code = (Code)query.uniqueResult();
		logger.debug("returnVal  of code:"+code);
		logger.info("exiting getCodeById");
		return code;
	}
	@Override
	public List<Vendor> getVendors() throws RailtechException {
		logger.info("entering getVendors");
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from Vendor vendor where vendor.purchase =:purchase order by vendor.vendorName").setString("purchase", "Y");
		@SuppressWarnings("unchecked")
		List <Vendor> vendorList = new LinkedList<Vendor>(query.list());
		logger.debug("returnVal No of users:"+vendorList);
		logger.info("exiting getVendors");
		return vendorList;

	}
	
	
	@Override
	public Vendor getVendorById(String vendorId) {
		logger.info("entering getVendorById. Param:"+vendorId);
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from Vendor vendor where vendor.vendorId =:vendorId").setInteger("vendorId", Integer.parseInt(vendorId));
		Vendor code = (Vendor)query.uniqueResult();
		logger.debug("returnVal  of code:"+code);
		logger.info("exiting getVendorById");
		return code;
	}
	
	@Override
	public VendorDetails getVendorDetailsById(String locationId) {
		logger.info("entering getVendorDetailsById. Param:"+locationId);
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from VendorDetails vendorDetails where vendorDetails.locationId =:locationId").setInteger("locationId", Integer.parseInt(locationId));
		VendorDetails code = (VendorDetails)query.uniqueResult();
		logger.debug("returnVal  of code:"+code);
		logger.info("exiting getVendorDetailsById");
		return code;
	}
	
	@Override
	public Rate getRateById(Integer rateId) {
		logger.info("entering getRateById. Param:"+rateId);
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from Rate rate where rate.rateId =:rateId").setInteger("rateId", rateId);
		Rate rate = (Rate)query.uniqueResult();
		logger.debug("returnVal  of rate:"+rate);
		logger.info("exiting getRateById");
		return rate;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Rate> getRates() {
		logger.info("entering getRates.");
		List<Rate> rates = null;
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from Rate rate");
		rates = new ArrayList<Rate>(
				query.list());
		logger.debug("returnVal  of rates:"+rates);
		logger.info("exiting getRates");
		return rates;
	}

	@Override
	public User getUserById(String userId, boolean loadDetails) throws RailtechException {
		logger.info("entering getUserById");
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from User user where user.userId =:userId").setLong("userId", Long.parseLong(userId));
		User user = (User)query.uniqueResult();
		if(user!=null && user.getUserRole()!=null && loadDetails){
			Hibernate.initialize(user.getUserRole().getAccess());
			logger.debug("returnVal No of user:"+user.toString());
		}
		if(user!=null &&  loadDetails){
			Hibernate.initialize(user.getUserWarehouses());
			logger.debug("returnVal No of user:"+user.toString());
		}
		
		logger.info("exiting getUserById");
		return user;
	}
	
	@Override
	public List<Code> getCodeList(FlexiBean requestParams) {
		logger.info("entering getCodeList");
		Session session = sessionFactory.getCurrentSession();
		String strQry = "from Code code";
		
		Query query  =null;
		if(!StringUtils.isEmpty(requestParams.getQuery())){
			query = session.createQuery(strQry+ " where code."+requestParams.getQtype()+" like:"+requestParams.getQtype()).setString(requestParams.getQtype(), "%" + requestParams.getQuery() + "%");
		}else{
			query = session.createQuery(strQry);
		}
		
		
		Query qry = query.setMaxResults(requestParams.getRp());
		qry.setFirstResult(requestParams.getRp()*(requestParams.getPage()-1));
		
		@SuppressWarnings("unchecked")
		List <Code> codeList = new ArrayList<Code>(qry.list());
		//codeList.size();
		logger.debug("returnVal No of codes:"+codeList.size());
		logger.info("exiting getCodeList");
		return codeList;
	}


}
