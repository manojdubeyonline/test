/**
 * 
 */
package com.railtech.po.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * @author MANOJ
 *
 */
@Controller
public class RailtechController {
	@RequestMapping(value = { "/" }, method = { RequestMethod.GET })
	public ModelAndView home()
	{
		return new ModelAndView("home");
	}
}
