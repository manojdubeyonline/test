package com.railtech.po.controller;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.railtech.po.entity.Profile;
import com.railtech.po.entity.User;
import com.railtech.po.service.EmailService;
import com.railtech.po.service.ProfileService;
import com.railtech.po.service.UserManagementService;
import com.railtech.po.util.Crypto;
import com.railtech.po.util.PasswordUtil;

@Controller
@RequestMapping({ "users" })
public class UserManagementController {

	@Autowired
	UserManagementService userService;
	@Autowired
	EmailService emailService;

	@Autowired
	ProfileService profileService;
	@Autowired

	private static Logger logger = Logger
			.getLogger(UserManagementController.class);

	@RequestMapping(method = { RequestMethod.GET })
	@ExceptionHandler(Exception.class)
	public ModelAndView show(HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("users");
		Set<User> userList = userService.getUserList();
		mav.addObject("appUserList", userList);

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
	/*@RequestMapping(value = { "usercrud" }, method = { RequestMethod.POST })
	public ModelAndView addModifyUser(@RequestParam("file") MultipartFile file,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String code = "SUCCESS";
		String message = "Successfully added the user.";

		logger.info("entering addModifyUser ");
		User user = null;
		String userId = request.getParameter("userId");
		String userName = request.getParameter("userName");
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String email = request.getParameter("email");
		String status = request.getParameter("status");
		String profileIds[] = request.getParameterValues("userProfile");
		try {
			if (userId != null && userId.trim().length()!=0) {
				user = userService.getUserByUserId(Long.parseLong(userId));
				message = "Successfully modified the user.";
			}
			if (user == null) {
				user = new User();
				user.setUserName(userName);
			}
			//user.setFirstName(firstName);
			//user.setLastName(lastName);
			user.setEmail(email);

			Set<Profile> userProfiles = new HashSet<Profile>();
			if (profileIds != null && profileIds.length > 0) {
				for (int i = 0; i < profileIds.length; i++) {
					Profile p = profileService.getProfileByProfileId(Long
							.parseLong(profileIds[i]));
					if (p != null) {
						userProfiles.add(p);
					}
				}

			}

			//user.setUserProfiles(userProfiles);
			user.setStatus(status);
			if (!file.isEmpty()) {
				try {
					byte[] bytes = file.getBytes();
					//user.setPhoto(bytes);
				} catch (Exception e) {
				}
			}

		//	user.setPassword(Crypto.encrypt(PasswordUtil.generatePassword()));

		//	if (user.getId() == null) {
			//	user.setCreatedDate(new Date());
			//	userService.addUser(user);
//
			//} else {
			//	user.setUpdatedDate(new Date());
			//	userService.modifyUser(user);
			}
		} catch (Exception e) {
			logger.error(e);
			code = "ERROR";
			message = e.getMessage();
		}
		Set<User> users = userService.getUserList();
		ModelAndView mav = new ModelAndView();
		mav.setViewName("users");
		mav.addObject("code", code);
		mav.addObject("message", message);
		mav.addObject("appUserList", users);

		logger.info("exiting addModifyUser ");
		return mav;
	}
*/
	/**
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = { "addUser" }, method = { RequestMethod.GET })
	public ModelAndView addCampaignManager(HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("usercrud");
		mav.addObject("operation", "add");

		return mav;
	}

	/**
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = { "modifyUser" }, method = { RequestMethod.POST })
	public ModelAndView updateCampaignManager(HttpServletRequest request,
			HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		User user = userService.getUserByUserId(Long.parseLong(request
				.getParameter("ID")));
		mav.addObject("currentUser", user);
		mav.setViewName("usercrud");
		mav.addObject("operation", "modify");

		return mav;
	}

	/**
	 * Method to delete the users
	 */
	/*@RequestMapping(value = { "delete" }, method = { RequestMethod.POST })
	public ModelAndView deleteCustomer(@RequestParam Long id,
			HttpServletRequest request, HttpServletResponse response) {

		String code = "SUCCESS";
		String message = "Successfully deleted user.";
		try {
			User user = new User();
			user.setId(id);
			user = userService.getUserByUserId(user.getId());
			
		} catch (Exception e) {
			logger.error(e);
			code = "ERROR";
			message = e.getMessage();
		}
		Set<User> users = userService.getUserList();
		ModelAndView mav = new ModelAndView();
		mav.setViewName("users");
		mav.addObject("code", code);
		mav.addObject("message", message);
		mav.addObject("appUserList", users);

		return mav;
	}*/

	/*@RequestMapping(value = "/getUserImage/{id}")
	public void getUserImage(HttpServletResponse response,
			@PathVariable("id") Long id) throws IOException {
		response.setContentType("image/jpeg");
		User user = userService.getUserByUserId(id);
		byte[] buffer = user.getPhoto();
		InputStream in1 = new ByteArrayInputStream(buffer);
		IOUtils.copy(in1, response.getOutputStream());
	}
*/
	/**
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/checkUserNameAvailability")
	public @ResponseBody Boolean isUserNameAvailable(@RequestBody User user,
			HttpServletRequest request, HttpServletResponse response) {
		if (user != null && user.getUserName() != null) {
			user = userService.getUserByUserName(user.getUserName());
			if (user == null) {
				return true;
			} else {
				return false;
			}

		}
		return false;
	}
}
