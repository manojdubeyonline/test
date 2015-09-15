/**
 * 
 */
package com.railtech.po.service.impl;

import java.util.Calendar;
import java.util.HashSet;
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
import com.railtech.po.entity.Requisition;
import com.railtech.po.entity.Warehouse;
import com.railtech.po.exeception.RailtechException;
import com.railtech.po.service.MasterInfoService;
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
	private static Logger logger = Logger
			.getLogger(RequisitionServiceImpl.class);
	
	@Autowired
	MasterInfoService masterInfoService;

	@Override
	@Transactional
	public void saveOrUpdate(Requisition requisition) throws RailtechException {
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(requisition);
		session.clear();

	}

	@Override
	public Set<Requisition> getRequisitions(FlexiBean requestParams)
			throws RailtechException {
		logger.info("entering getRequisitions");
		Session session = sessionFactory.getCurrentSession();
		Query query = session
				.createQuery("from Requisition requisition where requisition.fullFillmentStatus =:fullFillmentStatus  order by requisition.requestedDate").setString("fullFillmentStatus", "N");
		@SuppressWarnings("unchecked")
		Set<Requisition> requisitionList = new HashSet<Requisition>(
				query.list());
		logger.debug("returnVal No of requisitions:" + requisitionList.size());
		for(Requisition requisition: requisitionList){
			if(null!=requisition){
				Hibernate.initialize(requisition.getRequisitionItems());
			}
		}
		logger.info("exiting getRequisitions");
		return requisitionList;

	}

	@Override
	@Transactional
	public void delete(Requisition requisition) {
		Session session = sessionFactory.getCurrentSession();
		session.delete(requisition);
		session.clear();

	}

	@Override
	@Transactional
	public Requisition getRequisitionById(Long requisitionId) {
		logger.info("entering getRequisitionByRequisitionId");
		logger.debug("param:" + requisitionId);
		Session session = sessionFactory.getCurrentSession();
		Query query = session
				.createQuery(
						"from Requisition requisition where requisition.requisitionId =:requisitionId")
				.setLong("requisitionId", requisitionId);
		Requisition requisition = (Requisition) query.uniqueResult();
		if(null!=requisition){
			Hibernate.initialize(requisition.getRequisitionItems());
		}
		logger.debug("returnVal:" + requisition.toString());
		logger.info("exiting getRequisitionByRequisitionId");
		return requisition;
	}
	
	@Override
	public Requisition getRequisitionByRefNo(String refNo) {
		logger.info("entering getRequisitionByRefNo");
		logger.debug("param:" + refNo);
		Session session = sessionFactory.getCurrentSession();
		Query query = session
				.createQuery(
						"from Requisition requisition where requisition.requisitionRefNo =:refNo")
				.setString("refNo", refNo);
		Requisition requisition = (Requisition) query.uniqueResult();
		if(null!=requisition){
			Hibernate.initialize(requisition.getRequisitionItems());
		}
		logger.debug("returnVal:" + requisition);
		logger.info("exiting getRequisitionByRefNo");
		return requisition;
	}

	@Override
	public String generateRequisitionRefNo(String firmId, String storeId) {
		logger.info("entering generateRequisitionRefNo");
		logger.debug("param:firmId:" + firmId);
		logger.debug("param:storeId:" + storeId);
		Session session = sessionFactory.getCurrentSession();
		/*Query query = session
				.createQuery(" from  Requisition requisition"
						+ "  where requisition.requestedForFirm.firmId=:firmId and requisition.requestedAtWareHouse.wareId =:wareId and requisition.requisitionRefNo like :refNo"
						+ " and MAX(SUBSTR( requisition.requisitionRefNo ,LOCATE('/',requisition.requisitionRefNo)+1 ,"
						+ "LENGTH(requisition.requisitionRefNo)-LOCATE('/',requisition.requisitionRefNo)-5)+0) ");
		*/
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
				.createQuery(" from  Requisition requisition"
						+ "  where requisition.requestedForFirm.firmId=:firmId and requisition.requestedAtWareHouse.wareId =:wareId and requisition.requisitionRefNo like:refNo"
						+ " order by requisition.requisitionId desc");

		query.setInteger("firmId", Integer.parseInt(firmId));
		query.setInteger("wareId", Integer.parseInt(storeId));
		query.setString("refNo", "%" + yyyy);
		query.setMaxResults(1);

		Requisition requisition = (Requisition) query.uniqueResult();
		
		String refNo = null;
		if (requisition != null) {
			logger.debug("requisition:" + requisition);
			String refCounter = requisition.getRequisitionRefNo()
					.substring(
							requisition.getRequisitionRefNo().indexOf(
									"/",
									requisition.getRequisitionRefNo()
											.lastIndexOf("/")));

			if (refCounter != null) {
				refNo = "REQ-"
						+ requisition.getRequestedAtWareHouse()
								.getWarehouseCode() + "/" + refCounter + "/"
						+ yyyy;
			}
		}else{
			logger.debug("requisition:" + requisition);
			
			Warehouse warehouse = masterInfoService.getWareHouseById(storeId);
				
			refNo = "REQ-"
						+ warehouse.getWarehouseCode() + "/1/"
						+ yyyy;
			
		}
		logger.debug("returnVal:" + refNo.toString());
		logger.info("exiting generateRequisitionRefNo");
		return refNo;
	}


}
