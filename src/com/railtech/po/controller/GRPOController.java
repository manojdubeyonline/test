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
import com.railtech.po.entity.GRPO;
import com.railtech.po.entity.GRPOReceiptEntry;
import com.railtech.po.entity.GRRateApplied;
import com.railtech.po.entity.ModelForm;
import com.railtech.po.entity.Procurement;
import com.railtech.po.entity.PurchaseOrder;
import com.railtech.po.entity.PurchaseOrderItem;
import com.railtech.po.entity.Rate;
import com.railtech.po.entity.RateApplied;
import com.railtech.po.entity.Unit;
import com.railtech.po.entity.User;
import com.railtech.po.entity.Vendor;
import com.railtech.po.entity.VendorDetails;
import com.railtech.po.entity.Warehouse;
import com.railtech.po.service.GRPOService;
import com.railtech.po.service.MasterInfoService;
import com.railtech.po.service.ProcurementService;
import com.railtech.po.service.PurchaseService;
import com.railtech.po.service.RequisitionService;
import com.railtech.po.util.POConstants;
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
	
	@RequestMapping(value = { "/generateGoodsRecieptNo" }, method = { RequestMethod.POST })
	public @ResponseBody String generateGoodsRecieptNo(@RequestBody ModelForm modelRequest)
	{
		String  firmId = modelRequest.getId();
		String wareId = modelRequest.getId2();
		String goodsRecieptNo = grpoService.generateGoodsRecieptNo(firmId,wareId);
		return goodsRecieptNo;
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
		List<GRPO> grpos = grpoService.getGRPOList(requestParams);
		User currentUser =((User) request.getSession().getAttribute("_SessionUser"));
		List<String> stockRow = null;
		Map<String, List<String>> strMap = new LinkedHashMap<String, List<String>>();
		if (!CollectionUtils.isEmpty(orders)) {
			int count = 1;
			
			double Qty =  0;
			for (PurchaseOrder order : orders) {
				
				
				
				if(null != order.getApprovalStatus() && order.getApprovalStatus().equalsIgnoreCase("Y")){
					 for(Warehouse warehouse:currentUser.getUserWarehouses()){
							if(warehouse.getWareId().intValue() == order.getWarehouse().getWareId().intValue()){
				StringBuilder itemMarge = new StringBuilder();
				StringBuilder itemQty = new StringBuilder();
				for (PurchaseOrderItem purchaseItem : order.getOrderItems()) {
					
					Double GrQty = 0.0;
                   for(GRPO grpo: grpos){	
                	//GrQty = 0.0;
						for(GRPOReceiptEntry receiptEntry:grpo.getGrpoReceiptItems()){
							if( receiptEntry.getOrderItemId() != null){
					
							if(purchaseItem.getItemKey() == receiptEntry.getOrderItemId().getItemKey())
								GrQty = GrQty + receiptEntry.getInwardQty();
							}
						}
						 
						}
					Qty = purchaseItem.getQty() - GrQty;
					
				if(Qty>0){	
				stockRow = new LinkedList<String>();
				
				stockRow.add("<input type='radio' name='order_id' value='"
						+ order.getOrderId()+ "'>");
				stockRow.add(String.valueOf(count));
				stockRow.add(order.getPurchaseOrderNo());
				stockRow.add(order.getVendor().getVendorName());
				stockRow.add(order.getFirm().getFirmName());
				
				//for (PurchaseOrderItem purchaseItem : order.getOrderItems()){
					itemMarge.append("<p>");
					itemMarge.append( purchaseItem.getItemCode().getCodeDesc());
					itemMarge.append("</p>");
				
					itemQty.append("<p>");
					itemQty.append( "" + Qty + " "+purchaseItem.getUnit().getUnitName());
					itemQty.append("</p>");
				
				stockRow.add(itemMarge.toString());
				stockRow.add(itemQty.toString());
				stockRow.add(Util.getDateString(order.getApprovalDate(), "dd/MM/yyyy"));
}
				
				}
			
				
				
				strMap.put(String.valueOf(++count), stockRow);	

				}
					 }
				}
		  } 
			
		}
		Util.doWriteFlexi(request, response, strMap, requestParams);
		logger.info("exiting getPurchaseOrderListApprovalCompleted");

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
		grpo.setGoodsRecieptNo(request.getParameter("recieptNo"));
		String vendorId = request.getParameter("vendor");
		if(vendorId!=null){
			Vendor vendor = masterservice.getVendorById(vendorId);
			grpo.setVendor(vendor);
		}
		
		String locationId = request.getParameter("vendorAddress");
		
		if(locationId!=null){
			VendorDetails vendorDetails = masterservice.getVendorDetailsById(locationId);
			grpo.setVendorDetail(vendorDetails);
		}
		String warehouseId = null;
		String warehouseLocalId = request.getParameter("warehouse");
		if(!StringUtils.isEmpty(warehouseLocalId)){
			warehouseId = warehouseLocalId;
		}
		else{
			warehouseId = request.getParameter("warehouseId");
		}

		
		
			Warehouse warehouse = masterservice.getWareHouseById(warehouseId);
			grpo.setWarehouse(warehouse);
	
			String firmId = null;

			String firmLocalId = request.getParameter("firm");
			if(!StringUtils.isEmpty(firmLocalId)){
				firmId = firmLocalId;
			}
			else{
				firmId = request.getParameter("firmId");
			}
			
		
			Firm firm = masterservice.getFirmById(firmId);
			grpo.setFirm(firm);
	
		
		User requestedByUser =((User)
		request.getSession().getAttribute("_SessionUser"));
		//User requestedByUser = masterservice.getUserById("27");
		grpo.setAddedBy(requestedByUser);
		grpo.setLastModifiedBy(requestedByUser);
		String grType = request.getParameter("grType").trim();
		grpo.setGrType(grType);
		
      grpo.setBillAmount(Float.parseFloat(request.getParameter("grLevelGrandTotal")));
	  grpo.setInwardComments(request.getParameter("inwardComments"));
	  grpo.setGrDate(Util.getDate(request.getParameter("gr_date"),"dd/MM/yyyy"));
	  grpo.setVendorInvoiceDate(Util.getDate(request.getParameter("vendorInvoicedate"),"dd/MM/yyyy"));
	  grpo.setVendorInvoiceNo(request.getParameter("vendorInvoiceNo"));
	  grpo.setVehicleNo(request.getParameter("vehicleNo"));
	  
	  String rowCount = request.getParameter("rowhid");
	  String orderCount = request.getParameter("grLevelRateId");
	  int maxRows = 0;
	  int orderRows = 0;
	  if(null!=rowCount && null != orderCount){
			maxRows = Integer.parseInt(rowCount);
			orderRows = Integer.parseInt(orderCount);
			}
	  String itemRateRows = request.getParameter("rowId");
		 int grItemRateRows = 0;
		  if(null!=itemRateRows ){
			  grItemRateRows = Integer.parseInt(itemRateRows);
			  
				}
	  
	  if(isNew || grpo.getGrpoReceiptItems() == null){
		  grpo.setGrpoReceiptItems(new HashSet<GRPOReceiptEntry>());
		}
	  
	
		Boolean isNewGrRates = Boolean.FALSE;
		double grItemQty = 0;
		double orderQty = 0;
		Double grBasicRate = 0.0;
		Double orderBasicRate = 0.0;
		int flag = 0;
	  for(int i=0;i<maxRows;i++){
		  
		  Set<GRRateApplied> itemLevelGrRatesApplied = new HashSet<GRRateApplied> ();
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
				isNewGrRates = Boolean.TRUE;
			}
		  
		  
		  if((!StringUtils.isEmpty(orderId))){
				PurchaseOrder purchaseOrder = purchaseService.getOrderById(Integer.parseInt(orderId));
				grpoItem.setOrderId(purchaseOrder);
			}
		 
			
			String orderItemIdStr = request.getParameter("orderItemId"+i);
			PurchaseOrderItem orderItemId = null;
			if((!StringUtils.isEmpty(orderItemIdStr))){
				orderItemId = purchaseService.getOrderItemById(Integer.parseInt(orderItemIdStr));
				
				grpoItem.setOrderItemId(orderItemId);
	          }
			
String markingId = request.getParameter("marking_id"+i);
			
			if((!StringUtils.isEmpty(markingId))){
				Integer markId =  Integer.parseInt(markingId.trim());
				Procurement procurementMarking = procurementService.getProcurementById(markId);
				grpoItem.setProcurementMarking(procurementMarking);
			}
			
			//grpoItem.setBasicRate(basicRate);
			
			String itemCodeId = request.getParameter("item"+i);
            Integer codeId = Integer.parseInt(itemCodeId.trim());
            Code itemCode = masterservice.getCodeById(codeId);
			grpoItem.setItemCode(itemCode);
			float inwardQty = Float.parseFloat(request.getParameter("gr_Qty"+i).trim());
			grItemQty = (double)inwardQty;
			grpoItem.setInwardQty(inwardQty);
			
			Integer unitId = Integer.parseInt(request.getParameter("unit"+i));
            Unit itemUnit = masterservice.getUnitById(unitId);
			grpoItem.setUnit(itemUnit);
			
			
			 GRRateApplied grItemRate = null;
			for(int j=0;j<grItemRateRows;j++)
			{
				
				
				String rateValue = request.getParameter("rateValue"+i+j);
				if(rateValue == null) 
					continue;
				else{
					
					String itemKeyStr = request.getParameter("grItemRateId"+i+j);
					Integer itemKey = null!=itemKeyStr?Integer.parseInt(itemKeyStr.trim()):null;
					Boolean isRateApplied = Boolean.FALSE;
					
					if(!isNewGrRates){
						Iterator <GRRateApplied>itr = grpoItem.getItemLevelGRRates().iterator();
						while(itr.hasNext()){
							GRRateApplied itm = itr.next();
							if(itm.getGrRateId().intValue() ==itemKey.intValue()){
								isRateApplied = Boolean.TRUE;
								grItemRate =itm;
								break;
							}
						}
					}
					if(!isRateApplied){
						grItemRate = new GRRateApplied();
					}
					
					
					Integer rateId = Integer.parseInt(request.getParameter("rateName"+i+j));
					Rate rate = masterservice.getRateById(rateId);
					//GRRateApplied grRateApplied = new GRRateApplied();
					grItemRate.setRate(rate);
					if(rateId == 1){
						grBasicRate = new Double(rateValue);
					}
					grItemRate.setAppliedAmount(new Double(rateValue));
					grItemRate.setLevelStatus(POConstants.STATUS_ITEM_LEVEL);
					grItemRate.setGrRecieptId(grpoItem);
					grItemRate.setGrId(grpo);
					itemLevelGrRatesApplied.add(grItemRate);
				}
				
			}
			//Item level total value
			String rateValue = request.getParameter("itemLevelTotal"+i);
			Rate rate = masterservice.getRateById(21);
			//GRRateApplied grRateApplied = new GRRateApplied();
			 GRRateApplied grItemTotalRate = null;
			String itemKeyStr = request.getParameter("itemLevelTotalRAId"+i);
			Integer itemKey = null!=itemKeyStr?Integer.parseInt(itemKeyStr.trim()):null;
			Boolean isRateApplied = Boolean.FALSE;
			
			if(!isNewGrRates){
				Iterator <GRRateApplied>itr = grpoItem.getItemLevelGRRates().iterator();
				while(itr.hasNext()){
					GRRateApplied itm = itr.next();
					if(itm.getGrRateId().intValue() ==itemKey.intValue()){
						isRateApplied = Boolean.TRUE;
						grItemTotalRate =itm;
						break;
					}
				}
			}
			if(!isRateApplied){
				grItemTotalRate = new GRRateApplied();
			}
			
			
			grItemTotalRate.setRate(rate);
			grItemTotalRate.setAppliedAmount(new Double(rateValue));
			grItemTotalRate.setLevelStatus(POConstants.STATUS_ITEM_LEVEL);
			grItemTotalRate.setGrRecieptId(grpoItem);
			grItemTotalRate.setGrId(grpo);
			itemLevelGrRatesApplied.add(grItemTotalRate);
			
			
			grpoItem.setItemLevelGRRates(itemLevelGrRatesApplied);
			
			grpoItem.setGrpo(grpo);
			if(!isFound){
				grpo.getGrpoReceiptItems().add(grpoItem);
			}
		
			if(null != orderItemId){
			for(RateApplied rateApplied:orderItemId.getItemLevelRates()){
				if(rateApplied.getRate().getRateId() == 1){
					orderBasicRate = rateApplied.getAppliedAmount();
				}
			}
			orderQty = orderItemId.getQty();
			}
			
			if(grItemQty<=orderQty && grBasicRate<=orderBasicRate){
				flag++;
			}
			
		}
	  //End of Item Level GR Rates
	  
	  
	  
		//GR Level Rates
		Set<GRRateApplied> GrLevelRatesApplied = new HashSet<GRRateApplied> ();
		GRRateApplied grLevelRate = null;
		for(int j=0;j<orderRows;j++)
		{
			String rateValue = request.getParameter("orderLevelRate"+j);
			if(rateValue == null) 
				continue;
			else{
				
				String itemKeyStr = request.getParameter("grLevelRateId"+j);
				Integer itemKey = null!=itemKeyStr?Integer.parseInt(itemKeyStr.trim()):null;
				Boolean isGrLevelRate = Boolean.FALSE;
				
				if(!isNewGrRates){
					Iterator <GRRateApplied>itr = grpo.getGrLevelRates().iterator();
					while(itr.hasNext()){
						GRRateApplied itm = itr.next();
						if(itm.getGrRateId().intValue() ==itemKey.intValue()){
							isGrLevelRate = Boolean.TRUE;
							
							grLevelRate =itm;
							break;
						}
					}
				}
				if(!isGrLevelRate){
					grLevelRate = new GRRateApplied();
				}
				
				Integer rateId = Integer.parseInt(request.getParameter("ratesName"+j));
				Rate rate = masterservice.getRateById(rateId);
				//GRRateApplied grRateApplied = new GRRateApplied();
				grLevelRate.setRate(rate);
				grLevelRate.setAppliedAmount(new Double(rateValue));
				grLevelRate.setLevelStatus(POConstants.STATUS_ORDER_LEVEL);
				//grRateApplied.setGrRecieptId(grpoItem);
				grLevelRate.setGrId(grpo);
				GrLevelRatesApplied.add(grLevelRate);
			}
			
		}
		//GR level total value
		String rateValue = request.getParameter("grLevelTotal");
		int rateV = Integer.parseInt(rateValue);
		Rate rate = masterservice.getRateById(22);
		
		//GRRateApplied grRateApplied = new GRRateApplied();
		if(!StringUtils.isEmpty(rateValue) && rateV !=0){
			GRRateApplied grLevelTotalRateApplied = null;
			String itemKeyStr = request.getParameter("grLevelId");
			Integer itemKey = null;
			if(itemKeyStr != null && itemKeyStr != ""){
				itemKey = Integer.parseInt(itemKeyStr.trim());
			}
			
			Boolean isGrLevelRate = Boolean.FALSE;
			
			if(!isNewGrRates){
				Iterator <GRRateApplied>itr = grpo.getGrLevelRates().iterator();
				while(itr.hasNext()){
					GRRateApplied itm = itr.next();
					if(itm.getGrRateId().intValue() ==itemKey.intValue()){
						isGrLevelRate = Boolean.TRUE;
						
						grLevelTotalRateApplied =itm;
						break;
					}
				}
			}
			if(!isGrLevelRate){
				grLevelTotalRateApplied = new GRRateApplied();
			}
			
			grLevelTotalRateApplied.setRate(rate);
			grLevelTotalRateApplied.setAppliedAmount(new Double(rateValue));
			grLevelTotalRateApplied.setLevelStatus(POConstants.STATUS_ORDER_LEVEL);
			//grRateApplied.setGrRecieptId(grpoItem);
			grLevelTotalRateApplied.setGrId(grpo);
			GrLevelRatesApplied.add(grLevelTotalRateApplied);
		}
		
		//GR level grand total value
		GRRateApplied grTotalRateApplied = null;
		String itemKeyStr = request.getParameter("grTotalRateAppliedId");
		Integer itemKey = null;
		if(itemKeyStr != null && itemKeyStr != ""){
			itemKey = Integer.parseInt(itemKeyStr.trim());
		}
		
		Boolean isGrLevelRate = Boolean.FALSE;
		
		if(!isNewGrRates){
			Iterator <GRRateApplied>itr = grpo.getGrLevelRates().iterator();
			while(itr.hasNext()){
				GRRateApplied itm = itr.next();
				if(itm.getGrRateId().intValue() ==itemKey.intValue()){
					isGrLevelRate = Boolean.TRUE;
					
					grTotalRateApplied =itm;
					break;
				}
			}
		}
		if(!isGrLevelRate){
			grTotalRateApplied = new GRRateApplied();
		}
		
		
		rateValue = request.getParameter("grLevelGrandTotal");
		rate = masterservice.getRateById(23);
		//grRateApplied = new GRRateApplied();
		grTotalRateApplied.setRate(rate);
		grTotalRateApplied.setAppliedAmount(new Double(rateValue));
		grTotalRateApplied.setLevelStatus("T");
		grTotalRateApplied.setGrId(grpo);
		//grRateApplied.setItemKeyId(purchaseItem);
		GrLevelRatesApplied.add(grTotalRateApplied);
						
	  
		grpo.setGrLevelRates(GrLevelRatesApplied);
		
		if(flag == maxRows || grType.equalsIgnoreCase("Local Purchase GR") || grType.equalsIgnoreCase("Direct Goods Receipt")){
			grpo.setApprovalStatus("Y");
			grpo.setApprovalDate(new Date());
			grpo.setApprovedBy(requestedByUser);
		}
		
		grpoService.saveGrpo(grpo);

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
		String rejection_remarks = request.getParameter("rejectRemaks");
		if (!StringUtils.isEmpty(rejection_remarks)) {
			grpo.setRejectionComments(rejection_remarks);
		}
		

		User approvedByUser =((User)
				request.getSession().getAttribute("_SessionUser"));
		//User approvedByUser = masterservice.getUserById("27");
		grpo.setApprovedBy(approvedByUser);
		
		
		String rowCount = request.getParameter("rowhid");
		  String orderCount = request.getParameter("grLevelRateId");
		 int maxRows = 0;
		  int orderRows = 0;
		  if(null!=rowCount && null != orderCount){
				maxRows = Integer.parseInt(rowCount);
				orderRows = Integer.parseInt(orderCount);
				}
		  String itemRateRows = request.getParameter("rowId");
			 int grItemRateRows = 0;
			  if(null!=itemRateRows ){
				  grItemRateRows = Integer.parseInt(itemRateRows);
				  
					}
			  Boolean isNewGrRates = Boolean.FALSE;
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
				grpoItem.setGrApproveQty(Float.parseFloat(request.getParameter("gr_Approve_Qty"+i)));
				
				Set<GRRateApplied> itemLevelGrRatesApplied = new HashSet<GRRateApplied> ();
				 GRRateApplied grItemRate = null;
					for(int j=0;j<grItemRateRows;j++)
					{
						
						
						String rateValue = request.getParameter("rateValue"+i+j);
						if(rateValue == null) 
							continue;
						else{
							
							String itemKeyStr = request.getParameter("grItemRateId"+i+j);
							Integer itemKey = null!=itemKeyStr?Integer.parseInt(itemKeyStr.trim()):null;
							Boolean isRateApplied = Boolean.FALSE;
							
							if(!isNewGrRates){
								Iterator <GRRateApplied>itr = grpoItem.getItemLevelGRRates().iterator();
								while(itr.hasNext()){
									GRRateApplied itm = itr.next();
									if(itm.getGrRateId().intValue() ==itemKey.intValue()){
										isRateApplied = Boolean.TRUE;
										grItemRate =itm;
										break;
									}
								}
							}
							if(!isRateApplied){
								grItemRate = new GRRateApplied();
							}
							
							
							Integer rateId = Integer.parseInt(request.getParameter("rateName"+i+j));
							Rate rate = masterservice.getRateById(rateId);
							//GRRateApplied grRateApplied = new GRRateApplied();
							grItemRate.setRate(rate);
							grItemRate.setAppliedAmount(new Double(rateValue));
							grItemRate.setLevelStatus(POConstants.STATUS_ITEM_LEVEL);
							grItemRate.setGrRecieptId(grpoItem);
							grItemRate.setGrId(grpo);
							itemLevelGrRatesApplied.add(grItemRate);
						}
						
					}
					//Item level total value
					String rateValue = request.getParameter("itemLevelTotal"+i);
					Rate rate = masterservice.getRateById(21);
					//GRRateApplied grRateApplied = new GRRateApplied();
					 GRRateApplied grItemTotalRate = null;
					String itemKeyStr = request.getParameter("itemLevelTotalRAId"+i);
					Integer itemKey = null!=itemKeyStr?Integer.parseInt(itemKeyStr.trim()):null;
					Boolean isRateApplied = Boolean.FALSE;
					
					if(!isNewGrRates){
						Iterator <GRRateApplied>itr = grpoItem.getItemLevelGRRates().iterator();
						while(itr.hasNext()){
							GRRateApplied itm = itr.next();
							if(itm.getGrRateId().intValue() ==itemKey.intValue()){
								isRateApplied = Boolean.TRUE;
								grItemTotalRate =itm;
								break;
							}
						}
					}
					if(!isRateApplied){
						grItemTotalRate = new GRRateApplied();
					}
					
					
					grItemTotalRate.setRate(rate);
					grItemTotalRate.setAppliedAmount(new Double(rateValue));
					grItemTotalRate.setLevelStatus(POConstants.STATUS_ITEM_LEVEL);
					grItemTotalRate.setGrRecieptId(grpoItem);
					grItemTotalRate.setGrId(grpo);
					itemLevelGrRatesApplied.add(grItemTotalRate);
					
					
					grpoItem.setItemLevelGRRates(itemLevelGrRatesApplied);
					
					grpoItem.setGrpo(grpo);
					if(!isFound){
						grpo.getGrpoReceiptItems().add(grpoItem);
					}
					
					
				
				
				
		  }
		//GR Level Rates
			Set<GRRateApplied> GrLevelRatesApplied = new HashSet<GRRateApplied> ();
			GRRateApplied grLevelRate = null;
			for(int j=0;j<orderRows;j++)
			{
				String rateValue = request.getParameter("orderLevelRate"+j);
				if(rateValue == null) 
					continue;
				else{
					
					String itemKeyStr = request.getParameter("grLevelRateId"+j);
					Integer itemKey = null!=itemKeyStr?Integer.parseInt(itemKeyStr.trim()):null;
					Boolean isGrLevelRate = Boolean.FALSE;
					
					if(!isNewGrRates){
						Iterator <GRRateApplied>itr = grpo.getGrLevelRates().iterator();
						while(itr.hasNext()){
							GRRateApplied itm = itr.next();
							if(itm.getGrRateId().intValue() ==itemKey.intValue()){
								isGrLevelRate = Boolean.TRUE;
								
								grLevelRate =itm;
								break;
							}
						}
					}
					if(!isGrLevelRate){
						grLevelRate = new GRRateApplied();
					}
					
					Integer rateId = Integer.parseInt(request.getParameter("ratesName"+j));
					Rate rate = masterservice.getRateById(rateId);
					//GRRateApplied grRateApplied = new GRRateApplied();
					grLevelRate.setRate(rate);
					grLevelRate.setAppliedAmount(new Double(rateValue));
					grLevelRate.setLevelStatus(POConstants.STATUS_ORDER_LEVEL);
					//grRateApplied.setGrRecieptId(grpoItem);
					grLevelRate.setGrId(grpo);
					GrLevelRatesApplied.add(grLevelRate);
				}
				
			}
			//GR level total value
			String rateValue = request.getParameter("grLevelTotal");
			int rateV = Integer.parseInt(rateValue);
			Rate rate = masterservice.getRateById(22);
			
			//GRRateApplied grRateApplied = new GRRateApplied();
			if(!StringUtils.isEmpty(rateValue) && rateV !=0){
				GRRateApplied grLevelTotalRateApplied = null;
				String itemKeyStr = request.getParameter("grLevelId");
				Integer itemKey = null;
				if(itemKeyStr != null && itemKeyStr != ""){
					itemKey = Integer.parseInt(itemKeyStr.trim());
				}
				
				Boolean isGrLevelRate = Boolean.FALSE;
				
				if(!isNewGrRates){
					Iterator <GRRateApplied>itr = grpo.getGrLevelRates().iterator();
					while(itr.hasNext()){
						GRRateApplied itm = itr.next();
						if(itm.getGrRateId().intValue() ==itemKey.intValue()){
							isGrLevelRate = Boolean.TRUE;
							
							grLevelTotalRateApplied =itm;
							break;
						}
					}
				}
				if(!isGrLevelRate){
					grLevelTotalRateApplied = new GRRateApplied();
				}
				
				grLevelTotalRateApplied.setRate(rate);
				grLevelTotalRateApplied.setAppliedAmount(new Double(rateValue));
				grLevelTotalRateApplied.setLevelStatus(POConstants.STATUS_ORDER_LEVEL);
				//grRateApplied.setGrRecieptId(grpoItem);
				grLevelTotalRateApplied.setGrId(grpo);
				GrLevelRatesApplied.add(grLevelTotalRateApplied);
			}
			
			//GR level grand total value
			GRRateApplied grTotalRateApplied = null;
			String itemKeyStr = request.getParameter("grTotalRateAppliedId");
			Integer itemKey = null;
			if(itemKeyStr != null && itemKeyStr != ""){
				itemKey = Integer.parseInt(itemKeyStr.trim());
			}
			
			Boolean isGrLevelRate = Boolean.FALSE;
			
			if(!isNewGrRates){
				Iterator <GRRateApplied>itr = grpo.getGrLevelRates().iterator();
				while(itr.hasNext()){
					GRRateApplied itm = itr.next();
					if(itm.getGrRateId().intValue() ==itemKey.intValue()){
						isGrLevelRate = Boolean.TRUE;
						
						grTotalRateApplied =itm;
						break;
					}
				}
			}
			if(!isGrLevelRate){
				grTotalRateApplied = new GRRateApplied();
			}
			
			
			rateValue = request.getParameter("totalBillAmount");
			rate = masterservice.getRateById(23);
			//grRateApplied = new GRRateApplied();
			grTotalRateApplied.setRate(rate);
			//Double value = Double.parseDouble(rateValue);
			grTotalRateApplied.setAppliedAmount(new Double(rateValue.trim()));
			grTotalRateApplied.setLevelStatus("T");
			grTotalRateApplied.setGrId(grpo);
			//grRateApplied.setItemKeyId(purchaseItem);
			GrLevelRatesApplied.add(grTotalRateApplied);
							
		  
			grpo.setGrLevelRates(GrLevelRatesApplied);
		
		
		
		
		grpoService.saveGrpo(grpo);
		logger.info("exiting saveGRPOApproval");
	}
	
	
	@RequestMapping(value = { "/getGRPOList" }, method = { RequestMethod.POST })
	public void getGRPOList(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		FlexiBean requestParams = new FlexiBean(request);
		logger.info("entering getGRPOList");
		List<GRPO> grpos = grpoService.getGRPOList(requestParams);
		User currentUser =((User) request.getSession().getAttribute("_SessionUser"));
		List<String> stockRow = null;
		Map<String, List<String>> strMap = new LinkedHashMap<String, List<String>>();
		if (!CollectionUtils.isEmpty(grpos)) {
			int count = 0;
			for (GRPO grpo : grpos) {
				
				//if(!currentUser.getUserWarehouses().contains(grpo.getWarehouse())){
				//	continue;
				//}
				
				//if(grpo.getApprovalStatus()!=null){
					//continue;
				//}
				for(Warehouse warehouse:currentUser.getUserWarehouses()){
					if(warehouse.getWareId().intValue() == grpo.getWarehouse().getWareId().intValue()){
							
				stockRow = new LinkedList<String>();
				
				//Code itemCode = grpo.getItemCode();
				Warehouse itemWareHouse = null;
				PurchaseOrder order = grpo.getOrderId();
				if(order != null){
					itemWareHouse = order.getWarehouse();
				}
				else{
					
				}
			
				//Warehouse itemWareHouse = grpo.getOrderId().getWarehouse();

				stockRow.add("<input type='radio' name='grpo_id' value='"
						+ grpo.getGrpoId()+ "'>");
				stockRow.add(String.valueOf(++count));
				stockRow.add(grpo.getGoodsRecieptNo());
				
				//stockRow.add(masterservice.getFirmById((itemWareHouse.getFirmId())+"").getFirmName());
				stockRow.add(grpo.getFirm().getFirmName());
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
			}
		}
		Util.doWriteFlexi(request, response, strMap, requestParams);
		logger.info("exiting getGRPOList");

	}
	
	@RequestMapping(value = { "/getGRPOListForApproval" }, method = { RequestMethod.POST })
	public void getGRPOListForApproval(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		FlexiBean requestParams = new FlexiBean(request);
		logger.info("entering getGRPOListForApproval");
		List<GRPO> grpos = grpoService.getGRPOList(requestParams);
		User currentUser =((User) request.getSession().getAttribute("_SessionUser"));
		//List<PurchaseOrder> orders = purchaseService.getOrderList(requestParams);
		List<String> stockRow = null;
		Map<String, List<String>> strMap = new LinkedHashMap<String, List<String>>();
		if (!CollectionUtils.isEmpty(grpos)) {
			int count = 0;
			for (GRPO grpo : grpos) {
				
				for(Warehouse warehouse:currentUser.getUserWarehouses()){
					if(warehouse.getWareId().intValue() == grpo.getWarehouse().getWareId().intValue()){
				
				StringBuilder itemMarge = new StringBuilder();
				StringBuilder itemQty = new StringBuilder();
				/*
				double poRate = 0.0;
				double grRate = 0.0;
				double poQty = 0.0;
				for (GRPOReceiptEntry GRPOReceipt : grpo.getGrpoReceiptItems()){
					PurchaseOrderItem poItem = GRPOReceipt.getOrderItemId();
					if(poItem != null){
					Set<RateApplied> poItemRate = GRPOReceipt.getOrderItemId().getItemLevelRates();
					for(RateApplied rateApplied:poItemRate){
						Integer rateId = rateApplied.getRate().getRateId();
						if(rateId == 1){
							poRate = rateApplied.getAppliedAmount();
						}
					}
				
					 poQty = GRPOReceipt.getOrderItemId().getHistQty();
					}
					else{
						 poQty = GRPOReceipt.getProcurementMarking().getProcurementQty();
					}
					Set<GRRateApplied> grItemRate = GRPOReceipt.getItemLevelGRRates();
					for(GRRateApplied grRateApplied :grItemRate){
						Integer grRateId = grRateApplied.getRate().getRateId();
						if(grRateId == 1){
							grRate = grRateApplied.getAppliedAmount();
						}
					}
					*/
				if(grpo.getApprovalStatus()!=null){
					continue;
				}
				//if(!currentUser.getUserWarehouses().contains(grpo.getWarehouse())){
					//continue;
				//}
				//if(poQty>GRPOReceipt.getInwardQty() && grRate<=poRate){
					//continue;
				//}
							
				stockRow = new LinkedList<String>();
				
				stockRow.add("<input type='radio' name='grpo_id' value='"
						+ grpo.getGrpoId()+ "'>");
				stockRow.add(String.valueOf(++count));
				stockRow.add(grpo.getGoodsRecieptNo());
				
				
				stockRow.add(grpo.getFirm().getFirmName());
				
				for (GRPOReceiptEntry GRPOReceipt : grpo.getGrpoReceiptItems()){
				
					itemMarge.append("<p>");
					itemMarge.append( GRPOReceipt.getItemCode().getCodeDesc());
					itemMarge.append("</p>");
				
					itemQty.append("<p>");
					itemQty.append( "" + GRPOReceipt.getInwardQty() + " "+GRPOReceipt.getUnit().getUnitName());
					itemQty.append("</p>");
					
				}
				
				
				stockRow.add(itemMarge.toString());
				stockRow.add(itemQty.toString());
				
				
				stockRow.add(Util.getDateString(grpo.getGrDate(), "dd/MM/yyyy"));
				stockRow.add(grpo.getAddedBy().getUserName());
				}
				strMap.put(String.valueOf(count), stockRow);
		
				}
			}
			
		}
		Util.doWriteFlexi(request, response, strMap, requestParams);
		logger.info("exiting getGRPOListForApproval");

	}
	

	@RequestMapping(value = { "/getGRPOListApprovalCompleted" }, method = { RequestMethod.POST })
	public void getGRPOListApprovalCompleted(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		FlexiBean requestParams = new FlexiBean(request);
		logger.info("entering getGRPOListApprovalCompleted");
		List<GRPO> grpos = grpoService.getGRPOList(requestParams);
		User currentUser =((User) request.getSession().getAttribute("_SessionUser"));
		List<String> stockRow = null;
		Map<String, List<String>> strMap = new LinkedHashMap<String, List<String>>();
		if (!CollectionUtils.isEmpty(grpos)) {
			int count = 0;
			for (GRPO grpo : grpos) {
				for(Warehouse warehouse:currentUser.getUserWarehouses()){
					if(warehouse.getWareId().intValue() == grpo.getWarehouse().getWareId().intValue()){
				if(grpo.getApprovalStatus()==null){
					continue;
				}
				if(grpo.getApprovalStatus().equalsIgnoreCase("Y")){

					//if(!currentUser.getUserWarehouses().contains(grpo.getWarehouse())){
					//	continue;
					//}
				stockRow = new LinkedList<String>();
				
				//Code itemCode = grpo.getItemCode();
				Warehouse itemWareHouse = grpo.getWarehouse();
				stockRow.add("<input type='radio' name='grpo_id' value='"
						+ grpo.getGrpoId()+ "'>");
				stockRow.add(String.valueOf(++count));
				stockRow.add(grpo.getGoodsRecieptNo());
				
				stockRow.add(masterservice.getFirmById((itemWareHouse.getFirmId())+"").getFirmName());
				StringBuilder itemMarge = new StringBuilder();
				StringBuilder itemQty = new StringBuilder();
				
				
				for (GRPOReceiptEntry GRPOReceipt : grpo.getGrpoReceiptItems()){
					itemMarge.append("<p>");
					itemMarge.append( GRPOReceipt.getItemCode().getCodeDesc());
					itemMarge.append("</p>");
				
					itemQty.append("<p>");
					itemQty.append( "" + GRPOReceipt.getInwardQty() + " "+GRPOReceipt.getUnit().getUnitName());
					itemQty.append("</p>");
					
					
				
				}
				stockRow.add(itemMarge.toString());
				stockRow.add(itemQty.toString());
				stockRow.add(Util.getDateString(grpo.getGrDate(), "dd/MM/yyyy"));
				stockRow.add( grpo.getAddedBy().getUserName());
				//stockRow.add(grpo.getApprovalStatus().equalsIgnoreCase("Y")?"Approved":"Rejected");
				
				stockRow.add( Util.getDateString(grpo.getApprovalDate(), "dd/MM/yyyy"));
				strMap.put(String.valueOf(count), stockRow);
				}
			}
				}
			}
		}
		Util.doWriteFlexi(request, response, strMap, requestParams);
		logger.info("exiting getGRPOListApprovalCompleted");

	}
	
	@RequestMapping(value = { "/getGRPOListRejectionCompleted" }, method = { RequestMethod.POST })
	public void getGRPOListRejectionCompleted(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		FlexiBean requestParams = new FlexiBean(request);
		logger.info("entering getGRPOListApprovalCompleted");
		List<GRPO> grpos = grpoService.getGRPOList(requestParams);
		User currentUser =((User) request.getSession().getAttribute("_SessionUser"));
		List<String> stockRow = null;
		Map<String, List<String>> strMap = new LinkedHashMap<String, List<String>>();
		if (!CollectionUtils.isEmpty(grpos)) {
			int count = 0;
			for (GRPO grpo : grpos) {
				for(Warehouse warehouse:currentUser.getUserWarehouses()){
					if(warehouse.getWareId().intValue() == grpo.getWarehouse().getWareId().intValue()){
				
				if(grpo.getApprovalStatus()==null){
					continue;
				}
				if(grpo.getApprovalStatus().equalsIgnoreCase("R")){

					//if(!currentUser.getUserWarehouses().contains(grpo.getWarehouse())){
						//continue;
				//	}
				stockRow = new LinkedList<String>();
				
				//Code itemCode = grpo.getItemCode();
				Warehouse itemWareHouse = grpo.getOrderId().getWarehouse();
				stockRow.add("<input type='radio' name='grpo_id' value='"
						+ grpo.getGrpoId()+ "'>");
				stockRow.add(String.valueOf(++count));
				stockRow.add(grpo.getGoodsRecieptNo());
				
				stockRow.add(masterservice.getFirmById((itemWareHouse.getFirmId())+"").getFirmName());
				StringBuilder itemMarge = new StringBuilder();
				StringBuilder itemQty = new StringBuilder();
				
				
				for (GRPOReceiptEntry GRPOReceipt : grpo.getGrpoReceiptItems()){
					itemMarge.append("<p>");
					itemMarge.append( GRPOReceipt.getItemCode().getCodeDesc());
					itemMarge.append("</p>");
				
					itemQty.append("<p>");
					itemQty.append( "" + GRPOReceipt.getInwardQty() + " "+GRPOReceipt.getUnit().getUnitName());
					itemQty.append("</p>");
					
							
				}
				stockRow.add(itemMarge.toString());
				stockRow.add(itemQty.toString());
				stockRow.add(Util.getDateString(grpo.getGrDate(), "dd/MM/yyyy"));
				stockRow.add(grpo.getApprovalStatus().equalsIgnoreCase("Y")?"Approved":"Rejected");
				stockRow.add( grpo.getAddedBy().getUserName());
				stockRow.add( grpo.getRejectionComments());
				
				stockRow.add( Util.getDateString(grpo.getApprovalDate(), "dd/MM/yyyy"));
				strMap.put(String.valueOf(count), stockRow);
				}
			}
				}
			}
		}
		Util.doWriteFlexi(request, response, strMap, requestParams);
		logger.info("exiting getGRPOListApprovalCompleted");

	}

}
