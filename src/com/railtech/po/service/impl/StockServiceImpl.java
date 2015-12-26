/**
 * 
 */
package com.railtech.po.service.impl;


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
import com.railtech.po.entity.ItemIssue;
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
		logger.debug("returnVal No of itemIssues:" + itemIssueList.size());
				logger.info("exiting getStockIssues");
		return itemIssueList;
	}

	
}
