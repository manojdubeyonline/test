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
import com.railtech.po.entity.GRPO;
import com.railtech.po.entity.GRPOReceiptEntry;
import com.railtech.po.entity.ItemStock;
import com.railtech.po.entity.ItemStockPK;
import com.railtech.po.entity.ModelForm;
import com.railtech.po.entity.Procurement;
import com.railtech.po.entity.PurchaseOrder;
import com.railtech.po.entity.PurchaseOrderItem;
import com.railtech.po.entity.RateApplied;
import com.railtech.po.entity.Requisition;
import com.railtech.po.entity.RequisitionItem;
import com.railtech.po.entity.StockAllocation;
import com.railtech.po.entity.StockAllocationItem;
import com.railtech.po.entity.Unit;
import com.railtech.po.entity.User;
import com.railtech.po.entity.Vendor;
import com.railtech.po.entity.Warehouse;
import com.railtech.po.entity.WarehouseBorrow;
import com.railtech.po.entity.WarehouseBorrowItem;
import com.railtech.po.service.GRPOService;
import com.railtech.po.service.MasterInfoService;
import com.railtech.po.service.ProcurementService;
import com.railtech.po.service.PurchaseService;
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
RequisitionService requisitionService;

@Autowired
StockService stockService;

@Autowired
MasterInfoService masterservice;

@Autowired
GRPOService grpoService;

@Autowired
PurchaseService purchaseService;


@RequestMapping(value = { "/pendingWarehouse" }, method = { RequestMethod.GET })
public ModelAndView gotoPendingWarehouse(){
	logger.info("moving to pendingWarehouser");
	return new ModelAndView("pendingWarehouse");
	
}

@RequestMapping(value = { "/stockAllocation" }, method = { RequestMethod.GET })
public ModelAndView gotoStockAllocation(){
	logger.info("moving to stockAllocation");
	return new ModelAndView("stockAllocation");
	
}

@RequestMapping(value = { "/generateStockAllocationNo" }, method = { RequestMethod.POST })
public @ResponseBody String generateGoodsRecieptNo(@RequestBody ModelForm modelRequest)
{
	String stockNo = stockService.generateStockAllocationNo(modelRequest.getId());
	return stockNo;
}

@RequestMapping(value = { "/generateWarehouseRefNo" }, method = { RequestMethod.POST })
public  @ResponseBody String generateWarehouseRefNo(@RequestBody ModelForm modelRequest)
{
	String  firmId = modelRequest.getId();
	String warehouseId = modelRequest.getId2();
	
	String warehouseRefNo = stockService.generateWarehouseRefNo(firmId, warehouseId);
	
	return warehouseRefNo;
	
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

			stockRow.add("<input type='checkbox' name='marking_id' id='marking_id' value='"
					+ marking.getMarkingId()+ "' >");
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


@RequestMapping(value = { "/saveStockAllocation" }, method = { RequestMethod.POST })
public void saveStockAllocation(HttpServletRequest request,
		HttpServletResponse response) throws IOException {
		StockAllocation stock = null;
	String stockId = request.getParameter("stockId");
	Boolean isNew = Boolean.FALSE;
	if (!StringUtils.isEmpty(stockId)) {
		stock = stockService.getStockById(Integer
				.parseInt(stockId));
	} else {
		stock = new StockAllocation();
	}
	
	
	String stockNo = request.getParameter("stockNo");
	stock.setStockNo(stockNo);
	
String firmId = request.getParameter("firm");	
	Firm firm = masterservice.getFirmById(firmId);
	stock.setFirm(firm);
	
	stock.setAllocatedDate(Util.getDate(request.getParameter("allocationDate"),
			"dd/MM/yyyy"));
	
	 User requestedByUser =((User)
		request.getSession().getAttribute("_SessionUser"));
		//User requestedByUser = masterservice.getUserById("27");
		stock.setAllocatedBy(requestedByUser);
		
		String grpoId= request.getParameter("grpoId");
		if (!StringUtils.isEmpty(grpoId)) {
		GRPO grpo = grpoService.getGRPOById(Integer
					.parseInt(grpoId));
		stock.setGrpo(grpo);
		}
		
		stock.setStatus("A");;	
	
String orderId = request.getParameter("orderId");
PurchaseOrder purchaseOrder = null;
		if((!StringUtils.isEmpty(orderId))){
			purchaseOrder = purchaseService.getOrderById(Integer.parseInt(orderId));
			stock.setOrder(purchaseOrder);
		}
		
		 String rowCount = request.getParameter("rowid");
	  int maxRows = 0;
	  if(null!=rowCount ){
			maxRows = Integer.parseInt(rowCount);
			}
	  if(isNew || stock.getStockItems() == null){
		  stock.setStockItems(new HashSet<StockAllocationItem>());
		}
	  for(int i=0;i<maxRows;i++){
		  
		  String stockAllocationIdStr = request.getParameter("stockItemId" + i);
			Integer stockItemId = null!=stockAllocationIdStr?Integer.parseInt(stockAllocationIdStr.trim()):null;
			Boolean isFound = Boolean.FALSE;
			StockAllocationItem stockItem = null;
			if(!isNew){
				Iterator <StockAllocationItem>itr = stock.getStockItems().iterator();
				while(itr.hasNext()){
					StockAllocationItem sai = itr.next();
					if(sai.getStockItemId() ==stockItemId){
						isFound = Boolean.TRUE;
						
						stockItem =sai;
						break;
					}
				}
			}
			if(!isFound){
				stockItem = new StockAllocationItem();
			}
		   String grpoRecieptIdStr = request.getParameter("grpoRecieptId"+i);
				if((!StringUtils.isEmpty(grpoRecieptIdStr))){
					GRPOReceiptEntry recieptId = grpoService.getGrpoRecieptById(Integer.parseInt(grpoRecieptIdStr));
					stockItem.setGrpoRecieptId(recieptId);
		          }
			  
				
			  String itemCodeId = request.getParameter("item"+i);
	            Integer codeId = Integer.parseInt(itemCodeId.trim());
	            Code itemCode = masterservice.getCodeById(codeId);
	            stockItem.setAllocatedItem(itemCode);
	            
	            String Qty = request.getParameter("allocation_Qty"+i).trim();
	            stockItem.setAllocatedQty(Float.parseFloat(Qty));
	            ItemStock its = null;
				Integer unitId = Integer.parseInt(request.getParameter("unit"+i));
	            Unit itemUnit = masterservice.getUnitById(unitId);
	            stockItem.setUnit(itemUnit);
	            stockItem.setStockId(stock);
	            Double availQty = 0.0;
	            Integer wareId = purchaseOrder.getWarehouse().getWareId();
	            Warehouse warehouse = masterservice.getWareHouseById(wareId+"");
	            its = requisitionService.getItemStock(itemCode.getCodeId()+"",""+wareId);
	            if(its  != null){
                   availQty = its.getAvailableQty();
                   its.setAvailableQty(availQty + Double.parseDouble(Qty));
	            }
	            else{
	            	its = new ItemStock();
	            	ItemStockPK itemStockPK = new ItemStockPK();
	            	itemStockPK.setItemCode(itemCode);
	            	itemStockPK.setWarehouse(warehouse);
	            	
	            	its.setItemStockPK(itemStockPK);
	            	its.setAvailableQty(Double.parseDouble(Qty));
	            
	            }
	           
	            requisitionService.updateItemStock(its);
		   
			if(!isFound){
				stock.getStockItems().add(stockItem);
			}
			
	  }
	  
		stockService.saveStockAllocation(stock);

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
	//borrow.setUnit(itemUnit);
	//borrow.setItemCode(itemCode);
	
	//borrow.setBorrowQty(Double.parseDouble(request.getParameter("qty"
		//	+ i).trim()));
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

	User requestedByUser =((User) request.getSession().getAttribute("_SessionUser"));
	//User requestedByUser = masterservice.getUserById("27");
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
	Boolean isNew = Boolean.FALSE;
	String borrowId = request.getParameter("borrowId");

	if (!StringUtils.isEmpty(borrowId)) {
		
		borrow = stockService.getWarehouseBorrowById(Integer
				.parseInt(borrowId));
	}
	else {
		borrow = new WarehouseBorrow();
		isNew = Boolean.TRUE;
	}
	
		
	borrow.setWarehouseRefNo(request.getParameter("warehouseRefNo"));
	
	String fromWarehouseId = request.getParameter("fromWarehouse");
	String toWarehouseId = request.getParameter("warehouseId");
	
	if(!StringUtils.isEmpty(fromWarehouseId)){
		Warehouse fromWarehouse = masterservice.getWareHouseById(fromWarehouseId);
		borrow.setFromWarehouse(fromWarehouse);
	}	
	Warehouse toWarehouse = null;
	if(!StringUtils.isEmpty(toWarehouseId)){
		toWarehouse = masterservice.getWareHouseById(toWarehouseId);
		borrow.setToWarehouse(toWarehouse);
	}	
	
	String fromFirmId = request.getParameter("fromFirm");
	String toFirmId = request.getParameter("firmId");
	
	Firm fromFirm = masterservice.getFirmById(fromFirmId);
	borrow.setFromFirm(fromFirm);
	
	Firm toFirm = masterservice.getFirmById(toFirmId);
	borrow.setToFirm(toFirm);
	
	borrow.setStatus(request.getParameter("status"));
	
	String requisitionId = request.getParameter("requisitionId");
	Requisition requisition = null;
	if((!StringUtils.isEmpty(requisitionId))){
		requisition = requisitionService.getRequisitionById(Long.parseLong(requisitionId.trim()));
		borrow.setRequisition(requisition);
		
	}
	
	borrow.setRemarks(request.getParameter("remaks"));

	//String itemCodeId = request.getParameter("itemCode");

	//Integer codeId = Integer.parseInt(itemCodeId.trim());

	//Integer unitId = Integer.parseInt(request.getParameter("unit").trim());

	//Code itemCode = masterservice.getCodeById(codeId);
	//Unit itemUnit = masterservice.getUnitById(unitId);
	//borrow.setUnit(itemUnit);
	//borrow.setItemCode(itemCode);
	
	User requestedByUser =((User) request.getSession().getAttribute("_SessionUser"));
	//User requestedByUser = masterservice.getUserById("27");
	borrow.setAddedBy(requestedByUser);
	
	borrow.setBorrowDueDate(Util.getDate(request.getParameter("dueDate"),
			"dd/MM/yyyy"));
	
	borrow.setDateBorrow(new Date());
	
	String rowCount = request.getParameter("rowhid");
	 int maxRows = 0;
	 if(null!=rowCount ){
			maxRows = Integer.parseInt(rowCount);
			}
	 
	 if(isNew || borrow.getWarehouseBorrowItem() ==null){
		 borrow.setWarehouseBorrowItem(new LinkedList<WarehouseBorrowItem>());
		}
	 
	 WarehouseBorrowItem wareBorrowItem = null;
	 for(int i=0;i<maxRows;i++){
		
			String borrowItemIdStr = request.getParameter("borrowItemId" + i);
			Integer borrowItemId = null!=borrowItemIdStr?Integer.parseInt(borrowItemIdStr.trim()):null;
			Boolean isFound = Boolean.FALSE;
			
			if(!isNew){
				Iterator <WarehouseBorrowItem>itr = borrow.getWarehouseBorrowItem().iterator();
				while(itr.hasNext()){
					WarehouseBorrowItem wbi = itr.next();
					if(wbi.getBorrowItemId() ==borrowItemId){
						isFound = Boolean.TRUE;
						
						wareBorrowItem =wbi;
						break;
					}
				}
			}
			if(!isFound){
				wareBorrowItem = new WarehouseBorrowItem();
				
	 }
			
			String itemCodeId = request.getParameter("item"+i);
            Integer codeId = Integer.parseInt(itemCodeId.trim());	
			Code itemCode = masterservice.getCodeById(codeId);
			wareBorrowItem.setItemCode(itemCode);
			
			String Qty = request.getParameter("qty"+i);
			wareBorrowItem.setBorrowQty(Double.parseDouble(Qty.trim()));
			
			Integer unitId = Integer.parseInt(request.getParameter("unit"+i).trim());
			Unit itemUnit = masterservice.getUnitById(unitId);
			wareBorrowItem.setUnit(itemUnit);
			
			wareBorrowItem.setWarehouseBorrow(borrow);
			wareBorrowItem.setRequisition(requisition);
			
			 String requisitionItemId = request.getParameter("requisitionItem_id"+i);
			if((!StringUtils.isEmpty(requisitionItemId))){
					RequisitionItem  requisitionItem = requisitionService.getRequisitionItemById(Long.parseLong(requisitionItemId.trim()));
					wareBorrowItem.setRequisitionItem(requisitionItem);
				}
			
            String markingId = request.getParameter("marking_id"+i);
			if((!StringUtils.isEmpty(markingId))){
				Integer markId =  Integer.parseInt(markingId.trim());
				Procurement procurementMarking = procurementService.getProcurementById(markId);
				wareBorrowItem.setProcurement(procurementMarking);
			}
			
			User modifiedByUser =((User)request.getSession().getAttribute("_SessionUser"));
			//User requestedByUser = masterservice.getUserById("27");
			wareBorrowItem.setModifiedByUser(modifiedByUser);
			
			
			if(!isFound){
				borrow.getWarehouseBorrowItem().add(wareBorrowItem);
			}
	
	
	 ItemStock its = null;
	 Double availQty = 0.0;
   
    // its = requisitionService.getItemStock(itemCodeId,toWarehouseId);
     if(its  != null){
        availQty = its.getAvailableQty();
       // its.setAvailableQty(availQty + Double.parseDouble(Qty));
     }
     else{
     	its = new ItemStock();
     	ItemStockPK itemStockPK = new ItemStockPK();
     	//itemStockPK.setItemCode(itemCode);
     	itemStockPK.setWarehouse(toWarehouse);
     	
     	its.setItemStockPK(itemStockPK);
     	//its.setAvailableQty(Double.parseDouble(Qty));
     
     }
    //its.setModifiedBy(requestedByUser.getUserId());
    // requisitionService.updateItemStock(its);
     
	 }
	
	stockService.saveWarehouseBorrow(borrow);

}


@RequestMapping(value = { "/getWarehouseBorrowList" }, method = { RequestMethod.POST })
public void getWarehouseBorrowList(HttpServletRequest request,
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
			
			//Code itemCode = borrow.getItemCode();
			//Warehouse itemWareHouse = borrow.getWarehouse();

			stockRow.add("<input type='radio' name='borrow_id' value='"
					+  borrow.getBorrowId()+ "'>");
			stockRow.add(String.valueOf(++count));
			//stockRow.add(borrow.getPurchaseOrderNo());
			stockRow.add(borrow.getFromFirm().getFirmName());
			stockRow.add(borrow.getToFirm().getFirmName());
			//stockRow.add(itemCode.getCodeDesc());
			//stockRow.add("" + borrow.getBorrowQty() + " "+borrow.getUnit().getUnitName());
			stockRow.add("" + Util.getDateString(borrow.getBorrowDueDate(), "dd/MM/yyyy"));
			stockRow.add(borrow.getFromWarehouse().getWarehouseName());
			stockRow.add(borrow.getToWarehouse().getWarehouseName());
			strMap.put(String.valueOf(count), stockRow);
		}
	}
	Util.doWriteFlexi(request, response, strMap, requestParams);
	logger.info("exiting getWarehouseBorrowList");
}

@RequestMapping(value = { "/getStockAllocationList" }, method = { RequestMethod.POST })
public void getStockAllocationList(HttpServletRequest request,
		HttpServletResponse response) throws IOException {
	FlexiBean requestParams = new FlexiBean(request);
	logger.info("entering getStockAllocationList");
	List<StockAllocation> stockAllocation = stockService.getAllocationList(requestParams);

	List<String> stockRow = null;
	Map<String, List<String>> strMap = new LinkedHashMap<String, List<String>>();
	if (!CollectionUtils.isEmpty(stockAllocation)) {
		int count = 0;
		
		for (StockAllocation stock : stockAllocation) {
			
			if(stock.getStatus() == null){
				continue;
			}
			stockRow = new LinkedList<String>();
			
			//Code itemCode = stock.getAllocatedItem();
			

			stockRow.add("<input type='radio' name='stock_id' value='"
					+  stock.getStockId()+ "'>");
			stockRow.add(String.valueOf(++count));
			stockRow.add(stock.getStockNo());
			stockRow.add(stock.getFirm().getFirmName());
			StringBuilder itemMarge = new StringBuilder();
			StringBuilder itemQty = new StringBuilder();
			
			
			for (StockAllocationItem allocationItem : stock.getStockItems()){
				itemMarge.append("<p>");
				itemMarge.append( allocationItem.getAllocatedItem().getCodeDesc());
				itemMarge.append("</p>");
			
				itemQty.append("<p>");
				itemQty.append( "" + allocationItem.getAllocatedQty() + " "+allocationItem.getUnit().getUnitName());
				itemQty.append("</p>");
				
				}
			stockRow.add(itemMarge.toString());
			stockRow.add(itemQty.toString());
			
			stockRow.add("" + Util.getDateString(stock.getAllocatedDate(), "dd/MM/yyyy"));
			stockRow.add("" + Util.getDateString(stock.getGrpo().getGrDate(), "dd/MM/yyyy"));
			
			stockRow.add(stock.getAllocatedBy().getUserName());
			strMap.put(String.valueOf(count), stockRow);
		}
	}
	Util.doWriteFlexi(request, response, strMap, requestParams);
	logger.info("exiting getStockAllocationList");
}

@RequestMapping(value = { "/getBorrowById" }, method = { RequestMethod.POST })
public @ResponseBody WarehouseBorrow getBorrowById(@RequestBody ModelForm modelRequest)
{
	WarehouseBorrow borrow = stockService.getWarehouseBorrowById(Integer.parseInt(modelRequest.getId()));
	return borrow;
}

@RequestMapping(value = { "/getStockAllocationById" }, method = { RequestMethod.POST })
public @ResponseBody StockAllocation getStockAllocationById(@RequestBody ModelForm modelRequest)
{
	StockAllocation stock = stockService.getStockById(Integer.parseInt(modelRequest.getId()));
	return stock;
}

}
