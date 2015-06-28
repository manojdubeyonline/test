/**
 * 
 */
package com.railtech.po.service;

import java.util.Set;

import com.railtech.po.entity.Profile;
import com.railtech.po.exeception.RailtechException;

/**
 * @author MANOJ
 *
 */
public interface ProfileService {
	public void addProfile(Profile profile) throws RailtechException;
	public Set<Profile> getProfiles() throws RailtechException;
	public Profile modifyProfile(Profile profile);
	public void delete(Profile profile);
	public Profile getProfileByProfileId(Long profileId);
	
		
}
