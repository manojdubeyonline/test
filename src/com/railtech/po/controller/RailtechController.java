/**
 * 
 */
package com.railtech.po.controller;

import java.util.Date;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.railtech.po.entity.Firm;
import com.railtech.po.entity.FlexiBean;
import com.railtech.po.entity.Item;
import com.railtech.po.entity.ModelForm;
import com.railtech.po.entity.Requisition;
import com.railtech.po.entity.User;
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
	
	@RequestMapping(value = { "/requisitions" }, method = { RequestMethod.GET })
	public ModelAndView gotoRequisitions()
	{
		return new ModelAndView("requisitions");
	}
	
	@RequestMapping(value = { "/getItems" }, method = { RequestMethod.POST })
	public  @ResponseBody Set<Item> getItems()
	{
		Set<Item> items = masterservice.getItems();
		return items;
	}
	
	@RequestMapping(value = { "/getFirms" }, method = { RequestMethod.POST })
	public  @ResponseBody Set<Firm> getFirms()
	{
		Set<Firm>firms =masterservice.getFirms(); 
		return firms;
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
	
	@RequestMapping(value = { "/getRequisitions" }, method = { RequestMethod.POST })
	public void getRequisitionList(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		FlexiBean params = new FlexiBean(request);
		Set<Requisition> requisitions  = requisitionService.getRequisitions(params);
		List<String> requisitionRow = null;
		Map<String, List<String>> strMap = new LinkedHashMap<String, List<String>>();
		if(!CollectionUtils.isEmpty(requisitions)){
			int count = 0;
			for(Requisition requisition: requisitions){
				requisitionRow =  new LinkedList<String>();
				requisitionRow.add(String.valueOf(++count));
				requisitionRow.add(requisition.getRequisitionId());
				requisitionRow.add(requisition.getItem().getItemDesc());
				requisitionRow.add(Util.getDateString(requisition.getRequestedDate() ,"dd/mm/yyyy"));
				requisitionRow.add(requisition.getRequestedByUser().getUserName());
				requisitionRow.add(Util.getDateString(requisition.getDueDate() ,"dd/mm/yyyy"));
				requisitionRow.add(String.valueOf(requisition.getQty()));
				requisitionRow.add(Util.replaceNull(requisition.getApprovalStatus(),"Pending Approval"));
				User approvedBy = requisition.getApprovedByUser();
				if(approvedBy!=null){
					requisitionRow.add(approvedBy.getUserName());
				}else{
					requisitionRow.add("NA");
				}
			
				strMap.put(String.valueOf(count), requisitionRow);
			}
		}
		Util.doWriteFlexi(request, response, strMap, params);
	}
	
	@RequestMapping(value = { "/saveRequisition" }, method = { RequestMethod.POST })
	public void saveRequisition(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		Requisition requisition =null;
		String requisitionId = request.getParameter("requisitionId");
		if(!StringUtils.isEmpty(requisitionId)){
			requisition = requisitionService.getRequisitionById(Long.getLong(requisitionId));
		}else{
			requisition  = new Requisition();
			
		}
		
		String itemId = request.getParameter("item");
		Item item = masterservice.getItemById(itemId);
		requisition.setItem(item);
		

		String firmId = request.getParameter("firm");
		Firm firm = masterservice.getFirmById(firmId);
		requisition.setRequestedForFirm(firm);
		
		String warehouseId = request.getParameter("warehouse");
		Warehouse warehouse = masterservice.getWareHouseById(warehouseId);
		requisition.setRequestedAtWareHouse(warehouse);

		//User requestedByUser =((User) request.getSession().getAttribute("_SessionUser"));
		User requestedByUser =masterservice.getUserById("27");
		requisition.setRequestedByUser(requestedByUser);
		
		requisition.setQty(Float.valueOf(request.getParameter("qty")));
		requisition.setDueDate(Util.getDate(request.getParameter("dueDate"),"mm/dd/yyyy"));
		requisition.setRequestedDate(new Date());
		
		requisitionService.saveOrUpdate(requisition);
	}
	
	@RequestMapping(value = { "/getRequisitionById" }, method = { RequestMethod.POST })
	public  @ResponseBody Requisition getRequisitionById(@RequestBody ModelForm modelRequest)
	{
		Requisition requisition  = requisitionService.getRequisitionById(Long.parseLong(modelRequest.getId()));
		return requisition;
	}
	
}
