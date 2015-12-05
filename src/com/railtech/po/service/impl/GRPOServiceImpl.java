package com.railtech.po.service.impl;

import java.util.ArrayList;
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
import com.railtech.po.entity.GRPO;

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
	
	@Override
	public GRPO getGRPOById(Integer grpoId) {
		logger.info("entering getGRPOById. Param grpoId:"+grpoId);
		Session session = sessionFactory.getCurrentSession();
		Query query  = session.createQuery("from GRPO GRPO where GRPO.grpoId=:grpoId").setInteger("grpoId", grpoId);
		GRPO grpo = (GRPO) query.uniqueResult();
		logger.info("exiting getGRPOById. Return val:"+grpo);
		return grpo;
	}

	@Override
	public void saveGRPO(GRPO grpo) {
		logger.info("entering saveGRPO");
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(grpo);
		logger.info("exiting saveGRPO");
		
	}
	
	
	@Override
	@SuppressWarnings("unchecked")
	public List<GRPO> getGRPOList(FlexiBean requestParams) {
		logger.info("entering getGRPOList");
		Session session = sessionFactory.getCurrentSession();
		Query query = session
				.createQuery("from GRPO grpo");
		
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

}
