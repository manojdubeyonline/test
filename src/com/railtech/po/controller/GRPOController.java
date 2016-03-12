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
import com.railtech.po.entity.FlexiBean;
import com.railtech.po.entity.GRPO;
import com.railtech.po.entity.GRPOReceiptEntry;
import com.railtech.po.entity.ModelForm;
import com.railtech.po.entity.Procurement;
import com.railtech.po.entity.PurchaseOrder;
import com.railtech.po.entity.PurchaseOrderItem;
import com.railtech.po.entity.Unit;
import com.railtech.po.entity.User;
import com.railtech.po.entity.Warehouse;
import com.railtech.po.service.GRPOService;
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
public class GRPOController {
	private static Logger logger = Logger
			.getLogger(GRPOController.class);
	
	@Autowired
	RequisitionService requisitionService;
	
	@Autowired
	GRPOService grpoService;
	
	@Autowired
	ProcurementService procurementService;
	
	@Autowired
	PurchaseService purchaseService;
	
	@Autowired
	MasterInfoService masterservice;
	
	@RequestMapping(value = { "/grpo" }, method = { RequestMethod.GET })
	public ModelAndView gotoGRPO() {
		logger.info("moving to grpo");
		return new ModelAndView("grpo");
	}
	@RequestMapping(value = { "/grpoApproval" }, method = { RequestMethod.GET })
	public ModelAndView gotoGRPOApproval() {
		logger.info("moving to gotoGRPOApproval");
		return new ModelAndView("grpoApproval");
	}
	
	@RequestMapping(value = { "/getGRPOById" }, method = { RequestMethod.POST })
	public @ResponseBody GRPO getGRPOById(@RequestBody ModelForm modelRequest)
	{
		GRPO grpo = grpoService.getGRPOById(Integer.parseInt(modelRequest.getId()));
		return grpo;
	}
	
	@RequestMapping(value = { "/deleteGRPO" }, method = { RequestMethod.POST })
	public  @ResponseBody String deleteRequisition(@RequestBody ModelForm modelRequest)
	{
		GRPO grpo = grpoService.getGRPOById(Integer.parseInt(modelRequest.getId()));
		grpoService.delete(grpo);
		logger.debug("successfully deleted the GRPO");
		return "Success";
	}
			
	@RequestMapping(value = { "/getPendingGRPOList" }, method = { RequestMethod.POST })
	public void getPendingGRPOList(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		FlexiBean requestParams = new FlexiBean(request);
		logger.info("entering getPendingGRPOList");
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
				
				//Code itemCode = order.getItemCode();
				Warehouse itemWareHouse = order.getWarehouse();

				stockRow.add("<input type='radio' name='order_id' value='"
						+ order.getOrderId()+ "'>");
				stockRow.add(String.valueOf(++count));
				stockRow.add(order.getPurchaseOrderNo());
				stockRow.add(order.getFirm().getFirmName());
				//stockRow.add(itemCode.getCodeDesc());
				//stockRow.add("" + order.getOrderQty() + " "+order.getUnit().getUnitName());
				stockRow.add("" + Util.getDateString(order.getDueDate(), "dd/MM/yyyy"));
				stockRow.add("" + order.getOrderType());
				strMap.put(String.valueOf(count++), stockRow);
			}
		}
		Util.doWriteFlexi(request, response, strMap, requestParams);
		logger.info("exiting getPendingGRPOList");
	}
	
	@RequestMapping(value = { "/saveGRPO" }, method = { RequestMethod.POST })
	public void saveGRPO(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		GRPO grpo = null;
		String grpoId = request.getParameter("grpoId");
		Boolean isNew = Boolean.FALSE;

		if (!StringUtils.isEmpty(grpoId)) {
			grpo = grpoService.getGRPOById(Integer
					.parseInt(grpoId));
		} else {
			grpo = new GRPO();
			isNew = Boolean.TRUE;
		}		
		String orderId = request.getParameter("orderId");
		
		if((!StringUtils.isEmpty(orderId))){
			PurchaseOrder purchaseOrder = purchaseService.getOrderById(Integer.parseInt(orderId));
			grpo.setOrderId(purchaseOrder);
		}

		String vendorDetails = request.getParameter("vendor");
		if(vendorDetails!=null){
			
			grpo.setVendorDetails(vendorDetails);
		}
		// User requestedByUser =((User)
		// request.getSession().getAttribute("_SessionUser"));
		User requestedByUser = masterservice.getUserById("27");
		grpo.setAddedBy(requestedByUser);
		grpo.setLastModifiedBy(requestedByUser);
		
      grpo.setBillAmount(Float.parseFloat(request.getParameter("billAmount")));
	  grpo.setInwardComments(request.getParameter("inwardComments"));
	  grpo.setGrDate(Util.getDate(request.getParameter("gr_date"),"dd/MM/yyyy"));
	  grpo.setVendorInvoiceDate(Util.getDate(request.getParameter("vendorInvoicedate"),"dd/MM/yyyy"));
	  grpo.setVendorInvoiceNo(request.getParameter("vendorInvoiceNo"));
	  grpo.setVehicleNo(request.getParameter("vehicleNo"));
	  
	  String rowCount = request.getParameter("rowhid");
	  int maxRows = 0;
	  if(null!=rowCount ){
			maxRows = Integer.parseInt(rowCount);
			}
	  if(isNew || grpo.getGrpoReceiptItems() == null){
		  grpo.setGrpoReceiptItems(new HashSet<GRPOReceiptEntry>());
		}
	  for(int i=0;i<maxRows;i++){
		  
		  String grpoEntryIdStr = request.getParameter("grpoItemId" + i);
			Integer grpoEntryId = null!=grpoEntryIdStr?Integer.parseInt(grpoEntryIdStr.trim()):null;
			Boolean isFound = Boolean.FALSE;
			GRPOReceiptEntry grpoItem = null;
			if(!isNew){
				Iterator <GRPOReceiptEntry>itr = grpo.getGrpoReceiptItems().iterator();
				while(itr.hasNext()){
					GRPOReceiptEntry gre = itr.next();
					if(gre.getGrpoEntryId() ==grpoEntryId){
						isFound = Boolean.TRUE;
						
						grpoItem =gre;
						break;
					}
				}
			}
			if(!isFound){
				grpoItem = new GRPOReceiptEntry();
			}
		  
		  
		  if((!StringUtils.isEmpty(orderId))){
				PurchaseOrder purchaseOrder = purchaseService.getOrderById(Integer.parseInt(orderId));
				grpoItem.setOrderId(purchaseOrder);
			}
		  String markingId = request.getParameter("marking_id");
			
			if((!StringUtils.isEmpty(markingId))){
				Procurement procurementMarking = procurementService.getProcurementById(Integer.parseInt(markingId));
			   grpoItem.setMarkingId(procurementMarking);	
			}
			Double basicRate = 0.0;
			String orderItemIdStr = request.getParameter("orderItemId"+i);
			if((!StringUtils.isEmpty(orderItemIdStr))){
				PurchaseOrderItem orderItemId = purchaseService.getOrderItemById(Integer.parseInt(orderItemIdStr));
				basicRate = orderItemId.getBasicRate();
				grpoItem.setOrderItemId(orderItemId);
	          }
			
			grpoItem.setBasicRate(basicRate);
			
			String itemCodeId = request.getParameter("item"+i);
            Integer codeId = Integer.parseInt(itemCodeId.trim());
            Code itemCode = masterservice.getCodeById(codeId);
			grpoItem.setItemCode(itemCode);
			
			grpoItem.setInwardQty(Float.parseFloat(request.getParameter("gr_Qty"+i)));
			
			Integer unitId = Integer.parseInt(request.getParameter("unit"+i));
            Unit itemUnit = masterservice.getUnitById(unitId);
			grpoItem.setUnit(itemUnit);
			
			
			
			grpoItem.setGrpo(grpo);
			if(!isFound){
				grpo.getGrpoReceiptItems().add(grpoItem);
			}
			
	  }
	  
		grpoService.saveGRPO(grpo);

	}
	@RequestMapping(value = { "/saveGRPOApproval" }, method = { RequestMethod.POST })
	public void saveGRPOApproval(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("entering saveGRPOApproval");
		GRPO grpo = null;
		String grpoId = request.getParameter("grpoId");
		Boolean isNew = Boolean.TRUE;
		if (!StringUtils.isEmpty(grpoId)) {
			grpo = grpoService.getGRPOById(Integer
					.parseInt(grpoId));
			isNew = Boolean.FALSE;
		} else {
			throw new Exception("Invalid Request");
		}
		
		grpo.setApprovalComments(request.getParameter("approval_comments"));
		grpo.setApprovalStatus(request.getParameter("approvalStatus"));
		grpo.setApprovalDate(new Date());
		String rejection_remarks = (request.getParameter("rejectRemaks"));
		if (!StringUtils.isEmpty(rejection_remarks)) {
			grpo.setRejectionComments(rejection_remarks);
		}
		

		// User requestedByUser =((User)
				// request.getSession().getAttribute("_SessionUser"));
		User approvedByUser = masterservice.getUserById("27");
		grpo.setApprovedBy(approvedByUser);
		
		  String rowCount = request.getParameter("rowhid");
		  int maxRows = 0;
		  if(null!=rowCount ){
				maxRows = Integer.parseInt(rowCount);
				}
		  for(int i=0;i<maxRows;i++){
			  String grpoEntryIdStr = request.getParameter("grpoItemId" + i);
				Integer grpoEntryId = null!=grpoEntryIdStr?Integer.parseInt(grpoEntryIdStr.trim()):null;
				
				GRPOReceiptEntry grpoItem = null;
				if(!isNew){
					Iterator <GRPOReceiptEntry>itr = grpo.getGrpoReceiptItems().iterator();
					while(itr.hasNext()){
						GRPOReceiptEntry gre = itr.next();
						if(gre.getGrpoEntryId() ==grpoEntryId){
							grpoItem =gre;
							break;
						}
					}
				} 
				grpoItem.setInwardQty(Float.parseFloat(request.getParameter("gr_Qty"+i)));
				grpoItem.setBasicRate(Double.parseDouble(request.getParameter("basicRate"+i)));
				
		  }
		  
		
		
		
		
		grpoService.saveGRPO(grpo);
		logger.info("exiting saveGRPOApproval");
	}
	
	
	@RequestMapping(value = { "/getGRPOList" }, method = { RequestMethod.POST })
	public void getGRPOList(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		FlexiBean requestParams = new FlexiBean(request);
		logger.info("entering getGRPOList");
		List<GRPO> grpos = grpoService.getGRPOList(requestParams);

		List<String> stockRow = null;
		Map<String, List<String>> strMap = new LinkedHashMap<String, List<String>>();
		if (!CollectionUtils.isEmpty(grpos)) {
			int count = 0;
			for (GRPO grpo : grpos) {
				if(grpo.getApprovalStatus()!=null){
					continue;
				}
							
				stockRow = new LinkedList<String>();
				
				//Code itemCode = grpo.getItemCode();
				
				
			
				Warehouse itemWareHouse = grpo.getOrderId().getWarehouse();

				stockRow.add("<input type='radio' name='grpo_id' value='"
						+ grpo.getGrpoId()+ "'>");
				stockRow.add(String.valueOf(++count));
				stockRow.add(grpo.getOrderId().getPurchaseOrderNo());
				
				stockRow.add(masterservice.getFirmById((itemWareHouse.getFirmId())+"").getFirmName());
				StringBuilder itemMarge = new StringBuilder();
				StringBuilder itemQty = new StringBuilder();
				StringBuilder dateMerge = new StringBuilder();
				
				for (GRPOReceiptEntry GRPOReceipt : grpo.getGrpoReceiptItems()){
					itemMarge.append("<p>");
					itemMarge.append( GRPOReceipt.getItemCode().getCodeDesc());
					itemMarge.append("</p>");
				
					itemQty.append("<p>");
					itemQty.append( "" + GRPOReceipt.getInwardQty() + " "+GRPOReceipt.getUnit().getUnitName());
					itemQty.append("</p>");
					
					dateMerge.append("<p>");
					//dateMerge.append(Util.getDateString(GRPOReceipt.getInwardDate(), "dd/MM/yyyy"));
					dateMerge.append("</p>");
				
				}
				stockRow.add(itemMarge.toString());
				stockRow.add(itemQty.toString());
				//stockRow.add(dateMerge.toString());
				
				stockRow.add(Util.getDateString(grpo.getGrDate(), "dd/MM/yyyy"));
				stockRow.add(grpo.getAddedBy().getUserName());
				strMap.put(String.valueOf(count), stockRow);
			}
		}
		Util.doWriteFlexi(request, response, strMap, requestParams);
		logger.info("exiting getGRPOList");

	}
	

	@RequestMapping(value = { "/getGRPOListApprovalCompleted" }, method = { RequestMethod.POST })
	public void getGRPOListApprovalCompleted(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		FlexiBean requestParams = new FlexiBean(request);
		logger.info("entering getGRPOListApprovalCompleted");
		List<GRPO> grpos = grpoService.getGRPOList(requestParams);

		List<String> stockRow = null;
		Map<String, List<String>> strMap = new LinkedHashMap<String, List<String>>();
		if (!CollectionUtils.isEmpty(grpos)) {
			int count = 0;
			for (GRPO grpo : grpos) {
				if(grpo.getApprovalStatus()==null){
					continue;
				}
				
				stockRow = new LinkedList<String>();
				
				//Code itemCode = grpo.getItemCode();
				Warehouse itemWareHouse = grpo.getOrderId().getWarehouse();
				stockRow.add("<input type='radio' name='grpo_id' value='"
						+ grpo.getGrpoId()+ "'>");
				stockRow.add(String.valueOf(++count));
				stockRow.add(grpo.getOrderId().getPurchaseOrderNo());
				
				stockRow.add(masterservice.getFirmById((itemWareHouse.getFirmId())+"").getFirmName());
				StringBuilder itemMarge = new StringBuilder();
				StringBuilder itemQty = new StringBuilder();
				StringBuilder dateMerge = new StringBuilder();
				
				for (GRPOReceiptEntry GRPOReceipt : grpo.getGrpoReceiptItems()){
					itemMarge.append("<p>");
					itemMarge.append( GRPOReceipt.getItemCode().getCodeDesc());
					itemMarge.append("</p>");
				
					itemQty.append("<p>");
					itemQty.append( "" + GRPOReceipt.getInwardQty() + " "+GRPOReceipt.getUnit().getUnitName());
					itemQty.append("</p>");
					
					dateMerge.append("<p>");
					//dateMerge.append(Util.getDateString(GRPOReceipt.getInwardDate(), "dd/MM/yyyy"));
					dateMerge.append("</p>");
				
				}
				stockRow.add(itemMarge.toString());
				stockRow.add(itemQty.toString());
				stockRow.add(dateMerge.toString());
				stockRow.add( grpo.getAddedBy().getUserName());
				stockRow.add(grpo.getApprovalStatus().equalsIgnoreCase("Y")?"Approved":"Rejected");
				
				stockRow.add( Util.getDateString(grpo.getApprovalDate(), "dd/MM/yyyy"));
				strMap.put(String.valueOf(count), stockRow);
			}
		}
		Util.doWriteFlexi(request, response, strMap, requestParams);
		logger.info("exiting getGRPOListApprovalCompleted");

	}

}
