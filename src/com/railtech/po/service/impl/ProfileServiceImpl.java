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

import com.railtech.po.entity.Profile;
import com.railtech.po.exeception.RailtechException;
import com.railtech.po.service.ProfileService;

/**
 * @author MANOJ
 *
 */
@Repository(value = "ProfileServiceImpl")
@Service
@Transactional
public class ProfileServiceImpl implements ProfileService{

	@Resource(name = "sessionFactory")
    private SessionFactory sessionFactory;
	private static Logger logger = Logger.getLogger(ProfileServiceImpl.class);
	@Override
	public void addProfile(Profile profile) throws RailtechException {
		Session session = sessionFactory.getCurrentSession();
		session.save(profile);
		
	}

	@Override
	public Set<Profile> getProfiles() throws RailtechException {
		logger.info("entering getProfiles");
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from Profile profile order by profile.profileName");
		@SuppressWarnings("unchecked")
		Set <Profile> profileList = new HashSet<Profile>(query.list());
		logger.debug("returnVal No of profiles:"+profileList.size());
		logger.info("exiting getProfiles");
		return profileList;

	}

	@Override
	@Transactional
	public Profile modifyProfile(Profile profile) {
		Session session = sessionFactory.getCurrentSession();
		session.update(profile);
		return profile;
	}

	@Override
	@Transactional
	public void delete(Profile profile) {
		Session session = sessionFactory.getCurrentSession();
		session.delete(profile);
		
	}

	@Override
	public Profile getProfileByProfileId(Long profileId) {
		logger.info("entering getProfileByProfileId");
		logger.debug("param:"+profileId);
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from Profile profile where profile.id =:profileId").setLong("profileId", profileId);
		Profile profile= (Profile)query.uniqueResult();
		logger.debug("returnVal:"+profile.toString());
		logger.info("exiting getProfileByProfileId");
		return profile;
	}

}
