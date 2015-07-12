/**
 * 
 */
package com.railtech.po.service.impl;

import java.util.HashSet;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.railtech.po.entity.Firm;
import com.railtech.po.entity.Item;
import com.railtech.po.entity.User;
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


}
