package com.railtech.po.service.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.railtech.po.entity.FlexiBean;
import com.railtech.po.entity.PurchaseOrder;
import com.railtech.po.service.MasterInfoService;
import com.railtech.po.service.PurchaseService;
@Repository(value = "PurchaseServiceImpl")
@Service
@Transactional
public class PurchaseServiceImpl implements PurchaseService {
	@Resource(name = "sessionFactory")
	private SessionFactory sessionFactory;
	private static Logger logger = Logger
			.getLogger(PurchaseServiceImpl.class);
	
	@Autowired
	MasterInfoService masterInfoService;
	
	@Override
	public PurchaseOrder getOrderById(Integer orderId) {
		logger.info("entering getOrderById. Param orderId:"+orderId);
		Session session = sessionFactory.getCurrentSession();
		Query query  = session.createQuery("from PurchaseOrder purchaseOrder where purchaseOrder.orderId=:orderId").setInteger("orderId", orderId);
		PurchaseOrder order = (PurchaseOrder) query.uniqueResult();
		logger.info("exiting getOrderById. Return val:"+order);
		return order;
	}

	@Override
	public void savePurchaseOrder(PurchaseOrder purchase) {
		logger.info("entering savePurchaseOrder");
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(purchase);
		logger.info("exiting savePurchaseOrder");
		
	}
	
	@SuppressWarnings("unused")
	@Override
	public String generatePurchaseOrderNo(String firmId) {
		logger.info("entering generatePurchaseOrderNo");
		logger.debug("param:firmId:" + firmId);
		Session session = sessionFactory.getCurrentSession();
		int month = 0;

		Calendar cal = Calendar.getInstance();
		month = cal.get(Calendar.MONTH);
		month = month + 1;
		int year = cal.get(Calendar.YEAR);
		if (month < 4) {
			year--;
		}

		String yyyy = "" + year;

		Query query = session
				.createQuery(" from  PurchaseOrder purchase"
						+ "  where purchase.firm.firmId=:firmId and purchase.purchaseOrderNo like:refNo"
						+ " order by purchase.orderId desc");

		query.setInteger("firmId", Integer.parseInt(firmId));
		query.setString("refNo", "%" + yyyy);
		query.setMaxResults(1);

		PurchaseOrder order = (PurchaseOrder) query.uniqueResult();
		
		String refNo = null;
		if (order != null) {
			logger.debug("order:" + order);
			String refCounter = order.getPurchaseOrderNo().substring(order.getPurchaseOrderNo().indexOf("/")+1,order.getPurchaseOrderNo().lastIndexOf("/"));
			
			
			if (refCounter != null) {
				if(order.getOrderType().equalsIgnoreCase("Purchase Order") ){
				refNo = "PPO-"
						+ order.getFirm().getFirmCode()
								 + "/" + (Integer.parseInt(refCounter)+1) + "/"
						+ yyyy;
				}
				else{
					refNo = "PLP-"
							+ order.getFirm().getFirmCode()
									 + "/" + (Integer.parseInt(refCounter)+1) + "/"
							+ yyyy;
				
				}
			}
			
		}else{
			logger.debug("purchase:" + order);
			
			refNo = "PO-"
						+ masterInfoService.getFirmById(firmId).getFirmCode() + "/1/"
						+ yyyy;
			
		}
		logger.debug("returnVal:" + refNo.toString());
		logger.info("exiting generatePurchaseOrderNo");
		return refNo;
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<PurchaseOrder> getOrderList(FlexiBean requestParams) {
		logger.info("entering getOrderList");
		Session session = sessionFactory.getCurrentSession();
		Query query = session
				.createQuery("from PurchaseOrder purchaseOrder");
		
		List<PurchaseOrder> orders = new ArrayList<PurchaseOrder>(
				query.list());
		logger.debug("returnVal of orders:" + orders);
		
		logger.info("exiting getOrderList");
		return orders;
	}
	
	
	@Override
	@Transactional
	public void delete(PurchaseOrder purchase) {
		Session session = sessionFactory.getCurrentSession();
		session.delete(purchase);
		session.flush();
		session.clear();

	}


}
