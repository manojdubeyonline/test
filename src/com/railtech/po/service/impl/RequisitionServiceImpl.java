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

import com.railtech.po.entity.FlexiBean;
import com.railtech.po.entity.Requisition;
import com.railtech.po.exeception.RailtechException;
import com.railtech.po.service.RequisitionService;

/**
 * @author MANOJ
 *
 */
@Repository(value = "RequisitionServiceImpl")
@Service
@Transactional
public class RequisitionServiceImpl implements RequisitionService {

	@Resource(name = "sessionFactory")
    private SessionFactory sessionFactory;
	private static Logger logger = Logger.getLogger(RequisitionServiceImpl.class);
	
	@Override
	public void saveOrUpdate(Requisition requisition) throws RailtechException {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(requisition);
		
	}

	@Override
	public Set<Requisition> getRequisitions(FlexiBean requestParams) throws RailtechException {
		logger.info("entering getRequisitions");
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from Requisition requisition order by requisition.requestedDate");
		@SuppressWarnings("unchecked")
		Set <Requisition> requisitionList = new HashSet<Requisition>(query.list());
		logger.debug("returnVal No of requisitions:"+requisitionList.size());
		logger.info("exiting getRequisitions");
		return requisitionList;

	}

	
	@Override
	@Transactional
	public void delete(Requisition requisition) {
		Session session = sessionFactory.getCurrentSession();
		session.delete(requisition);
		
	}

	@Override
	public Requisition getRequisitionById(Long requisitionId) {
		logger.info("entering getRequisitionByRequisitionId");
		logger.debug("param:"+requisitionId);
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from Requisition requisition where requisition.requisitionId =:requisitionId").setLong("requisitionId", requisitionId);
		Requisition requisition= (Requisition)query.uniqueResult();
		logger.debug("returnVal:"+requisition.toString());
		logger.info("exiting getRequisitionByRequisitionId");
		return requisition;
	}

	
}
