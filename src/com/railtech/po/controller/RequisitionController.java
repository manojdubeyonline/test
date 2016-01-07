/**
 * 
 */
package com.railtech.po.controller;

import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
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
import com.railtech.po.entity.ItemIssue;
import com.railtech.po.entity.ItemStock;
import com.railtech.po.entity.ModelForm;
import com.railtech.po.entity.Requisition;
import com.railtech.po.entity.RequisitionItem;
import com.railtech.po.entity.Unit;
import com.railtech.po.entity.User;
import com.railtech.po.entity.Warehouse;
import com.railtech.po.service.MasterInfoService;
import com.railtech.po.service.RequisitionService;
import com.railtech.po.service.StockService;
import com.railtech.po.util.Util;

/**
 * @author MANOJ
 *
 */
@Controller
public class RequisitionController {
	private static Logger logger = Logger
			.getLogger(RequisitionController.class);
	
	@Autowired
	RequisitionService requisitionService;
	
	@Autowired
	StockService stockService;
	
	@Autowired
	MasterInfoService masterservice;
	
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
						requisitionItemRow.add(String.valueOf(item.getQty())+ "  "
								+ item.getUnit().getUnitName());
						requisitionItemRow.add(Util.getDateString(
								requisition.getRequestedDate(), "dd/MM/yyyy"));
						requisitionItemRow.add(requisition.getRequestedByUser()
								.getUserName());
						requisitionItemRow.add(Util.getDateString(
								requisition.getDueDate(), "dd/MM/yyyy"));
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
		Boolean isNew = Boolean.FALSE;
		if(!StringUtils.isEmpty(requisitionId)){
			requisition = requisitionService.getRequisitionById(Long.parseLong(requisitionId));
		}else{
			requisition  = new Requisition();
			isNew = Boolean.TRUE;
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
		
		if(isNew || requisition.getRequisitionItems() ==null){
			requisition.setRequisitionItems(new HashSet<RequisitionItem>());
		}
		for (int i = 0; i < maxRows; i++) {
			String itemCodeId = request.getParameter("codeId" + i);
			String itemKeyStr = request.getParameter("itemKey" + i);

			if (itemCodeId != null) {
				Integer codeId = Integer.parseInt(itemCodeId.trim());
				Integer itemKey = null!=itemKeyStr?Integer.parseInt(itemKeyStr.trim()):null;
				Integer unitId = Integer.parseInt(request.getParameter("unit"+ i).trim());
				Code itemCode = masterservice.getCodeById(codeId);
				Unit itemUnit = masterservice.getUnitById(unitId);
				
				
				Boolean isFound = Boolean.FALSE;
				RequisitionItem reqItem = null;
				if(!isNew){
					Iterator <RequisitionItem>itr = requisition.getRequisitionItems().iterator();
					while(itr.hasNext()){
						RequisitionItem itm = itr.next();
						if(itm.getItemKey() ==itemKey){
							isFound = Boolean.TRUE;
							reqItem =itm;
							break;
						}
					}
				}
				if(!isFound){
					reqItem = new RequisitionItem();
				}
				reqItem.setItemCode(itemCode);
				reqItem.setRequisition(requisition);
				reqItem.setPriority(Integer.parseInt(request
						.getParameter("priority" + i)));
				reqItem.setQty(Double.parseDouble(request.getParameter("qty"
						+ i).trim()));
				reqItem.setUnit(itemUnit);
				reqItem.setModifiedByUser(requestedByUser);
				reqItem.setCurrentStatus("R");
				if(!isFound){
					requisition.getRequisitionItems().add(reqItem);
				}
			}
		}
		requisitionService.saveOrUpdate(requisition);

	}
	
	
	@RequestMapping(value = { "/saveItemIssue" }, method = { RequestMethod.POST })
	public void saveItemIssue(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		Requisition requisition =null;
		String requisitionId = request.getParameter("requisitionId");
		String requisitionRefNo = request.getParameter("requisitionRefNo");
		if(!StringUtils.isEmpty(requisitionId)){
			requisition = requisitionService.getRequisitionById(Long.parseLong(requisitionId));
		}else{
			saveRequisition(request, response);
			requisition = requisitionService.getRequisitionByRefNo(requisitionRefNo);
		}
		
		requisitionService.saveItemIssue(requisition);

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
	
	@RequestMapping(value = { "/getItemStock" }, method = { RequestMethod.POST })
	public  @ResponseBody ItemStock getItemStock(@RequestBody ModelForm modelRequest)
	{
		String  itemCode = modelRequest.getId();
		String warehouseId = modelRequest.getId2();
		
		ItemStock itemStock = requisitionService.getItemStock(itemCode, warehouseId);
		
		return itemStock;
		
	}
	
	
	@RequestMapping(value = { "/getStockIssuedHistory" }, method = { RequestMethod.POST })
	public void getStockIssuedHistory(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
FlexiBean params = new FlexiBean(request);
		
		
Set<ItemIssue> itemIssues  = stockService.getItemIssue(params);
		List<String> requisitionItemRow = null;
		Map<String, List<String>> strMap = new LinkedHashMap<String, List<String>>();
		
		if(!CollectionUtils.isEmpty(itemIssues)){
			int count = 0;
			for(ItemIssue itemIssue: itemIssues){
				
				
					
						requisitionItemRow = new LinkedList<String>();
						Code item = itemIssue.getItemCode();
						Requisition requisition = itemIssue.getRequisition();
						
						
						requisitionItemRow
								.add("<input type='radio' name='requisitionItemId' value='"+itemIssue.getItemIssueId()+ "'>");
						requisitionItemRow.add(String.valueOf(++count));
						requisitionItemRow.add(requisition.getRequisitionRefNo());
						
						requisitionItemRow.add(item.getCodeDesc());
						requisitionItemRow.add(String.valueOf(itemIssue.getIssueQty()));
						//requisitionItemRow.add(String.valueOf(item.getQty())+ "  "
								//+ item.getUnit().getUnitName());
						requisitionItemRow.add(Util.getDateString(
								requisition.getRequestedDate(), "dd/MM/yyyy"));
						
						requisitionItemRow.add(itemIssue.getIssuedBy()
								.getUserName());
						requisitionItemRow.add(Util.getDateString(
								itemIssue.getIssueDate(), "dd/MM/yyyy"));
						
						

						strMap.put(String.valueOf(count), requisitionItemRow);
					}
					}
				
				
		
		
	Util.doWriteFlexi(request, response, strMap, params);
	}

}

