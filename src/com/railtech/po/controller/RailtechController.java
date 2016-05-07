/**
 * 
 */
package com.railtech.po.controller;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.railtech.po.entity.Code;
import com.railtech.po.entity.Firm;
import com.railtech.po.entity.FlexiBean;
import com.railtech.po.entity.Item;
import com.railtech.po.entity.ItemStock;
import com.railtech.po.entity.ModelForm;
import com.railtech.po.entity.PL;
import com.railtech.po.entity.Rate;
import com.railtech.po.entity.Role;
import com.railtech.po.entity.Unit;
import com.railtech.po.entity.User;
import com.railtech.po.entity.Vendor;
import com.railtech.po.entity.VendorDetails;
import com.railtech.po.entity.Warehouse;
import com.railtech.po.service.MasterInfoService;
import com.railtech.po.service.RequisitionService;
import com.railtech.po.util.Util;

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
	
	private static Set<Code> codeList;
	
	@PostConstruct
	public void init(){
		//codeList = masterservice.getCodeList();
	}
	
	
	@RequestMapping(value = { "/" }, method = { RequestMethod.GET })
	public ModelAndView home(HttpServletRequest request)
	{
		User user  = request.getSession().getAttribute("_SessionUser")!=null?(User)request.getSession().getAttribute("_SessionUser"):null;
		
		if(user == null){
			String userId = request.getParameter("userId");
			user = masterservice.getUserById(userId,true);
			request.getSession().setAttribute("_SessionUser", user);
		}
				
		return new ModelAndView("requisitions");
		
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
	
	@RequestMapping(value = { "/getRates" }, method = { RequestMethod.POST })
	public @ResponseBody List<Rate> getRates()
	{
		List<Rate> rates = masterservice.getRates();
		return rates;
	}
	
	
	//@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/itemCodePicker" }, method = { RequestMethod.GET })
	public  ModelAndView itemCodePicker(HttpServletRequest request)
	{
		
		/*if(request.getSession().getAttribute("codeList")==null){
			codeList = masterservice.getCodeList();
			request.getSession().setAttribute("codeList",codeList);
		}else{
			codeList = (Set<Code>)request.getSession().getAttribute("codeList");
		}
		*/
		ModelAndView mv = new ModelAndView();
		mv.setViewName("itemCodePicker");
		mv.addObject("codeList", codeList);
		return mv;
	}
	
	//@RequestMapping(value = { "/getCodeList" }, method = { RequestMethod.POST })
	//public  @ResponseBody Set<Code> getCodeList()
	//{
		//Set<Code> codeList = masterservice.getCodeList();
		//return codeList;
	//}
	
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
		User user = masterservice.getUserById(modelRequest.getId(),false);
		//User user = masterservice.getUserById(modelRequest.getId());
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
	
	@RequestMapping(value = { "/getVendorAddress" }, method = { RequestMethod.POST })
	public  @ResponseBody Set<VendorDetails> getVendorAddress(@RequestBody ModelForm modelRequest)
	{
		Set<VendorDetails> vendorDetail  = masterservice.getAddresses(modelRequest.getId());
		return vendorDetail;
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
	
	@RequestMapping(value = { "/getUserRoleByRoleId" }, method = { RequestMethod.POST })
	public @ResponseBody Role getUserRoleByRoleId(@RequestBody ModelForm modelRequest)
	{
		Role role = masterservice.getUserRoleByRoleId(modelRequest.getId());
		return role;
	}
	
	
	@RequestMapping(value = { "/getVendors" }, method = { RequestMethod.POST })
	public @ResponseBody List<Vendor> getVendors()
	{
		List<Vendor> users = masterservice.getVendors();
		return users;
	}
	
	@RequestMapping(value = { "/getVendorById" }, method = { RequestMethod.POST })
	public @ResponseBody Vendor getVendorById(@RequestBody ModelForm modelRequest)
	{
		Vendor vendor = masterservice.getVendorById(modelRequest.getId());
		return vendor;
	}
	
	@RequestMapping(value = { "/getCodeList" }, method = { RequestMethod.POST })
	public void getCodeList(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		FlexiBean requestParams = new FlexiBean(request);
		logger.info("entering getCodeList");
		List<Code> codeList = masterservice.getCodeList(requestParams);

		List<String> codeRow = null;
		Map<String, List<String>> strMap = new LinkedHashMap<String, List<String>>();
		if (!CollectionUtils.isEmpty(codeList)) {
			int count = 0;
			for (Code code : codeList) {
				logger.info("writing codes to grid");				
				codeRow = new LinkedList<String>();
				codeRow.add("<a href=\"#\" onclick=\"push('"+code.getCodeId()+"','"+code.getCode()+"','"+code.getCodeDesc()+"')\" >"
						+ "<span class=\"glyphicon glyphicon-plus-sign\" ></span></a>");
				codeRow.add(""+code.getCodeId());
				codeRow.add(code.getCode());
				codeRow.add(code.getCodeDesc());
				codeRow.add(code.getNewItemCode());
				codeRow.add(code.getNewItemDesc());				
				strMap.put(String.valueOf(++count), codeRow);
			
			}
		}
		Util.doWriteFlexi(request, response, strMap, requestParams);
		logger.info("exiting getCodeList");

	}
	
}
