/**
 * 
 */
package com.railtech.po.controller;

import java.util.Date;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
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
import com.railtech.po.entity.FlexiBean;
import com.railtech.po.entity.Item;
import com.railtech.po.entity.ItemStock;
import com.railtech.po.entity.ModelForm;
import com.railtech.po.entity.PL;
import com.railtech.po.entity.Requisition;
import com.railtech.po.entity.RequisitionItem;
import com.railtech.po.entity.Unit;
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
	
	@RequestMapping(value = { "/requisitions" }, method = { RequestMethod.GET })
	public ModelAndView gotoRequisitions()
	{
		return new ModelAndView("requisitions");
	}
	
	@RequestMapping(value = { "/pendingStockIssue" }, method = { RequestMethod.GET })
	public ModelAndView pendingStockIssue()
	{
		return new ModelAndView("pendingStockIssue");
	}
	
	@RequestMapping(value = { "/getItems" }, method = { RequestMethod.POST })
	public  @ResponseBody Set<Item> getItems()
	{
		Set<Item> items = masterservice.getItems();
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
	
	@RequestMapping(value = { "/getItemStock" }, method = { RequestMethod.POST })
	public @ResponseBody ItemStock getItemStock(@RequestBody ModelForm requestForm)
	{
		ItemStock itemStock = requisitionService.getItemStock(requestForm.getId(), requestForm.getId2());
		return itemStock;
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
				requisitionRow.add("<input type='radio' name='requisitionId' value='"+requisition.getRequisitionId()+"'>");
				requisitionRow.add(String.valueOf(++count));
				requisitionRow.add(requisition.getRequisitionRefNo());
				StringBuilder itemDetails = new StringBuilder();
				for (RequisitionItem item : requisition.getRequisitionItems()) {
					itemDetails.append("<p>");
					itemDetails.append(item.getItemCode().getCode() + " <br/> "
							+ item.getItemCode().getCodeDesc() + " <br/>Qty:"
							+ item.getQty() + " "
							+ item.getUnit().getUnitName());
					itemDetails.append("</p>");
				}
				requisitionRow.add(itemDetails.toString());
				
				requisitionRow.add(Util.getDateString(requisition.getRequestedDate() ,"dd/MM/yyyy"));
				requisitionRow.add(requisition.getRequestedByUser().getUserName());
				requisitionRow.add(Util.getDateString(requisition.getDueDate() ,"dd/MM/yyyy"));
				requisitionRow.add(String.valueOf(requisition.getFullFillmentStatus()));
				
				
				strMap.put(String.valueOf(count), requisitionRow);
			}
		}
		Util.doWriteFlexi(request, response, strMap, params);
	}
	
	@RequestMapping(value = { "/getPendingStockIssue" }, method = { RequestMethod.POST })
	public void getPendingStockIssue(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		FlexiBean params = new FlexiBean(request);
		Set<Requisition> requisitions  = requisitionService.getRequisitions(params);
		List<String> requisitionItemRow = null;
		Map<String, List<String>> strMap = new LinkedHashMap<String, List<String>>();
		if(!CollectionUtils.isEmpty(requisitions)){
			int count = 0;
			for(Requisition requisition: requisitions){
				for (RequisitionItem item : requisition.getRequisitionItems()) {
					if (item.getFullFillmentStatus()==null || item.getFullFillmentStatus().equalsIgnoreCase("N")) {
						requisitionItemRow = new LinkedList<String>();
						requisitionItemRow
								.add("<input type='radio' name='requisitionItemId' value='"+item.getItemKey()+ "'>");
						requisitionItemRow.add(String.valueOf(++count));
						requisitionItemRow.add(requisition.getRequisitionRefNo());
					
						requisitionItemRow.add(item.getItemCode().getCodeDesc());
						requisitionItemRow.add(String.valueOf(item.getQty()));
						requisitionItemRow.add(Util.getDateString(
								requisition.getRequestedDate(), "dd/mm/yyyy"));
						requisitionItemRow.add(requisition.getRequestedByUser()
								.getUserName());
						requisitionItemRow.add(Util.getDateString(
								requisition.getDueDate(), "dd/mm/yyyy"));
						requisitionItemRow.add(String.valueOf(requisition
								.getFullFillmentStatus()));

						strMap.put(String.valueOf(count), requisitionItemRow);
					}
				}
				
			}
		}
		Util.doWriteFlexi(request, response, strMap, params);
	}
	
	
	@RequestMapping(value = { "/saveRequisition" }, method = { RequestMethod.POST })
	public void saveRequisition(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		Requisition requisition =null;
		String requisitionId = request.getParameter("requisitionId");
		String requisitionRefNo = request.getParameter("requisitionRefNo");
		if(!StringUtils.isEmpty(requisitionId)){
			requisition = requisitionService.getRequisitionById(Long.parseLong(requisitionId));
		}else{
			requisition  = new Requisition();
			
		}
		
		String firmId = request.getParameter("firm");
		Firm firm = masterservice.getFirmById(firmId);
		requisition.setRequestedForFirm(firm);
		requisition.setRequisitionRefNo(requisitionRefNo);
		
		String warehouseId = request.getParameter("warehouse");
		Warehouse warehouse = masterservice.getWareHouseById(warehouseId);
		requisition.setRequestedAtWareHouse(warehouse);

		//User requestedByUser =((User) request.getSession().getAttribute("_SessionUser"));
		User requestedByUser =masterservice.getUserById("27");
		requisition.setRequestedByUser(requestedByUser);
		
		//requisition.setQty(Float.valueOf(request.getParameter("qty")));
		requisition.setDueDate(Util.getDate(request.getParameter("dueDate"),"dd/MM/yyyy"));
		requisition.setRequestedDate(new Date());
		requisition.setFullFillmentStatus("N");
		
		String rowCount = request.getParameter("rowhid");
		int maxRows = 0;
		
		if(null!=rowCount){
			maxRows = Integer.parseInt(rowCount);
		}
		requisition.setRequisitionItems(new HashSet<RequisitionItem>());

		for (int i = 0; i < maxRows; i++) {
			String itemCodeId = request.getParameter("codeId" + i);

			if (itemCodeId != null) {
				Integer codeId = Integer.parseInt(itemCodeId.trim());

				Integer unitId = Integer.parseInt(request.getParameter("unit"+ i));
				Code itemCode = masterservice.getCodeById(codeId);
				Unit itemUnit = masterservice.getUnitById(unitId);
				RequisitionItem reqItem = new RequisitionItem();
				reqItem.setItemCode(itemCode);
				reqItem.setRequisition(requisition);
				reqItem.setPriority(Integer.parseInt(request
						.getParameter("priority" + i)));
				reqItem.setQty(Double.parseDouble(request.getParameter("qty"
						+ i)));
				reqItem.setUnit(itemUnit);
				reqItem.setModifiedByUser(requestedByUser);
				requisition.getRequisitionItems().add(reqItem);
			}
		}
		requisitionService.saveOrUpdate(requisition);

	}
	
	@RequestMapping(value = { "/deleteRequisition" }, method = { RequestMethod.POST })
	public  @ResponseBody String deleteRequisition(@RequestBody ModelForm modelRequest)
	{
		Requisition requisition  = requisitionService.getRequisitionById(Long.parseLong(modelRequest.getId()));
		requisitionService.delete(requisition);
		logger.debug("successfully deleted the requisition");
		return "Success";
	}
	
	@RequestMapping(value = { "/getRequisitionById" }, method = { RequestMethod.POST })
	public  @ResponseBody Requisition getRequisitionById(@RequestBody ModelForm modelRequest)
	{
		Requisition requisition  = requisitionService.getRequisitionById(Long.parseLong(modelRequest.getId()));
		return requisition;
	}
	
	@RequestMapping(value = { "/getRequisitionByRefNo" }, method = { RequestMethod.POST })
	public  @ResponseBody Requisition getRequisitionByRefNo(@RequestBody ModelForm modelRequest)
	{
		Requisition requisition  = requisitionService.getRequisitionByRefNo(modelRequest.getId());
		return requisition;
	}
	
	@RequestMapping(value = { "/generateRequisitionRefNo" }, method = { RequestMethod.POST })
	public  @ResponseBody String generateRequisitionRefNo(@RequestBody ModelForm modelRequest)
	{
		String  firmId = modelRequest.getId();
		String storeId = modelRequest.getId2();
		
		String reqRefNo = requisitionService.generateRequisitionRefNo(firmId, storeId);
		
		return reqRefNo;
		
	}
	
	
}
