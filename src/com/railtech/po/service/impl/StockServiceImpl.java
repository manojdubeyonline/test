/**
 * 
 */
package com.railtech.po.service.impl;


import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.railtech.po.entity.FlexiBean;
import com.railtech.po.entity.ItemIssue;
import com.railtech.po.entity.Procurement;
import com.railtech.po.entity.PurchaseOrder;
import com.railtech.po.entity.WarehouseBorrow;
import com.railtech.po.exeception.RailtechException;


import com.railtech.po.service.MasterInfoService;
import com.railtech.po.service.StockService;

/**
 * @author MANOJ
 *
 */
@Repository(value = "StockServiceImpl")
@Service
@Transactional
public class StockServiceImpl implements StockService {

	@Resource(name = "sessionFactory")
	private SessionFactory sessionFactory;
	private static Logger logger = Logger
			.getLogger(StockServiceImpl.class);
	
	@Autowired
	MasterInfoService masterInfoService;

	@Override
	public Set<ItemIssue> getItemIssue(FlexiBean requestParams)
			throws RailtechException {
		logger.info("entering getStockIssues");
		Session session = sessionFactory.getCurrentSession();
		Query query = session
				.createQuery("from ItemIssue itemIssue");
		@SuppressWarnings("unchecked")
		Set<ItemIssue> itemIssueList = new HashSet<ItemIssue>(query.list());
		logger.debug("returnVal No of itemIssues:" + itemIssueList);
				logger.info("exiting getStockIssues");
		return itemIssueList;
	}

	@Override
	public WarehouseBorrow getWarehouseBorrowById(Integer borrowId) {
		logger.info("entering getWarehouseBorrowById. Param borrowId:"+borrowId);
		Session session = sessionFactory.getCurrentSession();
		Query query  = session.createQuery("from WarehouseBorrow warehouseBorrow where warehouseBorrow.borrowId=:borrowId").setInteger("borrowId", borrowId);
		WarehouseBorrow borrow = (WarehouseBorrow) query.uniqueResult();
		logger.info("exiting getWarehouseBorrowById. Return val:"+borrow);
		return borrow;
	}

	@Override
	public void saveWarehouseBorrow(WarehouseBorrow borrow) {
		logger.info("entering saveWarehouseBorrow");
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(borrow);
		logger.info("exiting saveWarehouseBorrow");
		
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<WarehouseBorrow> getBorrowList(FlexiBean requestParams) {
		logger.info("entering getBorrowList");
		Session session = sessionFactory.getCurrentSession();
		Query query = session
				.createQuery("from WarehouseBorrow warehouseBorrow");
		
		List<WarehouseBorrow> borrow = new ArrayList<WarehouseBorrow>(
				query.list());
		logger.debug("returnVal of borrow:" + borrow);
		
		logger.info("exiting getBorrowList");
		return borrow;
	}

	@Override
	public Double getIssuedQtyByReqItemId(Integer requisitionItemId) {
		logger.info("entering getIssuedQtyByReqItemId");
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from ItemIssue itemIssue where itemIssue.requisitionItem.itemKey=:requisitionItemId").setInteger("requisitionItemId", requisitionItemId);
		ItemIssue itemIssue = (ItemIssue) query.uniqueResult();
		Double Qty = 0.0;
		if(itemIssue != null){
			Qty = itemIssue.getIssueQty();
		}
		logger.info("entering getIssuedQtyByReqItemId");
		return Qty;
	}

	
}
