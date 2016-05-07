package com.railtech.po.service.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

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
import com.railtech.po.entity.GRPO;
import com.railtech.po.entity.GRPOReceiptEntry;
import com.railtech.po.entity.PurchaseOrder;
import com.railtech.po.entity.PurchaseOrderItem;
import com.railtech.po.entity.Requisition;
import com.railtech.po.entity.Warehouse;
import com.railtech.po.service.GRPOService;
import com.railtech.po.service.MasterInfoService;
@Repository(value = "GRPOServiceImpl")
@Service
@Transactional
public class GRPOServiceImpl implements GRPOService {
	@Resource(name = "sessionFactory")
	private SessionFactory sessionFactory;
	private static Logger logger = Logger
			.getLogger(GRPOServiceImpl.class);
	
	@Autowired
	MasterInfoService masterInfoService;
	/*
	@Override
	public GRPO getGRPOById(Integer grpoId) {
		logger.info("entering getGRPOById. Param grpoId:"+grpoId);
		Session session = sessionFactory.getCurrentSession();
		Query query  = session.createQuery("from GRPO GRPO where GRPO.grpoId=:grpoId").setInteger("grpoId", grpoId);
		GRPO grpo = (GRPO) query.uniqueResult();
		logger.info("exiting getGRPOById. Return val:"+grpo);
		if(grpo!=null){
			Hibernate.initialize(grpo.getGrpoReceiptItems());
		}
		logger.info("exiting getGRPOById");
		return grpo;
	}
	*/
	
	@Override
	public GRPO getGRPOById(Integer grpoId) {
		logger.info("entering getGRPOById. Param grpoId:"+grpoId);
		Session session = sessionFactory.getCurrentSession();
		Query query  = session.createQuery("from GRPO grpo where grpo.grpoId=:grpoId").setInteger("grpoId", grpoId);
		GRPO grpo = (GRPO) query.uniqueResult();
		logger.info("exiting getGRPOById. Return val:"+grpo);
		if(grpo != null){
			Hibernate.initialize(grpo.getGrpoReceiptItems());
		}
		return grpo;
	}
	
	

	@Override
	public GRPOReceiptEntry getGrpoRecieptById(Integer grpoRecieptId) {
		logger.info("entering getGrpoRecieptById. Param orderId:"+grpoRecieptId);
		Session session = sessionFactory.getCurrentSession();
		Query query  = session.createQuery("from GRPOReceiptEntry grpoReceiptEntry where grpoReceiptEntry.grpoEntryId=:grpoRecieptId").setInteger("grpoRecieptId", grpoRecieptId);
		GRPOReceiptEntry grpoReceiptEntry = (GRPOReceiptEntry) query.uniqueResult();
		logger.info("exiting getGrpoRecieptById. Return val:"+grpoRecieptId);
		return grpoReceiptEntry;
	}

	@Override
	public void saveGrpo(GRPO grpo) {
		logger.info("entering saveGRPO");
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(grpo);
		logger.info("exiting saveGRPO");
		
	}
	
	/*
	@Override
	public String generateGoodsRecieptNo(String firmId) {
		logger.info("entering generateGoodsRecieptNo");
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
				.createQuery(" from  GRPO grpo"
						+ "  where grpo.orderId.firm.firmId=:firmId and grpo.goodsRecieptNo like:recieptNo"
						+ " order by grpo.grpoId desc");

		query.setInteger("firmId", Integer.parseInt(firmId));
		query.setString("recieptNo", "%" + yyyy);
		query.setMaxResults(1);

		GRPO grpo = (GRPO) query.uniqueResult();
		
		String recieptNo = null;
		if (grpo != null) {
			logger.debug("order:" + grpo);
			String refCounter = grpo.getGoodsRecieptNo().substring(grpo.getGoodsRecieptNo().indexOf("/")+1,grpo.getGoodsRecieptNo().lastIndexOf("/"));
			
			
			if (refCounter != null) {
				
				recieptNo = "GR-"
						+ grpo.getOrderId().getFirm().getFirmCode()
								 + "/" + (Integer.parseInt(refCounter)+1) + "/"
						+ yyyy;
				}
				
			
			
		}else{
			logger.debug("purchase:" + grpo);
			
			recieptNo = "GR-"
						+ masterInfoService.getFirmById(firmId).getFirmCode() + "/1/"
						+ yyyy;
			
		}
		logger.debug("returnVal:" + recieptNo.toString());
		logger.info("exiting generateGoodsRecieptNo");
		return recieptNo;
	}
	*/
	
	
	@Override
	public String generateGoodsRecieptNo(String firmId, String wareId) {
		logger.info("entering generateGoodsRecieptNo");
		logger.debug("param:firmId:" + firmId);
		logger.debug("param:wareId:" + wareId);
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
				.createQuery(" from  GRPO grpo"
						+ "  where grpo.firm.firmId=:firmId and grpo.warehouse.wareId =:wareId and grpo.goodsRecieptNo like:refNo"
						+ " order by grpo.grpoId desc");

		query.setInteger("firmId", Integer.parseInt(firmId));
		query.setInteger("wareId", Integer.parseInt(wareId));
		query.setString("refNo", "%" + yyyy);
		query.setMaxResults(1);

		GRPO grpo = (GRPO) query.uniqueResult();
		
		String recieptNo = null;
		if (grpo != null) {
			logger.debug("grpo:" + grpo);
			String refCounter = grpo.getGoodsRecieptNo().substring(grpo.getGoodsRecieptNo().indexOf("/")+1,grpo.getGoodsRecieptNo().lastIndexOf("/"));

			if (refCounter != null) {
				recieptNo = "GR-"
						+ grpo.getWarehouse()
								.getWarehouseCode() + "/" + (Integer.parseInt(refCounter)+1) + "/"
						+ yyyy;
			}
		}else{
			logger.debug("grpo:" + grpo);
			
			Warehouse warehouse = masterInfoService.getWareHouseById(wareId);
				
			recieptNo = "GR-"
						+ warehouse.getWarehouseCode() + "/1/"
						+ yyyy;
			
		}
		logger.debug("returnVal:" + recieptNo.toString());
		logger.info("exiting generateGoodsRecieptNo");
		return recieptNo;
	}
	
	
	
	@Override
	@SuppressWarnings("unchecked")
	public List<GRPO> getGRPOList(FlexiBean requestParams) {
		logger.info("entering getGRPOList");
		Session session = sessionFactory.getCurrentSession();
		Query query = session
				.createQuery("from GRPO grpo  order by grpo.grDate desc");
		
		List<GRPO> grpos = new ArrayList<GRPO>(
				query.list());
		logger.debug("returnVal of grpos:" + grpos);
		
		logger.info("exiting getGRPOList");
		return grpos;
	}
	
	@Override
	@Transactional
	public void delete(GRPO grpo) {
		Session session = sessionFactory.getCurrentSession();
		session.delete(grpo);
		session.flush();
		session.clear();

	}
	
	@Override
	public List<GRPOReceiptEntry> getOrderByOrderItemId(Integer OrderItemId) {
	logger.info("entering getOrderByOrderItemId");
	Session session = sessionFactory.getCurrentSession();
	Query query  = session.createQuery("from GRPOReceiptEntry receiptEntry where receiptEntry.orderItemId.itemKey=:OrderItemId").setInteger("OrderItemId", OrderItemId);
	List<GRPOReceiptEntry> receiptEntry = new ArrayList<GRPOReceiptEntry>(query.list());
	
	logger.info("entering getOrderByOrderItemId");
	return receiptEntry;
}
	

}
