/**
 * 
 */
package com.railtech.po.controller;

import java.util.Date;
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
import com.railtech.po.entity.Procurement;
import com.railtech.po.entity.Requisition;
import com.railtech.po.entity.RequisitionItem;
import com.railtech.po.entity.Unit;
import com.railtech.po.entity.User;
import com.railtech.po.entity.Warehouse;
import com.railtech.po.exeception.RailtechException;
import com.railtech.po.service.MasterInfoService;
import com.railtech.po.service.ProcurementService;
import com.railtech.po.service.RequisitionService;
import com.railtech.po.service.StockService;
import com.railtech.po.util.POConstants;
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
	ProcurementService procurementService;
	
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
	
	@RequestMapping(value = { "/generateIssueRefNo" }, method = { RequestMethod.POST })
	public  @ResponseBody String generateIssueRefNo(@RequestBody ModelForm modelRequest)
	{
		String  firmId = modelRequest.getId();
		String warehouseId = modelRequest.getId2();
		
		String issueRefNo = requisitionService.generateIssueRefNo(firmId, warehouseId);
		
		return issueRefNo;
		
	}
	 
		
	@RequestMapping(value = { "/getRequisitions" }, method = { RequestMethod.POST })
	public void getRequisitionList(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		FlexiBean params = new FlexiBean(request);
		List<Requisition> requisitions  = requisitionService.getRequisitions(params);
		User currentUser =((User) request.getSession().getAttribute("_SessionUser"));
		List<String> requisitionRow = null;
		Map<String, List<String>> strMap = new LinkedHashMap<String, List<String>>();
		if(!CollectionUtils.isEmpty(requisitions)){
			int count = 0;
			for(Requisition requisition: requisitions){
				//if(!currentUser.getUserWarehouses().contains(requisition.getRequestedAtWareHouse())){
				//	continue;
				//}
				//if(!currentUser.getUserWarehouses().contains(requisition.getRequestedAtWareHouse())){
					//continue;
				for(Warehouse warehouse:currentUser.getUserWarehouses()){
					if(warehouse.getWareId().intValue() == requisition.getRequestedAtWareHouse().getWareId().intValue()){
						
					
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
				}
			}
		//}
		Util.doWriteFlexi(request, response, strMap, params);
	}
	
	@RequestMapping(value = { "/getPendingStockIssue" }, method = { RequestMethod.POST })
	public void getPendingStockIssue(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		FlexiBean params = new FlexiBean(request);
		List<Requisition> requisitions  = requisitionService.getRequisitions(params);
		Set<ItemIssue> itemIssues  = stockService.getItemIssue(params);
		List<Procurement> procurementMarkings = procurementService.getProcurements(params);
		List<String> requisitionItemRow = null;
		Map<String, List<String>> strMap = new LinkedHashMap<String, List<String>>();
		if(!CollectionUtils.isEmpty(requisitions)){
			int count = 0;
			double issueQty =  0;
			double procQty =  0;
			double qty =  0;
			for(Requisition requisition: requisitions){
				for (RequisitionItem item : requisition.getRequisitionItems()) {
					//if (item.getFullFillmentStatus()==null || item.getFullFillmentStatus().equalsIgnoreCase("N")) {
					ItemStock its = requisitionService.getItemStock(item.getItemCode().getCodeId()+"", ""+requisition.getRequestedAtWareHouse().getWareId());
					if(its == null){
						continue;
					}
					Double availQty = its.getAvailableQty();
					
					procQty = 0;
					for(Procurement procurement: procurementMarkings){
						
						if(item.getItemKey() == procurement.getRequisitionItemId().getItemKey() && requisition.getRequisitionId() == procurement.getReqId().getRequisitionId())
						procQty = procQty + procurement.getProcurementQty();
						
					}
					issueQty = 0;
					for(ItemIssue itemIssue: itemIssues){
						
						if(item.getItemKey() == itemIssue.getRequisitionItem().getItemKey() && requisition.getRequisitionId() == itemIssue.getRequisition().getRequisitionId())
						//for(ItemIssue itmIssue:itemIssues){
							issueQty = issueQty + itemIssue.getIssueQty();
						//}
					}
					qty = item.getQty()-(procQty + issueQty);
					if(availQty>0 && issueQty == 0){
						qty = item.getQty();
					}
					if (qty>0 && availQty>0) {
						requisitionItemRow = new LinkedList<String>();
						requisitionItemRow
								.add("<input type='radio' name='requisitionItemId' value='"+item.getItemKey()+ "'>");
						requisitionItemRow.add(String.valueOf(++count));
						requisitionItemRow.add(requisition.getRequisitionRefNo());
					
						requisitionItemRow.add(item.getItemCode().getCodeDesc());
						requisitionItemRow.add(String.valueOf(availQty)+ "  "
								+ item.getUnit().getUnitName());
						requisitionItemRow.add(String.valueOf(qty)+ "  "
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
		
		requisition.setRemarks(request.getParameter("remaks"));
		
		String warehouseId = request.getParameter("warehouse");
		Warehouse warehouse = masterservice.getWareHouseById(warehouseId);
		requisition.setRequestedAtWareHouse(warehouse);

		User requestedByUser =((User) request.getSession().getAttribute("_SessionUser"));
		//User requestedByUser =masterservice.getUserById("27");
		requisition.setRequestedByUser(requestedByUser);
		
		//requisition.setQty(Float.valueOf(request.getParameter("qty")));
		requisition.setDueDate(Util.getDate(request.getParameter("dueDate"),"dd/MM/yyyy"));
		requisition.setRequestedDate(new Date());
		requisition.setFullFillmentStatus("N");
		requisition.setCurrentStatus(POConstants.STATUS_REQUSITIONED);
		
		
		
		
		String rowCount = request.getParameter("rowhid");
		int maxRows = 0;
		
		if(null!=rowCount){
			maxRows = Integer.parseInt(rowCount);
		}
		
		if(isNew || requisition.getRequisitionItems() ==null){
			requisition.setRequisitionItems(new LinkedList<RequisitionItem>());
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
				reqItem.setHistQty(Double.parseDouble(request.getParameter("qty"
						+ i).trim()));
				reqItem.setUnit(itemUnit);
				reqItem.setModifiedByUser(requestedByUser);
				reqItem.setCurrentStatus("R");
				if(!isFound){
					requisition.getRequisitionItems().add(reqItem);
				}
			}
		}
		requisitionService.saveOrUpdate(requisition,true);

	}
	
	/*
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
	*/
	
	@RequestMapping(value = { "/saveItemIssue" }, method = { RequestMethod.POST })
	public void saveItemIssue(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		Requisition requisition =null;
		Integer requisitionItemId = null;
		String requisitionId = request.getParameter("requisitionId");
		String requisitionRefNo = request.getParameter("requisitionRefNo");
		String requisitionItem = request.getParameter("reqItemId");
		if(requisitionItem != null && requisitionItem != ""){
			 requisitionItemId = Integer.parseInt(requisitionItem.trim());
		}
		
		if(!StringUtils.isEmpty(requisitionId)){
			requisition = requisitionService.getRequisitionById(Long.parseLong(requisitionId));
		}else{
			saveRequisition(request, response);
			requisition = requisitionService.getRequisitionByRefNo(requisitionRefNo);
		}
		
		//requisitionService.saveItemIssue(requisition);
		
		String rowCount = request.getParameter("rowhid");
		int maxRows = 0;
		
		if(null!=rowCount){
			maxRows = Integer.parseInt(rowCount);
		}
		String qtyStr = null;
		for (int i = 0; i < maxRows; i++) {
			qtyStr = request.getParameter("qty"
					+ i);
			}
		Double qty = Double.parseDouble(qtyStr.trim());
		Warehouse warehouse = requisition.getRequestedAtWareHouse();
		User user = requisition.getRequestedByUser();
		for(RequisitionItem item : requisition.getRequisitionItems()){
			if(requisitionItemId != item.getItemKey() && !StringUtils.isEmpty(requisitionId)){
				continue;
			}
			ItemStock its = requisitionService.getItemStock(item.getItemCode().getCodeId()+"", ""+warehouse.getWareId());
			Double availableQty = its.getAvailableQty();
			if(availableQty<item.getQty()){
				throw new RailtechException("The available qty is less than the issue qty");
			}
			its.setAvailableQty(availableQty - qty);
			its.setRequisitionedQty(its.getRequisitionedQty()-qty);
			requisitionService.updateItemStock(its);
			ItemIssue itemIssue = new ItemIssue();
			itemIssue.setRequisition(requisition);
			itemIssue.setRequisitionItem(item);
			itemIssue.setItemCode(item.getItemCode());
			itemIssue.setIssuedBy(requisition.getRequestedByUser());
			itemIssue.setIssueDate(requisition.getRequestedDate());
			itemIssue.setIssueQty(qty);
			requisitionService.saveItemIssued(itemIssue);
			item.setFullFilledByUser(user);
			item.setFullFillmentStatus("Y");
			//item.setCurrentStatus("S");
			requisition.setCurrentStatus(item.getQty() == qty?POConstants.STATUS_FULL_ISSUED:POConstants.STATUS_PART_ISSUED);
			requisitionService.saveOrUpdate(requisition,true);
		}

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
	
	@RequestMapping(value = { "/getRequisitionByRefNoForStockIssue" }, method = { RequestMethod.POST })
	public  @ResponseBody Requisition getRequisitionByRefNoForStockIssue(@RequestBody ModelForm modelRequest)
	{
		Requisition requisition  = requisitionService.getRequisitionByRefNo(modelRequest.getId());
		if(requisition !=null){
			for(RequisitionItem item:requisition.getRequisitionItems()){
				Double markedQty = 0.0;
				Double issueQty = 0.0;
				//if(item.getCurrentStatus().equals(POConstants.STATUS_MARKED)){
				List<Procurement> procurement= procurementService.getProcureQtyByReqItemId(item.getItemKey());
				for(Procurement procure: procurement){
					markedQty = markedQty + procure.getProcurementQty(); 
				 }
					//item.setQty(item.getQty()-markedQty);
				//}
				//if(item.getCurrentStatus().equals(POConstants.STATUS_PART_ISSUED)){
					 List<ItemIssue> itemIssues = stockService.getIssuedQtyByReqItemId(item.getItemKey());
					 for(ItemIssue itemIssue: itemIssues){
						 issueQty = issueQty + itemIssue.getIssueQty(); 
					 }
					 
				//}
				item.setQty(item.getHistQty()-(markedQty+issueQty));
			}
		}
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

