/**
 * 
 */
package com.railtech.po.controller;

import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.railtech.po.entity.Code;
import com.railtech.po.entity.Firm;
import com.railtech.po.entity.Item;
import com.railtech.po.entity.ItemStock;
import com.railtech.po.entity.ModelForm;
import com.railtech.po.entity.PL;
import com.railtech.po.entity.Unit;
import com.railtech.po.entity.User;
import com.railtech.po.entity.Vendor;
import com.railtech.po.entity.Warehouse;
import com.railtech.po.service.MasterInfoService;
import com.railtech.po.service.RequisitionService;

/**
 * @author MANOJ
 *
 */
@Controller
public class RailtechController {
	private static Logger logger = Logger
			.getLogger(RailtechController.class);
	
	@Autowired
	RequisitionService requisitionService;
	
	@Autowired
	MasterInfoService masterservice;
	
	@RequestMapping(value = { "/" }, method = { RequestMethod.GET })
	public ModelAndView home(HttpServletRequest request)
	{
		User user = masterservice.getUserById("27");
		request.getSession().setAttribute("_SessionUser", user);
		return new ModelAndView("home");
		
	}
	
	@RequestMapping(value = { "/getItems" }, method = { RequestMethod.POST })
	public  @ResponseBody Set<Item> getItems()
	{
		logger.info("entering getItems");
		Set<Item> items = masterservice.getItems();
		logger.info("exiting getItems");
		return items;
	}
	
	@RequestMapping(value = { "/getUnits" }, method = { RequestMethod.POST })
	public  @ResponseBody Set<Unit> getUnits()
	{
		Set<Unit> units = masterservice.getUnits();
		return units;
	}
	
	@RequestMapping(value = { "/getPLList" }, method = { RequestMethod.POST })
	public  @ResponseBody Set<PL> getPLList()
	{
		Set<PL> plList = masterservice.getPLList();
		return plList;
	}
	
	@RequestMapping(value = { "/plPicker" }, method = { RequestMethod.GET })
	public ModelAndView plPicker()
	{
		Set<PL> plList = masterservice.getPLList();
		ModelAndView mv = new ModelAndView();
		mv.setViewName("plPicker");
		mv.addObject("plList", plList);
		return mv;
	}
	
	@RequestMapping(value = { "/itemCodePicker" }, method = { RequestMethod.GET })
	public  ModelAndView itemCodePicker()
	{
		Set<Code> codeList = masterservice.getCodeList();
		ModelAndView mv = new ModelAndView();
		mv.setViewName("itemCodePicker");
		mv.addObject("codeList", codeList);
		return mv;
	}
	
	@RequestMapping(value = { "/getCodeList" }, method = { RequestMethod.POST })
	public  @ResponseBody Set<Code> getCodeList()
	{
		Set<Code> codeList = masterservice.getCodeList();
		return codeList;
	}
	
	@RequestMapping(value = { "/getStock" }, method = { RequestMethod.POST })
	public @ResponseBody ItemStock getStock(@RequestBody ModelForm modelRequest)
	{
		ItemStock stock = requisitionService.getItemStock(modelRequest.getId(), modelRequest.getId2());
		return stock;
	}
	
	@RequestMapping(value = { "/getFirms" }, method = { RequestMethod.POST })
	public  @ResponseBody Set<Firm> getFirms()
	{
		Set<Firm>firms =masterservice.getFirms(); 
		return firms;
	}
	
	@RequestMapping(value = { "/getUserFirms" }, method = { RequestMethod.POST })
	public  @ResponseBody Set<Firm> getUserFirms(@RequestBody ModelForm modelRequest)
	{
		User user = masterservice.getUserById(modelRequest.getId());
		Set<Firm>firms =user.getUserFirms();
		return firms;
	}
	
	@RequestMapping(value = { "/getFirmById" }, method = { RequestMethod.POST })
	public  @ResponseBody Firm getFirmById(@RequestBody ModelForm modelRequest)
	{
		Firm firm =masterservice.getFirmById(modelRequest.getId()); 
		return firm;
	}
	
	@RequestMapping(value = { "/getWarehouses" }, method = { RequestMethod.POST })
	public  @ResponseBody Set<Warehouse> getWarehouses()
	{
		Set<Warehouse> warehouses  = masterservice.getWareHouses();
		return warehouses;
	}
	
	@RequestMapping(value = { "/getFirmWarehouses" }, method = { RequestMethod.POST })
	public  @ResponseBody Set<Warehouse> getFirmWarehouses(@RequestBody ModelForm modelRequest)
	{
		Set<Warehouse> warehouses  = masterservice.getWareHouses(modelRequest.getId());
		return warehouses;
	}
	
	@RequestMapping(value = { "/getUsers" }, method = { RequestMethod.POST })
	public @ResponseBody Set<User> getUsers()
	{
		Set<User> users = masterservice.getUsers();
		return users;
	}
	
	@RequestMapping(value = { "/getUserById" }, method = { RequestMethod.POST })
	public @ResponseBody User getUserById(@RequestBody ModelForm modelRequest)
	{
		User user = masterservice.getUserById(modelRequest.getId());
		return user;
	}
	
	@RequestMapping(value = { "/getVendors" }, method = { RequestMethod.POST })
	public @ResponseBody Set<Vendor> getVendors()
	{
		Set<Vendor> users = masterservice.getVendors();
		return users;
	}
	
	@RequestMapping(value = { "/getVendorById" }, method = { RequestMethod.POST })
	public @ResponseBody Vendor getVendorById(@RequestBody ModelForm modelRequest)
	{
		Vendor vendor = masterservice.getVendorById(modelRequest.getId());
		return vendor;
	}
	
}
