/**
 * 
 */
package com.railtech.po.controller;

import java.io.IOException;
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
import com.railtech.po.entity.ItemIssue;
import com.railtech.po.entity.ItemStock;
import com.railtech.po.entity.ItemStockPK;
import com.railtech.po.entity.ModelForm;
import com.railtech.po.entity.Procurement;
import com.railtech.po.entity.PurchaseOrderItem;
import com.railtech.po.entity.Requisition;
import com.railtech.po.entity.RequisitionItem;
import com.railtech.po.entity.Unit;
import com.railtech.po.entity.User;
import com.railtech.po.entity.Warehouse;
import com.railtech.po.service.MasterInfoService;
import com.railtech.po.service.ProcurementService;
import com.railtech.po.service.PurchaseService;
import com.railtech.po.service.RequisitionService;
import com.railtech.po.service.StockService;
import com.railtech.po.util.POConstants;
import com.railtech.po.util.Util;

/**
 * @author MANOJ
 *
 */
@Controller
public class ProcurementController {
	private static Logger logger = Logger
			.getLogger(ProcurementController.class);

	@Autowired
	RequisitionService requisitionService;
	
	@Autowired
	PurchaseService purchaseService;

	@Autowired
	ProcurementService procurementService;
	
	@Autowired
	StockService stockService;

	@Autowired
	MasterInfoService masterservice;

	@RequestMapping(value = { "/pendingPurchaseMarking" }, method = { RequestMethod.GET })
	public ModelAndView pendingMarking() {
		return new ModelAndView("pendingPurchaseMarking");
	}

	@RequestMapping(value = { "/saveProcurement" }, method = { RequestMethod.POST })
	public void saveProcurement(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		Procurement procurement = null;
		String markingId = request.getParameter("procurementMarkingId");

		if (!StringUtils.isEmpty(markingId)) {
			procurement = procurementService.getProcurementById(Integer
					.parseInt(markingId));
		} else {
			procurement = new Procurement();
		}
		String itemCodeId = request.getParameter("item");

		Integer codeId = Integer.parseInt(itemCodeId.trim());

		Code itemCode = masterservice.getCodeById(codeId);
		//procurement.setItemCode(itemCode);
		String warehouseId = request.getParameter("warehouse");
		Warehouse warehouse = masterservice.getWareHouseById(warehouseId);
		procurement.setWarehouse(warehouse);
		String requisitionItemId= request.getParameter("associatedRequisitionItemId");
		RequisitionItem requisitionItem = requisitionService.getRequisitionItemById(Long.parseLong(requisitionItemId));
		procurement.setRequisitionItemId(requisitionItem);
		
		String requisition= request.getParameter("associatedRequisitionId");
		Requisition requisitionId = requisitionService.getRequisitionById(Long.parseLong(requisition));
		procurement.setReqId(requisitionId);
		
		// User requestedByUser =((User)
		// request.getSession().getAttribute("_SessionUser"));
		//User requestedByUser =((User) request.getSession().getAttribute("_SessionUser"));
		User requestedByUser =((User) request.getSession().getAttribute("_SessionUser"));
		//User requestedByUser = masterservice.getUserById("27");
		procurement.setMarkedBy(requestedByUser);
		procurement.setMarkingDate(new Date());

		Double qty = Double.parseDouble(request
				.getParameter("qty"));
		procurement.setProcurementQty(qty);
		Integer unitId = Integer.parseInt(request.getParameter("unit"));

		Unit itemUnit = masterservice.getUnitById(unitId);
		procurement.setUnit(itemUnit);
		procurement.setProcurementType(request.getParameter("procurementType"));
	
		procurement.setDueDate(Util.getDate(request.getParameter("dueDate"),
				"dd/MM/yyyy"));
		
		List<Procurement> Procur = procurementService.getProcurementQtyByReqItemId(Integer.parseInt(requisitionItemId));
		 
		 Double proQty = 0.0;
		 if(Procur != null){
		 for(Procurement Pro: Procur){
			 proQty = proQty + Pro.getProcurementQty(); 
		 }
		 }
		 requisitionId.setCurrentStatus(requisitionItem.getQty() == (proQty+qty)?POConstants.STATUS_MARKED:POConstants.STATUS_PART_MARKED);
		 requisitionService.saveOrUpdate(requisitionId,true);
		
		procurementService.saveProcurementMarking(procurement);

	}
/*
	@RequestMapping(value = { "/getPendingProcurementMarkingList" }, method = { RequestMethod.POST })
	public void getPendingProcurementMarkingList(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		FlexiBean requestParams = new FlexiBean(request);
		logger.info("entering getPendingProcurementMarkingList");
		Set<ItemStock> stocks = procurementService.getStockList(requestParams);

		List<String> stockRow = null;
		Map<String, List<String>> strMap = new LinkedHashMap<String, List<String>>();
		if (!CollectionUtils.isEmpty(stocks)) {
			int count = 0;
			for (ItemStock stock : stocks) {
				stockRow = new LinkedList<String>();
				ItemStockPK pk = stock.getItemStockPK();
				Code itemCode = pk.getItemCode();
				Warehouse itemWareHouse = pk.getWarehouse();

				stockRow.add("<input type='radio' name='procurement_item_id' value='"
						+ itemCode.getCodeId()
						+ "_"
						+ itemWareHouse.getWareId() + "'>");
				stockRow.add(String.valueOf(++count));
				stockRow.add(itemCode.getCodeDesc());
				stockRow.add(itemWareHouse.getWarehouseName());
				stockRow.add("" + stock.getRequisitionedQty());
				strMap.put(String.valueOf(count), stockRow);
			}
		}
		Util.doWriteFlexi(request, response, strMap, requestParams);
		logger.info("exiting getPendingProcurementMarkingList");

	}
	*/
	
	@RequestMapping(value = { "/getPendingProcurementMarkingList" }, method = { RequestMethod.POST })
	public void getPendingStockIssue(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		FlexiBean params = new FlexiBean(request);
		List<Requisition> requisitions  = requisitionService.getRequisitions(params);
		List<Procurement> procurementMarkings = procurementService.getProcurements(params);
		Set<ItemIssue> itemIssues  = stockService.getItemIssue(params);
		User currentUser =((User) request.getSession().getAttribute("_SessionUser"));
		List<String> requisitionItemRow = null;
		Map<String, List<String>> strMap = new LinkedHashMap<String, List<String>>();
		if(!CollectionUtils.isEmpty(requisitions)){
			int count = 0;
			double issueQty =  0;
			double procQty =  0;
			double qty =  0;
			for(Requisition requisition: requisitions){
				//if(!currentUser.getUserWarehouses().contains(requisition.getRequestedAtWareHouse())){
					//continue;
				//}
				for(Warehouse warehouse:currentUser.getUserWarehouses()){
					if(warehouse.getWareId().intValue() == requisition.getRequestedAtWareHouse().getWareId().intValue()){
				for (RequisitionItem item : requisition.getRequisitionItems()) {
					//if(item.getCurrentStatus().equalsIgnoreCase("S")){
					//	continue;
					//}
					//if (item.getFullFillmentStatus()==null || item.getFullFillmentStatus().equalsIgnoreCase("N")) {
					procQty = 0;
					for(Procurement procurement: procurementMarkings){
						
						
								if(requisition.getRequisitionId() == procurement.getReqId().getRequisitionId() && item.getItemKey() == procurement.getRequisitionItemId().getItemKey())
							procQty = procQty + procurement.getProcurementQty();
						
					}
					issueQty = 0;
					for(ItemIssue itemIssue: itemIssues){
						
						if(requisition.getRequisitionId() == itemIssue.getRequisition().getRequisitionId() && item.getItemKey() == itemIssue.getRequisitionItem().getItemKey()){
							
							//for(ItemIssue itmIssue:itemIssues){
								if(requisition.getRequisitionId() == itemIssue.getRequisition().getRequisitionId() && item.getItemKey() == itemIssue.getRequisitionItem().getItemKey())	
							issueQty = issueQty + itemIssue.getIssueQty();
						//}
						}
					}
					qty = item.getQty()-(procQty + issueQty);
					if (qty>0) {
						requisitionItemRow = new LinkedList<String>();
						requisitionItemRow
								.add("<input type='radio' name='requisitionItemId' value='"+item.getItemKey()+ "'>");
						requisitionItemRow.add(String.valueOf(++count));
						requisitionItemRow.add(requisition.getRequisitionRefNo());
					
						requisitionItemRow.add(item.getItemCode().getCodeDesc());
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
			}
		}
		Util.doWriteFlexi(request, response, strMap, params);
	}
	
	@RequestMapping(value = { "/getProcurementMarkingList" }, method = { RequestMethod.POST })
	public void getProcurementMarkingList(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		FlexiBean requestParams = new FlexiBean(request);
		logger.info("entering getProcurementMarkingList");
		List<Procurement> procurementMarkings = procurementService.getProcurements(requestParams);
		User currentUser =((User) request.getSession().getAttribute("_SessionUser"));
		List<String> stockRow = null;
		Map<String, List<String>> strMap = new LinkedHashMap<String, List<String>>();
		if (!CollectionUtils.isEmpty(procurementMarkings)) {
			int count = 0;
			for (Procurement marking : procurementMarkings) {
				//if(!currentUser.getUserWarehouses().contains(marking.getWarehouse())){
					//continue;
				//}
				for(Warehouse warehouse:currentUser.getUserWarehouses()){
					
					if(warehouse.getWareId().intValue() == marking.getWarehouse().getWareId().intValue()){
				stockRow = new LinkedList<String>();
				
				Code itemCode = marking.getRequisitionItemId().getItemCode();
				Warehouse itemWareHouse = marking.getWarehouse();

				stockRow.add("<input type='radio' name='marking_id' value='"
						+ marking.getMarkingId()+ "'>");
				stockRow.add(String.valueOf(++count));
				stockRow.add(itemCode.getCodeDesc());
				stockRow.add(itemWareHouse.getWarehouseName());
				stockRow.add("" + marking.getProcurementQty() + " "+marking.getUnit().getUnitName());
				stockRow.add("" + Util.getDateString(marking.getMarkingDate(), "dd/MM/yyyy"));
				stockRow.add("" + marking.getProcurementType());
				strMap.put(String.valueOf(count), stockRow);
			}
		}
			}
		}
		Util.doWriteFlexi(request, response, strMap, requestParams);
		logger.info("exiting getProcurementMarkingList");

	}
	@RequestMapping(value = { "/getProcurementMarkingById" }, method = { RequestMethod.POST })
	public @ResponseBody Procurement getProcurementMarkingById(HttpServletRequest request,
			HttpServletResponse response, @RequestBody ModelForm requestForm) throws IOException {
			logger.info("entering getProcurementMarkingById");
			Procurement procurementMarking = procurementService.getProcurementById(Integer.parseInt(requestForm.getId()));
			logger.info("exiting getProcurementMarkingById");
			return procurementMarking;
	}
	
	@RequestMapping(value = { "/getMultipleProcurementMarkingById" }, method = { RequestMethod.POST })
	public @ResponseBody List<Procurement> getMultipleProcurementMarkingById(HttpServletRequest request,
			HttpServletResponse response, @RequestBody ModelForm requestForm) throws IOException {
			logger.info("entering getMultipleProcurementMarkingById");
			List<Procurement> procurementMarking = procurementService.getProcurementByMultipleId(requestForm.getId());
			for(Procurement procurment : procurementMarking){
				List<PurchaseOrderItem> orderItem = purchaseService.getOrderByProcurementId(procurment.getMarkingId());
				Double Qty = 0.0;
				for(PurchaseOrderItem itemlist: orderItem){
					Qty = Qty + itemlist.getQty(); 
				 }
				procurment.setProcurementQty(procurment.getProcurementQty()-Qty);
			}
			logger.info("exiting getMultipleProcurementMarkingById");
			return procurementMarking;
	}
	
}
