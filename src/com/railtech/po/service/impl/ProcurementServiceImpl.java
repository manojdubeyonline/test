/**
 * 
 */
package com.railtech.po.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.railtech.po.entity.FlexiBean;
import com.railtech.po.entity.ItemStock;
import com.railtech.po.entity.Procurement;
import com.railtech.po.exeception.RailtechException;
import com.railtech.po.service.MasterInfoService;
import com.railtech.po.service.ProcurementService;


/**
 * @author MANOJ
 *
 */
@Repository(value = "ProcurementServiceImpl")
@Service
@Transactional
public class ProcurementServiceImpl implements ProcurementService {

	@Resource(name = "sessionFactory")
	private SessionFactory sessionFactory;
	private static Logger logger = Logger
			.getLogger(RequisitionServiceImpl.class);
	
	@Autowired
	MasterInfoService masterInfoService;

	@Override
	public Set<ItemStock> getStockList(FlexiBean requestParams)
			throws RailtechException {
		logger.info("entering getStockList");
		Session session = sessionFactory.getCurrentSession();
		Query query = session
				.createQuery("from ItemStock itemStock");
		@SuppressWarnings("unchecked")
		Set<ItemStock> stockList = new HashSet<ItemStock>(query.list());
		logger.debug("returnVal No of requisitions:" + stockList);
		logger.info("exiting getStockList");
		return stockList;
	}

	@Override
	public Procurement getProcurementById(Integer procurementId) {
		logger.info("entering getProcurementById");
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from Procurement procurement where markingId=:markingId").setInteger("markingId", procurementId);
		Procurement procurement = (Procurement)query.uniqueResult();
		logger.info("entering getProcurementById");
		return procurement;
	}
	
	

	@Override
	public List<Procurement> getProcureQtyByReqItemId(Integer requisitionItemId) {
		logger.info("entering getProcureQtyByReqItemId");
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from Procurement procurement where procurement.requisitionItemId.itemKey=:requisitionItemId").setInteger("requisitionItemId", requisitionItemId);
		//ItemIssue itemIssue = (ItemIssue) query.uniqueResult();
		List<Procurement> procurement = new ArrayList<Procurement>(query.list());
		
		logger.info("entering getProcureQtyByReqItemId");
		return procurement;
	}
	
	

	@Override
	public void saveProcurementMarking(Procurement procurement){
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(procurement);
	}


	@Override
	public List<Procurement> getProcurements()
			throws RailtechException {
		logger.info("entering getProcurements");
		Session session = sessionFactory.getCurrentSession();
	Query query  = session
				.createQuery("from Procurement procurement order by procurement.dueDate desc");
	
		@SuppressWarnings("unchecked")
		List<Procurement> markingList = new ArrayList<Procurement>(
				query.list());
		logger.debug("returnVal of markingList:" + markingList);
		
		logger.info("exiting getProcurements");
		return markingList;

	}
	
	@Override
	public List<Procurement> getProcurements(FlexiBean requestParams)
			throws RailtechException {
		logger.info("entering getProcurements");
		Session session = sessionFactory.getCurrentSession();
		Query query = null;
		if(!StringUtils.isEmpty(requestParams.getQuery())){
			query = session
					.createQuery("from Procurement procurement where procurement.requisitionItemId.itemCode."+requestParams.getQtype().trim()+" like:"+requestParams.getQtype().trim()).setString(requestParams.getQtype().trim(), "%"+requestParams.getQuery()+"%");
			
		
		}
		else{
		query = session
				.createQuery("from Procurement procurement order by procurement.markingDate desc");
		}
		@SuppressWarnings("unchecked")
		List<Procurement> markingList = new ArrayList<Procurement>(
				query.list());
		logger.debug("returnVal of markingList:" + markingList);
		
		logger.info("exiting getProcurements");
		return markingList;

	}
	
	@Override
	public List<Procurement> getProcurementQtyByReqItemId(Integer requisitionItemId) {
		logger.info("entering getProcurementQtyByReqItemId");
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from Procurement procurement where procurement.requisitionItemId.itemKey=:requisitionItemId").setInteger("requisitionItemId", requisitionItemId);
		//ItemIssue itemIssue = (ItemIssue) query.uniqueResult();
		List<Procurement> procurement = new ArrayList<Procurement>(query.list());
		
		logger.info("entering getProcurementQtyByReqItemId");
		return procurement;
	}
	
	
	@SuppressWarnings({ "unchecked" })
	@Override
	public List<Procurement> getProcurementByMultipleId(String procurementId)
			throws RailtechException {
		logger.info("entering getPurchaseOrder");
		Session session = sessionFactory.getCurrentSession();
		
		String str[] = procurementId.split(",");
		Integer id[] = new Integer[str.length]; 
		for(int i=0;i<str.length;i++){
		id[i]=Integer.parseInt(str[i]);
		} 
		
		//List<Integer> ids = Arrays.asList(id);
		Query query = session
				.createQuery("from Procurement procurement where markingId in (:markingIds)");
		query.setParameterList("markingIds",id);
		
		List<Procurement> markingList = new ArrayList<Procurement>(query.list());
				
		logger.debug("returnVal of markingList:" + markingList);

		logger.info("exiting getPurchaseOrder");
		return markingList;

	}

	


}
