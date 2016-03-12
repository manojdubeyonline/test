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
import com.railtech.po.entity.JobWork;
import com.railtech.po.entity.PurchaseOrder;
import com.railtech.po.entity.PurchaseOrderItem;
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
	public JobWork getJobWorkById(Integer jobId) {
		logger.info("entering getJobWorkById. Param orderId:"+jobId);
		Session session = sessionFactory.getCurrentSession();
		Query query  = session.createQuery("from JobWork jobWork where jobWork.jobWorkId=:jobId").setInteger("jobId", jobId);
		JobWork job = (JobWork) query.uniqueResult();
		logger.info("exiting getJobWorkById. Return val:"+jobId);
		return job;
	}
	
	@Override
	public JobWork getJobWorkOrderById(Integer jobWorkId) {
		logger.info("entering getJobWorkOrderById. Param jobWorkId:"+jobWorkId);
		Session session = sessionFactory.getCurrentSession();
		Query query  = session.createQuery("from JobWork jobWork where jobWork.jobWorkId=:jobWorkId").setInteger("jobWorkId", jobWorkId);
		JobWork jobWork = (JobWork) query.uniqueResult();
		logger.info("exiting getJobWorkOrderById. Return val:"+jobWork);
		return jobWork;
	}
	
	@Override
	public PurchaseOrderItem getOrderItemById(Integer orderItemId) {
		logger.info("entering getOrderById. Param orderId:"+orderItemId);
		Session session = sessionFactory.getCurrentSession();
		Query query  = session.createQuery("from PurchaseOrderItem purchaseOrderItem where purchaseOrderItem.itemKey=:orderItemId").setInteger("orderItemId", orderItemId);
		PurchaseOrderItem orderItems = (PurchaseOrderItem) query.uniqueResult();
		logger.info("exiting getOrderById. Return val:"+orderItems);
		return orderItems;
	}

	@Override
	public void savePurchaseOrder(PurchaseOrder purchase) {
		logger.info("entering savePurchaseOrder");
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(purchase);
		logger.info("exiting savePurchaseOrder");
		
	}
	
	@Override
	public void saveJobWorkOrder(JobWork jobWork) {
		logger.info("entering saveJobWorkOrder");
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(jobWork);
		logger.info("exiting saveJobWorkOrder");
		
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
				
				refNo = "PO-"
						+ order.getFirm().getFirmCode()
								 + "/" + (Integer.parseInt(refCounter)+1) + "/"
						+ yyyy;
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
	public String generateJobWorkOrderNo(String firmId) {
		logger.info("entering generateJobWorkOrderNo");
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
				.createQuery(" from  JobWork jobWork"
						+ "  where jobWork.firm.firmId=:firmId and jobWork.jobWorkOrderNo like:refNo"
						+ " order by jobWork.jobWorkId desc");

		query.setInteger("firmId", Integer.parseInt(firmId));
		query.setString("refNo", "%" + yyyy);
		query.setMaxResults(1);

		JobWork jobWork = (JobWork) query.uniqueResult();
		
		String refNo = null;
		if (jobWork != null) {
			logger.debug("order:" + jobWork);
			String refCounter = jobWork.getJobWorkOrderNo().substring(jobWork.getJobWorkOrderNo().indexOf("/")+1,jobWork.getJobWorkOrderNo().lastIndexOf("/"));
			
			
			if (refCounter != null) {
				
				refNo = "JOB-"
						+ jobWork.getFirm().getFirmCode()
								 + "/" + (Integer.parseInt(refCounter)+1) + "/"
						+ yyyy;
				}
				
			
			
		}else{
			logger.debug("purchase:" + jobWork);
			
			refNo = "JOB-"
						+ masterInfoService.getFirmById(firmId).getFirmCode() + "/1/"
						+ yyyy;
			
		}
		logger.debug("returnVal:" + refNo.toString());
		logger.info("exiting generateJobWorkOrderNo");
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
	@SuppressWarnings("unchecked")
	public List<JobWork> getJobWorkList(FlexiBean requestParams) {
		logger.info("entering getJobWorkList");
		Session session = sessionFactory.getCurrentSession();
		Query query = session
				.createQuery("from JobWork jobWork");
		
		List<JobWork> jobWork = new ArrayList<JobWork>(
				query.list());
		logger.debug("returnVal of jobWorks:" + jobWork);
		
		logger.info("exiting getJobWorkList");
		return jobWork;
	}
	
	
	@Override
	@Transactional
	public void delete(PurchaseOrder purchase) {
		Session session = sessionFactory.getCurrentSession();
		session.delete(purchase);
		session.flush();
		session.clear();

	}

	@Override
	@Transactional
	public void deleteJob(JobWork jobWork) {
		Session session = sessionFactory.getCurrentSession();
		session.delete(jobWork);
		session.flush();
		session.clear();

	}

	
	
	@Override
	public Double getOrderQtyById(Integer markingId) {
		logger.info("entering getOrderQtyById");
		Session session = sessionFactory.getCurrentSession();
		Query query  = session.createQuery("from PurchaseOrderItem purchaseOrderItem where purchaseOrderItem.itemKey=:markingId").setInteger("markingId", markingId);
		PurchaseOrderItem orderItem = (PurchaseOrderItem) query.uniqueResult();
		Double Qty = 0.0;
		if(orderItem != null){
			Qty = orderItem.getQty();
		}
		logger.info("exiting getOrderQtyById");
		return Qty;
	}


}
