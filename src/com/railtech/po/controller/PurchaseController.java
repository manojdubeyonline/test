/**
 * 
 */
package com.railtech.po.controller;

import java.io.IOException;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

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
import com.railtech.po.entity.JobWork;
import com.railtech.po.entity.JobWorkItemMaster;
import com.railtech.po.entity.JobWorkItems;
import com.railtech.po.entity.ModelForm;
import com.railtech.po.entity.Procurement;
import com.railtech.po.entity.PurchaseOrder;
import com.railtech.po.entity.PurchaseOrderItem;
import com.railtech.po.entity.Rate;
import com.railtech.po.entity.RateApplied;
import com.railtech.po.entity.Requisition;
import com.railtech.po.entity.RequisitionItem;
import com.railtech.po.entity.Unit;
import com.railtech.po.entity.User;
import com.railtech.po.entity.Vendor;
import com.railtech.po.entity.Warehouse;
import com.railtech.po.service.MasterInfoService;
import com.railtech.po.service.ProcurementService;
import com.railtech.po.service.PurchaseService;
import com.railtech.po.service.RequisitionService;
import com.railtech.po.util.Util;

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
	PurchaseService purchaseService;
	
	@Autowired
	ProcurementService procurementService;
	
	@Autowired
	MasterInfoService masterservice;
	
	@RequestMapping(value = { "/purchaseOrder" }, method = { RequestMethod.GET })
	public ModelAndView gotoPurchaseOrder() {
		logger.info("moving to purchase order");
		return new ModelAndView("purchaseOrder");
	}
	@RequestMapping(value = { "/purchaseOrderApproval" }, method = { RequestMethod.GET })
	public ModelAndView gotoOrderApproval() {
		logger.info("moving to purchase order approval");
		return new ModelAndView("orderApproval");
	}
	
	@RequestMapping(value = { "/getPurchaseOrderById" }, method = { RequestMethod.POST })
	public @ResponseBody PurchaseOrder getPurchaseOrderById(@RequestBody ModelForm modelRequest)
	{
		PurchaseOrder order = purchaseService.getOrderById(Integer.parseInt(modelRequest.getId()));
		return order;
	}
	
	@RequestMapping(value = { "/getJobWorkOrderById" }, method = { RequestMethod.POST })
	public @ResponseBody JobWork getJobWorkOrderById(@RequestBody ModelForm modelRequest)
	{
		JobWork jobWork = purchaseService.getJobWorkById(Integer.parseInt(modelRequest.getId()));
		return jobWork;
	}
	
	@RequestMapping(value = { "/getItemByOrderId" }, method = { RequestMethod.POST })
	public @ResponseBody PurchaseOrder getItemByOrderId(@RequestBody ModelForm modelRequest)
	{
		PurchaseOrder order = purchaseService.getOrderById(Integer.parseInt(modelRequest.getId()));
		return order;
	}
	
	@RequestMapping(value = { "/generatePurchaseOrderNo" }, method = { RequestMethod.POST })
	public @ResponseBody String generatePurchaseOrderNo(@RequestBody ModelForm modelRequest)
	{
		String purchaseOrderNo = purchaseService.generatePurchaseOrderNo(modelRequest.getId());
		return purchaseOrderNo;
	}
	
	@RequestMapping(value = { "/generateJobWorkOrderNo" }, method = { RequestMethod.POST })
	public @ResponseBody String generateJobWorkOrderNo(@RequestBody ModelForm modelRequest)
	{
		String jobWorkOrderNo = purchaseService.generateJobWorkOrderNo(modelRequest.getId());
		return jobWorkOrderNo;
	}
	
	@RequestMapping(value = { "/deletePurchaseOrder" }, method = { RequestMethod.POST })
	public  @ResponseBody String deleteRequisition(@RequestBody ModelForm modelRequest)
	{
		PurchaseOrder order = purchaseService.getOrderById(Integer.parseInt(modelRequest.getId()));
		purchaseService.delete(order);
		logger.debug("successfully deleted the purchase order");
		return "Success";
	}
	
	@RequestMapping(value = { "/deleteJobWorkOrder" }, method = { RequestMethod.POST })
	public  @ResponseBody String deleteJobWorkOrder(@RequestBody ModelForm modelRequest)
	{
		JobWork jobWork = purchaseService.getJobWorkById(Integer.parseInt(modelRequest.getId()));
		purchaseService.deleteJob(jobWork);
		logger.debug("successfully deleted the job work order");
		return "Success";
	}
		
	@RequestMapping(value = { "/getPendingPurchaseOrderList" }, method = { RequestMethod.POST })
	public @ResponseBody User getPendingPurchaseOrderList(@RequestBody ModelForm modelRequest)
	{
		//User user = purchaseOrderService.getUserById(modelRequest.getId());
		return null;
	}
	
	
	@RequestMapping(value = { "/savePurchaseOrder" }, method = { RequestMethod.POST })
	public void savePurchaseOrder(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		PurchaseOrder purchase = null;
		String orderId = request.getParameter("orderId");
		Boolean isNew = Boolean.FALSE;
		if (!StringUtils.isEmpty(orderId)) {
			purchase = purchaseService.getOrderById(Integer
					.parseInt(orderId));
		} else {
			purchase = new PurchaseOrder();
			isNew = Boolean.TRUE;
		}
		
		
		String warehouseId = request.getParameter("warehouse");
		
		if(!StringUtils.isEmpty(warehouseId)){
			Warehouse warehouse = masterservice.getWareHouseById(warehouseId);
			purchase.setWarehouse(warehouse);
		}
			
		String firmId = request.getParameter("firm");
		if (StringUtils.isEmpty(firmId)) {
			firmId = request.getParameter("firm1");
		}
		
		Firm firm = masterservice.getFirmById(firmId);
		purchase.setFirm(firm);

		String vendorId = request.getParameter("vendor");
		if(vendorId!=null){
			Vendor vendor = masterservice.getVendorById(vendorId);
			purchase.setVendor(vendor);
		}
		
		purchase.setDateAdded(new Date());
		
		//purchase.setRate(Double.parseDouble(request.getParameter("rate")));
		
		purchase.setDueDate(Util.getDate(request.getParameter("purchaseOrderDate"),
			"dd/MM/yyyy"));
		purchase.setPurchaseOrderNo(request.getParameter("orderNo"));
		User addedByUser = masterservice.getUserById("27");
		purchase.setAddedBy(addedByUser);
		
		purchase.setOrderType(request.getParameter("orderType"));
		
		String rowCount = request.getParameter("rowhid");
		String innerRowCount = request.getParameter("rowId");
		
        int maxRows = 0;
        int innerMaxRows = 0;
       
		if(null!=rowCount && null!=innerRowCount){
			maxRows = Integer.parseInt(rowCount);
			innerMaxRows = Integer.parseInt(innerRowCount);
			
			
		}
		
		if(isNew || purchase.getOrderItems() ==null){
			purchase.setOrderItems(new HashSet<PurchaseOrderItem>());
		}
		for(int i=0;i<maxRows;i++)
		{
			/*
			for(int j=0;j<innerMaxRows;j++)
			{
				String rateValue = request.getParameter("rateValue"+i+j);
				if(rateValue == null) 
					continue;
				System.out.println("I : " + i+", J : "+j +" "+rateValue );
			}*/
			
			
			
			
			String itemKeyStr = request.getParameter("itemKey" + i);
			Integer itemKey = null!=itemKeyStr?Integer.parseInt(itemKeyStr.trim()):null;
			Boolean isFound = Boolean.FALSE;
			Boolean isApplied = Boolean.FALSE;
			PurchaseOrderItem purchaseItem = null;
			if(!isNew){
				Iterator <PurchaseOrderItem>itr = purchase.getOrderItems().iterator();
				while(itr.hasNext()){
					PurchaseOrderItem itm = itr.next();
					if(itm.getItemKey() ==itemKey){
						isFound = Boolean.TRUE;
						
						purchaseItem =itm;
						break;
					}
				}
			}
			if(!isFound){
				purchaseItem = new PurchaseOrderItem();
				isApplied = Boolean.TRUE;
			}
			
			String itemCodeId = request.getParameter("item"+i);
            Integer codeId = Integer.parseInt(itemCodeId.trim());
            Code itemCode = masterservice.getCodeById(codeId);
			purchaseItem.setItemCode(itemCode);
			
			String markingId = request.getParameter("marking_id"+i);
			
			if((!StringUtils.isEmpty(markingId))){
				Integer markId =  Integer.parseInt(markingId.trim());
				Procurement procurementMarking = procurementService.getProcurementById(markId);
				purchaseItem.setProcurementMarking(procurementMarking);
			}
			
           String requisitionId = request.getParameter("requisition_id"+i);
			
			if((!StringUtils.isEmpty(requisitionId))){
				Requisition requisition = requisitionService.getRequisitionById(Long.parseLong(requisitionId.trim()));
				purchaseItem.setRequisition(requisition);
			}
			
           String requisitionItemId = request.getParameter("requisitionItem_id"+i);
			
			if((!StringUtils.isEmpty(requisitionItemId))){
				RequisitionItem  requisitionItem = requisitionService.getRequisitionItemById(Long.parseLong(requisitionItemId.trim()));
				purchaseItem.setRequisitionItem(requisitionItem);
			} 
			
			purchaseItem.setPurchaseOrder(purchase);
			
			//User requestedByUser =((User)request.getSession().getAttribute("_SessionUser"));
			User requestedByUser = masterservice.getUserById("27");
			purchaseItem.setModifiedByUser(requestedByUser);
			
			purchaseItem.setQty(Double.parseDouble(request
					.getParameter("Order_Qty"+i)));
			String histQty = request
					.getParameter("qty"+i);
			if((!StringUtils.isEmpty(histQty))){
				purchaseItem.setHistQty(Double.parseDouble(histQty));
			}
			
			
			String basicRates = null;
			for(int j=0;j<innerMaxRows;j++)
			{
				String rateValue = request.getParameter("rateValue"+i+j);
				if(rateValue == null) 
					continue;
				else{
					Integer rateName = Integer.parseInt(request.getParameter("rateName"+i+j));
					if(rateName == 0){
						basicRates = request.getParameter("rateValue"+i+j);
					}
				}
				
			}
			
			//String basicRates = request.getParameter("subTotal" + i);
			purchaseItem.setBasicRate(Double.parseDouble(basicRates));
			Integer unitId = Integer.parseInt(request.getParameter("unit"+i));

			Unit itemUnit = masterservice.getUnitById(unitId);
			
			purchaseItem.setUnit(itemUnit);
			
			if(isNew || purchaseItem.getItemLevelRates() ==null){
				purchaseItem.setItemLevelRates(new HashSet<RateApplied>());
			}
			
			String rateAppliedId = request.getParameter("rateAppliedId" + i);
			Integer rateAppId = null!=rateAppliedId?Integer.parseInt(rateAppliedId.trim()):null;
			Boolean isAppliedFound = Boolean.FALSE;
			RateApplied rateApplied = null;
			if(!isApplied){
				Iterator <RateApplied>itr = purchaseItem.getItemLevelRates().iterator();
				while(itr.hasNext()){
					RateApplied rateApp = itr.next();
					if(rateApp.getRateAppliedId() ==rateAppId){
						isAppliedFound = Boolean.TRUE;
						rateApplied =rateApp;
						break;
			        }
				}
			}
			if(!isAppliedFound){
				rateApplied = new RateApplied();
				
			}
			
			
			String total = request.getParameter("total");
			rateApplied.setAppliedAmount(Double.parseDouble(total));			
			rateApplied.setMasterKeyId(purchase);
			rateApplied.setItemKeyId(purchaseItem);
			
			if(!isAppliedFound){
				purchaseItem.getItemLevelRates().add(rateApplied);
			}
			
			
			if(!isFound){
				purchase.getOrderItems().add(purchaseItem);
			}		
			
		}
		
		purchaseService.savePurchaseOrder(purchase);

	}
	
	
	@RequestMapping(value = { "/saveJobWorkOrder" }, method = { RequestMethod.POST })
	public void saveJobWorkOrder(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		JobWork jobWork = null;
		String jobWorkId = request.getParameter("jobWorkId");
		Boolean isNew = Boolean.FALSE;
		if (!StringUtils.isEmpty(jobWorkId)) {
			jobWork = purchaseService.getJobWorkOrderById(Integer
					.parseInt(jobWorkId));
		} else {
			jobWork = new JobWork();
			isNew = Boolean.TRUE;
		}
		
		
		String warehouseId = request.getParameter("warehouse");
		
		if(!StringUtils.isEmpty(warehouseId)){
			Warehouse warehouse = masterservice.getWareHouseById(warehouseId);
			//jobWork.setWarehouse(warehouse);
		}
			
		String firmId = request.getParameter("firm");
		if (StringUtils.isEmpty(firmId)) {
			firmId = request.getParameter("firm2");
		}
		
		Firm firm = masterservice.getFirmById(firmId);
		jobWork.setFirm(firm);

		String vendorId = request.getParameter("vendor5");
		if(vendorId!=null){
			Vendor vendor = masterservice.getVendorById(vendorId);
			jobWork.setVendor(vendor);
		}
		
		jobWork.setJobWorkDate(new Date());
		
		//purchase.setRate(Double.parseDouble(request.getParameter("rate")));
		
		jobWork.setQuotationDate(Util.getDate(request.getParameter("quotationDate"),
			"dd/MM/yyyy"));
		jobWork.setJobWorkOrderNo(request.getParameter("jobWorkNo"));
		User addedByUser = masterservice.getUserById("27");
		jobWork.setAddByUser(addedByUser);
		
		
		jobWork.setTotalAmount(Double.parseDouble(request.getParameter("jobWorkTotal")));
		jobWork.setRemarks(request.getParameter("jobRemarks"));
		jobWork.setQuotationNo(request.getParameter("quotationNo"));
		//purchase.setOrderType(request.getParameter("orderType"));
		
		String rowCount = request.getParameter("masterItemId");
		String innerRowCount = request.getParameter("itemRowId");
		
        int maxRows = 0;
        int innerMaxRows = 0;
       
		if(null!=rowCount && null!=innerRowCount){
			maxRows = Integer.parseInt(rowCount);
			innerMaxRows = Integer.parseInt(innerRowCount);
			
			
		}
		
		if(isNew || jobWork.getMasterItems() ==null){
			jobWork.setMasterItems(new HashSet<JobWorkItemMaster>());
		}
		for(int i=0;i<maxRows;i++)
		{
			/*
			for(int j=0;j<innerMaxRows;j++)
			{
				String rateValue = request.getParameter("rateValue"+i+j);
				if(rateValue == null) 
					continue;
				System.out.println("I : " + i+", J : "+j +" "+rateValue );
			}*/
			
			
			
			
			String itemMasterKeyStr = request.getParameter("itemMasterKey" + i);
			Integer itemMasterKey = null!=itemMasterKeyStr?Integer.parseInt(itemMasterKeyStr.trim()):null;
			Boolean isFound = Boolean.FALSE;
			Boolean isApplied = Boolean.FALSE;
			JobWorkItemMaster jobItemMaster = null;
			if(!isNew){
				Iterator <JobWorkItemMaster>itr = jobWork.getMasterItems().iterator();
				while(itr.hasNext()){
					JobWorkItemMaster itm = itr.next();
					if(itm.getItemMasterKey() ==itemMasterKey){
						isFound = Boolean.TRUE;
						
						jobItemMaster =itm;
						break;
					}
				}
			}
			if(!isFound){
				jobItemMaster = new JobWorkItemMaster();
				isApplied = Boolean.TRUE;
			}
			
			String itemCodeId = request.getParameter("item"+i);
            Integer codeId = Integer.parseInt(itemCodeId.trim());
            Code itemCode = masterservice.getCodeById(codeId);
            jobItemMaster.setItemCode(itemCode);
			
			String markingId = request.getParameter("marking_id"+i);
			
			if((!StringUtils.isEmpty(markingId))){
				Integer markId =  Integer.parseInt(markingId.trim());
				Procurement procurementMarking = procurementService.getProcurementById(markId);
				//purchaseItem.setProcurementMarking(procurementMarking);
			}
			
           String requisitionId = request.getParameter("requisition_id"+i);
			
			if((!StringUtils.isEmpty(requisitionId))){
				Requisition requisition = requisitionService.getRequisitionById(Long.parseLong(requisitionId.trim()));
				//purchaseItem.setRequisition(requisition);
			}
			
           String requisitionItemId = request.getParameter("requisitionItem_id"+i);
			
			if((!StringUtils.isEmpty(requisitionItemId))){
				RequisitionItem  requisitionItem = requisitionService.getRequisitionItemById(Long.parseLong(requisitionItemId.trim()));
				//purchaseItem.setRequisitionItem(requisitionItem);
			} 
			
			jobItemMaster.setJobWork(jobWork);
			
			//User requestedByUser =((User)request.getSession().getAttribute("_SessionUser"));
			User requestedByUser = masterservice.getUserById("27");
			//purchaseItem.setModifiedByUser(requestedByUser);
			
			jobItemMaster.setQty(Double.parseDouble(request
					.getParameter("Quantity"+i)));
			
			Integer unitId = Integer.parseInt(request.getParameter("unit"+i));

			Unit itemUnit = masterservice.getUnitById(unitId);
			
			jobItemMaster.setUnit(itemUnit);	
			
			
			
			String basicRates = null;
			
			
			//String basicRates = request.getParameter("subTotal" + i);
			//purchaseItem.setBasicRate(Double.parseDouble(basicRates));
			if(isNew || jobItemMaster.getJobWorkItem() ==null){
				jobItemMaster.setJobWorkItem(new HashSet<JobWorkItems>());
			}
			
			for(int j=0;j<innerMaxRows;j++)
			{
				String rateValue = request.getParameter("Rate"+i+j);
				if(rateValue == null) 
					continue;
				else{
			
			
			String jobItemKeyId = request.getParameter("rateAppliedId" + i);
			Integer jobItemKey = null!=jobItemKeyId?Integer.parseInt(jobItemKeyId.trim()):null;
			Boolean isAppliedFound = Boolean.FALSE;
			JobWorkItems jobWorkItem = null;
			if(!isApplied){
				Iterator <JobWorkItems>itr = jobItemMaster.getJobWorkItem().iterator();
				while(itr.hasNext()){
					JobWorkItems jobItem = itr.next();
					if(jobItem.getItemKeyId() ==jobItemKey){
						isAppliedFound = Boolean.TRUE;
						jobWorkItem =jobItem;
						break;
			        }
				}
			}
			if(!isAppliedFound){
				jobWorkItem = new JobWorkItems();
				
			}
			
			
					jobWorkItem.setBasicRate(Double.parseDouble(request.getParameter("Rate"+i+j)));	
					jobWorkItem.setUnit(itemUnit);
					jobWorkItem.setQty(Double.parseDouble(request
							.getParameter("qty"+i+j)));
					String itemId = request.getParameter("itemId"+i+j);
		            Integer codeItemId = Integer.parseInt(itemId.trim());
		            Code itemConverted = masterservice.getCodeById(codeItemId);
		            jobWorkItem.setItemCode(itemConverted);
		            jobWorkItem.setJobWork(jobWork);
		            jobWorkItem.setJobWorkItemMaster(jobItemMaster);
		            if(!isAppliedFound){
						jobItemMaster.getJobWorkItem().add(jobWorkItem);
					}  
		            
				}
				
			}
			
			
            
        	
			if(!isFound){
				jobWork.getMasterItems().add(jobItemMaster);
			}		
							
			
			
			
			
		
		}
		
		purchaseService.saveJobWorkOrder(jobWork);

	}
	
	
	@RequestMapping(value = { "/savePurchaseOrderApproval" }, method = { RequestMethod.POST })
	public void savePurchaseOrderApproval(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("entering savePurchaseOrderApproval");
		PurchaseOrder purchase = null;
		String orderId = request.getParameter("orderId");

		if (!StringUtils.isEmpty(orderId)) {
			purchase = purchaseService.getOrderById(Integer
					.parseInt(orderId));
		} else {
			throw new Exception("Invalid Request");
		}
		
	
		
		purchase.setApprovalComments(request.getParameter("approval_comments"));
		purchase.setApprovalStatus(request.getParameter("approvalStatus"));
		purchase.setApprovalDate(new Date());
		
		// User requestedByUser =((User)
				// request.getSession().getAttribute("_SessionUser"));
		User approvedByUser = masterservice.getUserById("27");
		purchase.setApprovedBy(approvedByUser);
		
		
		purchaseService.savePurchaseOrder(purchase);
		logger.info("exiting savePurchaseOrderApproval");
	}
	
	
	@RequestMapping(value = { "/getPurchaseOrderList" }, method = { RequestMethod.POST })
	public void getPurchaseOrderList(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		FlexiBean requestParams = new FlexiBean(request);
		logger.info("entering getPurchaseOrderList");
		List<PurchaseOrder> orders = purchaseService.getOrderList(requestParams);

		List<String> stockRow = null;
		Map<String, List<String>> strMap = new LinkedHashMap<String, List<String>>();
		if (!CollectionUtils.isEmpty(orders)) {
			int count = 0;
			for (PurchaseOrder order : orders) {
				 
				if(order.getApprovalStatus()!=null){
					continue;
				}
				
				stockRow = new LinkedList<String>();
				
			  // Code itemCode = purchaseItem.getItemCode();
				//PurchaseOrderItem purchaseItem= order.getOrderItems();
				//Code itemCode 
				Warehouse itemWareHouse = order.getWarehouse();

				stockRow.add("<input type='radio' name='order_id' value='"
						+ order.getOrderId()+ "'>");
				stockRow.add(String.valueOf(++count));
				stockRow.add(order.getPurchaseOrderNo());
				stockRow.add(order.getFirm().getFirmName());
				StringBuilder itemMarge = new StringBuilder();
				StringBuilder itemQty = new StringBuilder();
				for (PurchaseOrderItem purchaseItem : order.getOrderItems()){
					itemMarge.append("<p>");
					itemMarge.append( purchaseItem.getItemCode().getCodeDesc());
					itemMarge.append("</p>");
				
					itemQty.append("<p>");
					itemQty.append( "" + purchaseItem.getQty() + " "+purchaseItem.getUnit().getUnitName());
					itemQty.append("</p>");
				//stockRow.add(itemCode.getCodeDesc());
				//stockRow.add("" + purchaseItem.getQty() + " "+purchaseItem.getUnit().getUnitName());
				}
				stockRow.add(itemMarge.toString());
				stockRow.add(itemQty.toString());
				stockRow.add("" + Util.getDateString(order.getDueDate(), "dd/MM/yyyy"));
				stockRow.add("" + order.getOrderType());
				strMap.put(String.valueOf(count), stockRow);
			
			}
		}
		Util.doWriteFlexi(request, response, strMap, requestParams);
		logger.info("exiting getPurchaseOrderList");

	}
	
	
	@RequestMapping(value = { "/getJobWorkOrderList" }, method = { RequestMethod.POST })
	public void getJobWorkOrderList(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		FlexiBean requestParams = new FlexiBean(request);
		logger.info("entering getJobWorkOrderList");
		List<JobWork> jobWork = purchaseService.getJobWorkList(requestParams);

		List<String> stockRow = null;
		Map<String, List<String>> strMap = new LinkedHashMap<String, List<String>>();
		if (!CollectionUtils.isEmpty(jobWork)) {
			int count = 0;
			for (JobWork job : jobWork) {
				 
				
				
				stockRow = new LinkedList<String>();
				
			  // Code itemCode = purchaseItem.getItemCode();
				//PurchaseOrderItem purchaseItem= order.getOrderItems();
				//Code itemCode 
				//Warehouse itemWareHouse = order.getWarehouse();

				stockRow.add("<input type='radio' name='jobWork_id' value='"
						+ job.getJobWorkId()+ "'>");
				stockRow.add(String.valueOf(++count));
				stockRow.add(job.getJobWorkOrderNo());
				stockRow.add(job.getQuotationNo());
				stockRow.add(job.getFirm().getFirmName());
				StringBuilder itemMarge = new StringBuilder();
				StringBuilder itemQty = new StringBuilder();
				for (JobWorkItemMaster jobWorkItemMaster : job.getMasterItems()){
					itemMarge.append("<p>");
					itemMarge.append( jobWorkItemMaster.getItemCode().getCodeDesc());
					itemMarge.append("</p>");
				
					itemQty.append("<p>");
					itemQty.append( "" + jobWorkItemMaster.getQty() + " "+jobWorkItemMaster.getUnit().getUnitName());
					itemQty.append("</p>");
				//stockRow.add(itemCode.getCodeDesc());
				//stockRow.add("" + purchaseItem.getQty() + " "+purchaseItem.getUnit().getUnitName());
				}
				stockRow.add(itemMarge.toString());
				stockRow.add(itemQty.toString());
				stockRow.add("" + Util.getDateString(job.getJobWorkDate(), "dd/MM/yyyy"));
				//stockRow.add("" + order.getOrderType());
				strMap.put(String.valueOf(count), stockRow);
			
			}
		}
		Util.doWriteFlexi(request, response, strMap, requestParams);
		logger.info("exiting getJobWorkOrderList");

	}

	@RequestMapping(value = { "/getPurchaseOrderListApprovalCompleted" }, method = { RequestMethod.POST })
	public void getPurchaseOrderListApprovalCompleted(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		FlexiBean requestParams = new FlexiBean(request);
		logger.info("entering getPurchaseOrderListApprovalCompleted");
		List<PurchaseOrder> orders = purchaseService.getOrderList(requestParams);

		List<String> stockRow = null;
		Map<String, List<String>> strMap = new LinkedHashMap<String, List<String>>();
		if (!CollectionUtils.isEmpty(orders)) {
			int count = 0;
			for (PurchaseOrder order : orders) {
				//for (PurchaseOrderItem purchaseItem : order.getOrderItems()) {
				if(order.getApprovalStatus()==null){
					continue;
				}
				stockRow = new LinkedList<String>();
				 //Code itemCode = purchaseItem.getItemCode();
				Warehouse itemWareHouse = order.getWarehouse();

				stockRow.add("<input type='radio' name='order_id' value='"
						+ order.getOrderId()+ "'>");
				stockRow.add(String.valueOf(++count));
				stockRow.add(order.getPurchaseOrderNo());
				stockRow.add(order.getFirm().getFirmName());
				StringBuilder itemMarge = new StringBuilder();
				StringBuilder itemQty = new StringBuilder();
				for (PurchaseOrderItem purchaseItem : order.getOrderItems()){
					itemMarge.append("<p>");
					itemMarge.append( purchaseItem.getItemCode().getCodeDesc());
					itemMarge.append("</p>");
				
					itemQty.append("<p>");
					itemQty.append( "" + purchaseItem.getQty() + " "+purchaseItem.getUnit().getUnitName());
					itemQty.append("</p>");
				}
				stockRow.add(itemMarge.toString());
				stockRow.add(itemQty.toString());
				stockRow.add(Util.getDateString(order.getDueDate(), "dd/MM/yyyy"));
				stockRow.add(order.getOrderType());
				stockRow.add(order.getApprovalStatus().equalsIgnoreCase("Y")?"Approved":"Rejected");
				stockRow.add(Util.getDateString(order.getApprovalDate(), "dd/MM/yyyy"));
				
				
				strMap.put(String.valueOf(count), stockRow);
			
		  }      
		}
		Util.doWriteFlexi(request, response, strMap, requestParams);
		logger.info("exiting getPurchaseOrderListApprovalCompleted");

	}
	
	@RequestMapping(value = { "/getPurchaseOrder" }, method = { RequestMethod.POST })
	public void getPurchaseOrder(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		FlexiBean requestParams = new FlexiBean(request);
		logger.info("entering getPurchaseOrder");
		List<Procurement> procurementMarkings = procurementService.getProcurements(requestParams);
		List<PurchaseOrder> orders = purchaseService.getOrderList(requestParams);
		List<String> stockRow = null;
		Map<String, List<String>> strMap = new LinkedHashMap<String, List<String>>();
		if (!CollectionUtils.isEmpty(procurementMarkings)) {
			int count = 0;
			Double Qty = 0.0;
			double orderQty =  0;
			for (Procurement marking : procurementMarkings) {
				if(marking.getProcurementType().equalsIgnoreCase("Purchase Order"))
				{
					Qty = 0.0;
					
					for(PurchaseOrder purchaseOrder: orders){
						
						for(PurchaseOrderItem orderItem:purchaseOrder.getOrderItems()){
							if( orderItem.getProcurementMarking() != null){
					
							if(marking.getMarkingId() == orderItem.getProcurementMarking().getMarkingId())
								Qty = Qty + orderItem.getQty();
							}
						}
						 
						}
					orderQty = marking.getProcurementQty() - Qty;
					if(orderQty>0){
				stockRow = new LinkedList<String>();
				
				Code itemCode = marking.getRequisitionItemId().getItemCode();
				Warehouse itemWareHouse = marking.getWarehouse();

				stockRow.add("<input type='checkbox' name='marking_id' id='marking_id' value='"
						+ marking.getMarkingId()+ "' >");
				stockRow.add(String.valueOf(++count));
				stockRow.add(itemCode.getCodeDesc());
				stockRow.add(itemWareHouse.getWarehouseName());
				stockRow.add("" + orderQty + " "+marking.getUnit().getUnitName());
				stockRow.add("" + Util.getDateString(marking.getDueDate(), "dd/MM/yyyy"));
				stockRow.add("" + marking.getProcurementType());
				strMap.put(String.valueOf(count), stockRow);
					}
				}
			}
		}
		Util.doWriteFlexi(request, response, strMap, requestParams);
		logger.info("exiting getPurchaseOrder");

	}
	
	
	
	@RequestMapping(value = { "/getLocalPurchaseOrder" }, method = { RequestMethod.POST })
	public void getLocalPurchaseOrder(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		FlexiBean requestParams = new FlexiBean(request);
		logger.info("entering getLocalPurchaseOrder");
		List<Procurement> procurementMarkings = procurementService.getProcurements(requestParams);

		List<String> stockRow = null;
		Map<String, List<String>> strMap = new LinkedHashMap<String, List<String>>();
		if (!CollectionUtils.isEmpty(procurementMarkings)) {
			int count = 0;
			for (Procurement marking : procurementMarkings) {
				if(marking.getProcurementType().equalsIgnoreCase("Local Purchase"))
				{
				stockRow = new LinkedList<String>();
				
				Code itemCode = marking.getRequisitionItemId().getItemCode();
				Warehouse itemWareHouse = marking.getWarehouse();

				stockRow.add("<input type='checkbox' name='marking_id' id='marking_id' value='"
						+ marking.getMarkingId()+ "'>");
				stockRow.add(String.valueOf(++count));
				stockRow.add(itemCode.getCodeDesc());
				stockRow.add(itemWareHouse.getWarehouseName());
				stockRow.add("" + marking.getProcurementQty() + " "+marking.getUnit().getUnitName());
				stockRow.add("" + Util.getDateString(marking.getDueDate(), "dd/MM/yyyy"));
				stockRow.add("" + marking.getProcurementType());
				strMap.put(String.valueOf(count), stockRow);
				}
			}
		}
		Util.doWriteFlexi(request, response, strMap, requestParams);
		logger.info("exiting getLocalPurchaseOrder");

	}
	
	@RequestMapping(value = { "/getWarehouseBorrow" }, method = { RequestMethod.POST })
	public void getWarehouseBorrow(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		FlexiBean requestParams = new FlexiBean(request);
		logger.info("entering getLocalPurchaseOrder");
		List<Procurement> procurementMarkings = procurementService.getProcurements(requestParams);

		List<String> stockRow = null;
		Map<String, List<String>> strMap = new LinkedHashMap<String, List<String>>();
		if (!CollectionUtils.isEmpty(procurementMarkings)) {
			int count = 0;
			for (Procurement marking : procurementMarkings) {
				if(marking.getProcurementType().equalsIgnoreCase("Warehouse Borrowing"))
				{
				stockRow = new LinkedList<String>();
				
				//Code itemCode = marking.getItemCode();
				Warehouse itemWareHouse = marking.getWarehouse();

				stockRow.add("<input type='radio' name='marking_id' value='"
						+ marking.getMarkingId()+ "'>");
				stockRow.add(String.valueOf(++count));
				//stockRow.add(itemCode.getCodeDesc());
				stockRow.add(itemWareHouse.getWarehouseName());
				stockRow.add("" + marking.getProcurementQty() + " "+marking.getUnit().getUnitName());
				stockRow.add("" + Util.getDateString(marking.getDueDate(), "dd/MM/yyyy"));
				stockRow.add("" + marking.getProcurementType());
				strMap.put(String.valueOf(count), stockRow);
				}
			}
		}
		Util.doWriteFlexi(request, response, strMap, requestParams);
		logger.info("exiting getLocalPurchaseOrder");

	}

}
