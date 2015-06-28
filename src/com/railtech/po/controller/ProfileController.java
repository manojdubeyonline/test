/**
 * 
 */
package com.railtech.po.controller;

import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.railtech.po.entity.Profile;
import com.railtech.po.service.ProfileService;

/**
 * @author MANOJ
 *
 */
@Controller
@RequestMapping({ "profiles" })
public class ProfileController {
	@Autowired
	ProfileService profileService;
	private static Logger logger = Logger
			.getLogger(ProfileController.class);
	
	@RequestMapping(method = { RequestMethod.GET })
	public ModelAndView show(HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("profiles");
		Set<Profile> profileList = profileService.getProfiles();
		mav.addObject("profiles", profileList);

		return mav;
	}

	/**
	 * Add/Modify Campaign Managers
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = { "profilecrud" }, method = { RequestMethod.POST })
	public ModelAndView addModifyProfile(@RequestBody Profile profile,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String code = "SUCCESS";
		String message = "Successfully added the profile.";
		logger.info("entering addModifyProfile ");

		if (profile == null) {
			code = "ERROR";
			message = "Invalid Request. Missing Params";
		} else {
			try {
			if(profile.getId()!=null){
				message = "Successfully modified the profile.";
				profileService.modifyProfile(profile);
			}else{
				profileService.addProfile(profile);
			}
				
			} catch (Exception e) {
				logger.error(e);
				code = "ERROR";
				message = e.getMessage();
			}
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("profiles");
		mav.addObject("code", code);
		mav.addObject("message", message);
		return mav;
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = { "add" }, method = { RequestMethod.GET })
	public ModelAndView addCampaignManager(HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("profilecrud");
		mav.addObject("operation", "add");
		return mav;
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = { "update" }, method = { RequestMethod.POST })
	public ModelAndView updateProfile(@RequestParam Long id, HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		Profile user = profileService.getProfileByProfileId(id);
		mav.addObject("profile",user);
		mav.setViewName("profilecrud");
		mav.addObject("operation", "update");
		return mav;
	}
	
	/**
	 * Method to delete the users
	 */
	@RequestMapping(value = { "delete" }, method = { RequestMethod.POST })
	public ModelAndView deleteProfile(@RequestParam Long id, HttpServletRequest request,
			HttpServletResponse response) {
		
		String code = "SUCCESS";
		String message = "Successfully deleted profile.";
		try {
		
			Profile profile = profileService.getProfileByProfileId(id);
			profileService.delete(profile);
		}
		catch(Exception e) {
			logger.error(e);
			code = "ERROR";
			message = e.getMessage();
		}
		ModelAndView mav = new ModelAndView();
		mav.setViewName("profiles");
		mav.addObject("code", code);
		mav.addObject("message", message);
		return mav;
		}

	@RequestMapping(value={"getProfiles"},method = { RequestMethod.POST })
	public @ResponseBody Set<Profile> getProfiles(HttpServletRequest request,
			HttpServletResponse response) {
		logger.info("entering getProfiles()");
		Set<Profile> profileList = profileService.getProfiles();
		logger.info("exiting getProfiles()");
		return profileList;
	}

}
