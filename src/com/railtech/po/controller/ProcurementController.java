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
import com.railtech.po.entity.ItemStock;
import com.railtech.po.entity.ItemStockPK;
import com.railtech.po.entity.ModelForm;
import com.railtech.po.entity.Procurement;
import com.railtech.po.entity.Unit;
import com.railtech.po.entity.User;
import com.railtech.po.entity.Warehouse;
import com.railtech.po.service.MasterInfoService;
import com.railtech.po.service.ProcurementService;
import com.railtech.po.service.RequisitionService;
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
	ProcurementService procurementService;

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
		procurement.setItemCode(itemCode);
		String warehouseId = request.getParameter("warehouse");
		Warehouse warehouse = masterservice.getWareHouseById(warehouseId);
		procurement.setWarehouse(warehouse);

		// User requestedByUser =((User)
		// request.getSession().getAttribute("_SessionUser"));
		User requestedByUser = masterservice.getUserById("27");
		procurement.setMarkedBy(requestedByUser);
		procurement.setMarkingDate(new Date());

		procurement.setProcurementQty(Double.parseDouble(request
				.getParameter("qty")));
		Integer unitId = Integer.parseInt(request.getParameter("unit"));

		Unit itemUnit = masterservice.getUnitById(unitId);
		procurement.setUnit(itemUnit);
		procurement.setProcurementType(request.getParameter("procurementType"));
		procurement.setDueDate(Util.getDate(request.getParameter("dueDate"),
				"dd/MM/yyyy"));
		procurementService.saveProcurementMarking(procurement);

	}

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
	
	
	@RequestMapping(value = { "/getProcurementMarkingList" }, method = { RequestMethod.POST })
	public void getProcurementMarkingList(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		FlexiBean requestParams = new FlexiBean(request);
		logger.info("entering getProcurementMarkingList");
		List<Procurement> procurementMarkings = procurementService.getProcurements(requestParams);

		List<String> stockRow = null;
		Map<String, List<String>> strMap = new LinkedHashMap<String, List<String>>();
		if (!CollectionUtils.isEmpty(procurementMarkings)) {
			int count = 0;
			for (Procurement marking : procurementMarkings) {
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
	
}
