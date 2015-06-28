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

import com.railtech.po.entity.User;
import com.railtech.po.exeception.RailtechException;
import com.railtech.po.service.UserManagementService;

/**
 * @author MANOJ
 *
 */

@Repository(value = "UserManagementServiceImpl")
@Service
@Transactional
public class UserManagementServiceImpl implements UserManagementService {

	@Resource(name = "sessionFactory")
    private SessionFactory sessionFactory;
	private static Logger logger = Logger.getLogger(UserManagementServiceImpl.class);
	
	@Override
	public void addUser(User user) throws RailtechException {
		Session session = sessionFactory.getCurrentSession();
		session.save(user);
	}


	@Override
	@Transactional
	public User modifyUser(User user){
		Session session = sessionFactory.getCurrentSession();
		session.update(user);
		return user;
	}
	
	@Override
	@Transactional
	public void delete(User user){
		Session session = sessionFactory.getCurrentSession();
		session.delete(user);
	}

	@Override
	public Set<User> getUserList() {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from User user order by user.userName");
		@SuppressWarnings("unchecked")
		Set <User> userList = new HashSet<User>(query.list());
		return userList;
	}
	
	@Override
	public User getUserByUserId(Long userId) {
		logger.info("entering getUserByUserId");
		logger.debug("param:"+userId);
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from User user where user.id =:userId").setLong("userId", userId);
		User user = (User)query.uniqueResult();
		logger.debug("returnVal:"+user.toString());
		logger.info("exiting getUserByUserId");
		return user;
	}
	
	@Override
	public User getUserByUserName(String userName) {
		logger.info("entering getUserByUserName");
		logger.debug("param:"+userName);
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from User user where user.userName =:userName").setString("userName", userName);
		User user = (User)query.uniqueResult();
		logger.debug("returnVal:"+user);
		logger.info("exiting getUserByUserId");
		return user;
	}

}
