/**
 * 
 */
package com.railtech.po.controller;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.railtech.po.entity.ModelForm;
import com.railtech.po.entity.User;
import com.railtech.po.service.MasterInfoService;
import com.railtech.po.service.RequisitionService;

/**
 * @author MANOJ
 *
 */
@Controller
public class PurchaseController {
	private static Logger logger = Logger
			.getLogger(PurchaseController.class);
	
	@Autowired
	RequisitionService requisitionService;
	
	@Autowired
	MasterInfoService masterservice;
	
	@RequestMapping(value = { "/purchaseOrder" }, method = { RequestMethod.GET })
	public ModelAndView gotoPurchaseOrder() {
		logger.info("moving to purchase order");
		return new ModelAndView("purchaseOrder");
	}
	
	@RequestMapping(value = { "/getPurchaseOrderById" }, method = { RequestMethod.POST })
	public @ResponseBody User getPurchaseOrderById(@RequestBody ModelForm modelRequest)
	{
		//User user = purchaseOrderService.getUserById(modelRequest.getId());
		return null;
	}
	
	@RequestMapping(value = { "/getPurchaseOrderList" }, method = { RequestMethod.POST })
	public @ResponseBody User getPurchaseOrderList(@RequestBody ModelForm modelRequest)
	{
		//User user = purchaseOrderService.getUserById(modelRequest.getId());
		return null;
	}
	
	@RequestMapping(value = { "/getPendingPurchaseOrderList" }, method = { RequestMethod.POST })
	public @ResponseBody User getPendingPurchaseOrderList(@RequestBody ModelForm modelRequest)
	{
		//User user = purchaseOrderService.getUserById(modelRequest.getId());
		return null;
	}
	
}
