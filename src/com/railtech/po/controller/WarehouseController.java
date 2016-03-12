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

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.railtech.po.entity.Code;
import com.railtech.po.entity.Firm;
import com.railtech.po.entity.FlexiBean;
import com.railtech.po.entity.ItemStock;
import com.railtech.po.entity.ItemStockPK;
import com.railtech.po.entity.ModelForm;
import com.railtech.po.entity.Procurement;
import com.railtech.po.entity.PurchaseOrder;
import com.railtech.po.entity.Requisition;
import com.railtech.po.entity.RequisitionItem;
import com.railtech.po.entity.Unit;
import com.railtech.po.entity.User;
import com.railtech.po.entity.Vendor;
import com.railtech.po.entity.Warehouse;
import com.railtech.po.entity.WarehouseBorrow;
import com.railtech.po.service.MasterInfoService;
import com.railtech.po.service.ProcurementService;
import com.railtech.po.service.RequisitionService;
import com.railtech.po.service.StockService;
import com.railtech.po.util.Util;


@SuppressWarnings("unused")
@Controller
public class WarehouseController {
private static Logger logger = Logger
			.getLogger(WarehouseController.class);	

@Autowired
ProcurementService procurementService;

@Autowired
StockService stockService;

@Autowired
MasterInfoService masterservice;


@RequestMapping(value = { "/pendingWarehouse" }, method = { RequestMethod.GET })
public ModelAndView gotoPendingWarehouse(){
	logger.info("moving to pendingWarehouser");
	return new ModelAndView("pendingWarehouse");
	
}


@RequestMapping(value = { "/getPendingWarehouseList" }, method = { RequestMethod.POST })
public void getPendingWarehouseList(HttpServletRequest request,
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
			
			Code itemCode = marking.getRequisitionItemId().getItemCode();
			Warehouse itemWareHouse = marking.getWarehouse();

			stockRow.add("<input type='radio' name='marking_id' value='"
					+ marking.getMarkingId()+ "'>");
			stockRow.add(String.valueOf(++count));
			stockRow.add(itemWareHouse.getWarehouseName());
			stockRow.add(itemCode.getCodeDesc());
			
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

@RequestMapping(value = { "/saveWarehouseBorrowDirect" }, method = { RequestMethod.POST })
public void saveWarehouseBorrowDirect(HttpServletRequest request,
		HttpServletResponse response) throws IOException {
	WarehouseBorrow borrow = null;
	
	String borrowId = request.getParameter("borrowId");

	if (!StringUtils.isEmpty(borrowId)) {
		
		borrow = stockService.getWarehouseBorrowById(Integer
				.parseInt(borrowId));
	} else {
		borrow = new WarehouseBorrow();
	}
	
	String rowCount = request.getParameter("rowhid");
	int maxRows = 0;
	
	if(null!=rowCount){
		maxRows = Integer.parseInt(rowCount);
	}
	for (int i = 0; i < maxRows; i++) {
		String itemCodeId = request.getParameter("codeId" + i);
		if (itemCodeId != null) {
	
	Integer unitId = Integer.parseInt(request.getParameter("unit"+ i).trim());

	Integer codeId = Integer.parseInt(itemCodeId.trim());

	Code itemCode = masterservice.getCodeById(codeId);
	Unit itemUnit = masterservice.getUnitById(unitId);
	borrow.setUnit(itemUnit);
	borrow.setItemCode(itemCode);
	
	borrow.setBorrowQty(Double.parseDouble(request.getParameter("qty"
			+ i).trim()));
		}
	}
	String fromWarehouseId = request.getParameter("warehouse");
	String toWarehouseId = request.getParameter("receiverwarehouse");
	
	if(!StringUtils.isEmpty(fromWarehouseId)){
		Warehouse fromWarehouse = masterservice.getWareHouseById(fromWarehouseId);
		borrow.setFromWarehouse(fromWarehouse);
	}	
	
	if(!StringUtils.isEmpty(toWarehouseId)){
		Warehouse toWarehouse = masterservice.getWareHouseById(toWarehouseId);
		borrow.setToWarehouse(toWarehouse);
	}	
	
	String fromFirmId = request.getParameter("firm");
	String toFirmId = request.getParameter("receiverFirm");
	
	Firm fromFirm = masterservice.getFirmById(fromFirmId);
	borrow.setFromFirm(fromFirm);
	
	Firm toFirm = masterservice.getFirmById(toFirmId);
	borrow.setToFirm(toFirm);

	
	User requestedByUser = masterservice.getUserById("27");
	borrow.setAddedBy(requestedByUser);
	
	borrow.setBorrowDueDate(Util.getDate(request.getParameter("borrowApprovalDate"),
			"dd/MM/yyyy"));
	
	borrow.setStatus(request.getParameter("status"));
	
	borrow.setDateBorrow(new Date());
	
	stockService.saveWarehouseBorrow(borrow);

}

@RequestMapping(value = { "/saveWarehouseBorrow" }, method = { RequestMethod.POST })
public void saveWarehouseBorrow(HttpServletRequest request,
		HttpServletResponse response) throws IOException {
	WarehouseBorrow borrow = null;
	
	String borrowId = request.getParameter("borrowId");

	if (!StringUtils.isEmpty(borrowId)) {
		
		borrow = stockService.getWarehouseBorrowById(Integer
				.parseInt(borrowId));
	} else {
		borrow = new WarehouseBorrow();
	}
	
	
	
	borrow.setBorrowQty(Double.parseDouble(request.getParameter("qty"
			).trim()));
		
	
	String fromWarehouseId = request.getParameter("fromWarehouse");
	String toWarehouseId = request.getParameter("warehouse2");
	
	if(!StringUtils.isEmpty(fromWarehouseId)){
		Warehouse fromWarehouse = masterservice.getWareHouseById(fromWarehouseId);
		borrow.setFromWarehouse(fromWarehouse);
	}	
	
	if(!StringUtils.isEmpty(toWarehouseId)){
		Warehouse toWarehouse = masterservice.getWareHouseById(toWarehouseId);
		borrow.setToWarehouse(toWarehouse);
	}	
	
	String fromFirmId = request.getParameter("fromFirm");
	String toFirmId = request.getParameter("firm2");
	
	Firm fromFirm = masterservice.getFirmById(fromFirmId);
	borrow.setFromFirm(fromFirm);
	
	Firm toFirm = masterservice.getFirmById(toFirmId);
	borrow.setToFirm(toFirm);

	String itemCodeId = request.getParameter("itemCode");

	Integer codeId = Integer.parseInt(itemCodeId.trim());


		
	
	Integer unitId = Integer.parseInt(request.getParameter("unit").trim());

	

	Code itemCode = masterservice.getCodeById(codeId);
	Unit itemUnit = masterservice.getUnitById(unitId);
	borrow.setUnit(itemUnit);
	borrow.setItemCode(itemCode);
	
	User requestedByUser = masterservice.getUserById("27");
	borrow.setAddedBy(requestedByUser);
	
	borrow.setBorrowDueDate(Util.getDate(request.getParameter("dueDate"),
			"dd/MM/yyyy"));
	
	borrow.setStatus(request.getParameter("status"));
	
	borrow.setDateBorrow(new Date());
	
	stockService.saveWarehouseBorrow(borrow);

}


@RequestMapping(value = { "/getWarehouseBorrowList" }, method = { RequestMethod.POST })
public void getPurchaseOrderList(HttpServletRequest request,
		HttpServletResponse response) throws IOException {
	FlexiBean requestParams = new FlexiBean(request);
	logger.info("entering getWarehouseBorrowList");
	List<WarehouseBorrow> borrows = stockService.getBorrowList(requestParams);

	List<String> stockRow = null;
	Map<String, List<String>> strMap = new LinkedHashMap<String, List<String>>();
	if (!CollectionUtils.isEmpty(borrows)) {
		int count = 0;
		
		for (WarehouseBorrow borrow : borrows) {
			stockRow = new LinkedList<String>();
			
			Code itemCode = borrow.getItemCode();
			//Warehouse itemWareHouse = borrow.getWarehouse();

			stockRow.add("<input type='radio' name='borrow_id' value='"
					+  borrow.getBorrowId()+ "'>");
			stockRow.add(String.valueOf(++count));
			//stockRow.add(borrow.getPurchaseOrderNo());
			stockRow.add(borrow.getFromFirm().getFirmName());
			stockRow.add(borrow.getToFirm().getFirmName());
			stockRow.add(itemCode.getCodeDesc());
			stockRow.add("" + borrow.getBorrowQty() + " "+borrow.getUnit().getUnitName());
			stockRow.add("" + Util.getDateString(borrow.getBorrowDueDate(), "dd/MM/yyyy"));
			stockRow.add(borrow.getFromWarehouse().getWarehouseName());
			stockRow.add(borrow.getToWarehouse().getWarehouseName());
			strMap.put(String.valueOf(count), stockRow);
		}
	}
	Util.doWriteFlexi(request, response, strMap, requestParams);
	logger.info("exiting getWarehouseBorrowList");
}

@RequestMapping(value = { "/getBorrowById" }, method = { RequestMethod.POST })
public @ResponseBody WarehouseBorrow getBorrowById(@RequestBody ModelForm modelRequest)
{
	WarehouseBorrow borrow = stockService.getWarehouseBorrowById(Integer.parseInt(modelRequest.getId()));
	return borrow;
}

}
