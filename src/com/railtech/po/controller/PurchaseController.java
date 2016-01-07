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
import com.railtech.po.entity.ModelForm;
import com.railtech.po.entity.Procurement;
import com.railtech.po.entity.PurchaseOrder;
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
	
	@RequestMapping(value = { "/generatePurchaseOrderNo" }, method = { RequestMethod.POST })
	public @ResponseBody String generatePurchaseOrderNo(@RequestBody ModelForm modelRequest)
	{
		String purchaseOrderNo = purchaseService.generatePurchaseOrderNo(modelRequest.getId());
		return purchaseOrderNo;
	}
	
	@RequestMapping(value = { "/deletePurchaseOrder" }, method = { RequestMethod.POST })
	public  @ResponseBody String deleteRequisition(@RequestBody ModelForm modelRequest)
	{
		PurchaseOrder order = purchaseService.getOrderById(Integer.parseInt(modelRequest.getId()));
		purchaseService.delete(order);
		logger.debug("successfully deleted the purchase order");
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

		if (!StringUtils.isEmpty(orderId)) {
			purchase = purchaseService.getOrderById(Integer
					.parseInt(orderId));
		} else {
			purchase = new PurchaseOrder();
		}
		String itemCodeId = request.getParameter("item");

		Integer codeId = Integer.parseInt(itemCodeId.trim());

		Code itemCode = masterservice.getCodeById(codeId);
	//	purchase.setItemCode(itemCode);
		
		String warehouseId = request.getParameter("warehouse");
		
		if(!StringUtils.isEmpty(warehouseId)){
			Warehouse warehouse = masterservice.getWareHouseById(warehouseId);
			purchase.setWarehouse(warehouse);
		}
		
		String markingId = request.getParameter("marking_id");
		
		if((!StringUtils.isEmpty(markingId))){
			Procurement procurementMarking = procurementService.getProcurementById(Integer.parseInt(markingId));
		//	purchase.setProcurementMarking(procurementMarking);
		}
		
		String firmId = request.getParameter("firm");
		Firm firm = masterservice.getFirmById(firmId);
		purchase.setFirm(firm);

		String vendorId = request.getParameter("vendor");
		if(vendorId!=null){
			Vendor vendor = masterservice.getVendorById(vendorId);
			purchase.setVendor(vendor);
		}
		
		
		// User requestedByUser =((User)
		// request.getSession().getAttribute("_SessionUser"));
		User requestedByUser = masterservice.getUserById("27");
		purchase.setAddedBy(requestedByUser);
		purchase.setDateAdded(new Date());

		//purchase.setOrderQty(Double.parseDouble(request
			//	.getParameter("qty")));
		Integer unitId = Integer.parseInt(request.getParameter("unit"));

		Unit itemUnit = masterservice.getUnitById(unitId);
		//purchase.setUnit(itemUnit);
		
		purchase.setOrderType(request.getParameter("orderType"));
		
		//purchase.setRate(Double.parseDouble(request.getParameter("rate")));
		
		purchase.setDueDate(Util.getDate(request.getParameter("dueDate"),
				"dd/MM/yyyy"));
		purchase.setPurchaseOrderNo(request.getParameter("orderNo"));
		purchase.setRemarks(request.getParameter("orderRemarks"));
		
		purchaseService.savePurchaseOrder(purchase);

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
				
			//	Code itemCode = order.getItemCode();
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
				strMap.put(String.valueOf(count), stockRow);
			}
		}
		Util.doWriteFlexi(request, response, strMap, requestParams);
		logger.info("exiting getPurchaseOrderList");

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
				if(order.getApprovalStatus()==null){
					continue;
				}
				stockRow = new LinkedList<String>();
			//	Code itemCode = order.getItemCode();
				Warehouse itemWareHouse = order.getWarehouse();

				stockRow.add("<input type='radio' name='order_id' value='"
						+ order.getOrderId()+ "'>");
				stockRow.add(String.valueOf(++count));
				stockRow.add(order.getPurchaseOrderNo());
				stockRow.add(order.getFirm().getFirmName());
				//stockRow.add(itemCode.getCodeDesc());
				//stockRow.add(order.getOrderQty() + " "+order.getUnit().getUnitName());
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

		List<String> stockRow = null;
		Map<String, List<String>> strMap = new LinkedHashMap<String, List<String>>();
		if (!CollectionUtils.isEmpty(procurementMarkings)) {
			int count = 0;
			for (Procurement marking : procurementMarkings) {
				if(marking.getProcurementType().equalsIgnoreCase("Purchase Order"))
				{
				stockRow = new LinkedList<String>();
				
				Code itemCode = marking.getItemCode();
				Warehouse itemWareHouse = marking.getWarehouse();

				stockRow.add("<input type='radio' name='marking_id' value='"
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
				
				Code itemCode = marking.getItemCode();
				Warehouse itemWareHouse = marking.getWarehouse();

				stockRow.add("<input type='radio' name='marking_id' value='"
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
				
				Code itemCode = marking.getItemCode();
				Warehouse itemWareHouse = marking.getWarehouse();

				stockRow.add("<input type='radio' name='marking_id' value='"
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

}
