/**
 * 
 */
package com.railtech.po.service.impl;


import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.railtech.po.entity.FlexiBean;
import com.railtech.po.entity.GRPO;
import com.railtech.po.entity.ItemIssue;
import com.railtech.po.entity.ItemStock;
import com.railtech.po.entity.Procurement;
import com.railtech.po.entity.PurchaseOrder;
import com.railtech.po.entity.StockAllocation;
import com.railtech.po.entity.Warehouse;
import com.railtech.po.entity.WarehouseBorrow;
import com.railtech.po.exeception.RailtechException;


import com.railtech.po.service.MasterInfoService;
import com.railtech.po.service.StockService;

/**
 * @author MANOJ
 *
 */
@Repository(value = "StockServiceImpl")
@Service
@Transactional
public class StockServiceImpl implements StockService {

	@Resource(name = "sessionFactory")
	private SessionFactory sessionFactory;
	private static Logger logger = Logger
			.getLogger(StockServiceImpl.class);
	
	@Autowired
	MasterInfoService masterInfoService;

	@Override
	public Set<ItemIssue> getItemIssue(FlexiBean requestParams)
			throws RailtechException {
		logger.info("entering getStockIssues");
		Session session = sessionFactory.getCurrentSession();
		Query query = session
				.createQuery("from ItemIssue itemIssue");
		@SuppressWarnings("unchecked")
		Set<ItemIssue> itemIssueList = new HashSet<ItemIssue>(query.list());
		logger.debug("returnVal No of itemIssues:" + itemIssueList);
				logger.info("exiting getStockIssues");
		return itemIssueList;
	}

	@Override
	public WarehouseBorrow getWarehouseBorrowById(Integer borrowId) {
		logger.info("entering getWarehouseBorrowById. Param borrowId:"+borrowId);
		Session session = sessionFactory.getCurrentSession();
		Query query  = session.createQuery("from WarehouseBorrow warehouseBorrow where warehouseBorrow.borrowId=:borrowId").setInteger("borrowId", borrowId);
		WarehouseBorrow borrow = (WarehouseBorrow) query.uniqueResult();
		logger.info("exiting getWarehouseBorrowById. Return val:"+borrow);
		return borrow;
	}

	@Override
	public void saveWarehouseBorrow(WarehouseBorrow borrow) {
		logger.info("entering saveWarehouseBorrow");
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(borrow);
		logger.info("exiting saveWarehouseBorrow");
		
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<WarehouseBorrow> getBorrowList(FlexiBean requestParams) {
		logger.info("entering getBorrowList");
		Session session = sessionFactory.getCurrentSession();
		Query query = session
				.createQuery("from WarehouseBorrow warehouseBorrow");
		
		List<WarehouseBorrow> borrow = new ArrayList<WarehouseBorrow>(
				query.list());
		logger.debug("returnVal of borrow:" + borrow);
		
		logger.info("exiting getBorrowList");
		return borrow;
	}
	
	
	@Override
	@SuppressWarnings("unchecked")
	public List<StockAllocation> getAllocationList(FlexiBean requestParams) {
		logger.info("entering getAllocationList");
		Session session = sessionFactory.getCurrentSession();
		Query query = session
				.createQuery("from StockAllocation stockAllocation");
		
		List<StockAllocation> allocation = new ArrayList<StockAllocation>(
				query.list());
		logger.debug("returnVal of allocation:" + allocation);
		
		logger.info("exiting getAllocationList");
		return allocation;
	}

	@Override
	public List<ItemIssue> getIssuedQtyByReqItemId(Integer requisitionItemId) {
		logger.info("entering getIssuedQtyByReqItemId");
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from ItemIssue itemIssue where itemIssue.requisitionItem.itemKey=:requisitionItemId").setInteger("requisitionItemId", requisitionItemId);
		//ItemIssue itemIssue = (ItemIssue) query.uniqueResult();
		List<ItemIssue> itemIssue = new ArrayList<ItemIssue>(query.list());
		
		logger.info("entering getIssuedQtyByReqItemId");
		return itemIssue;
	}
	
	@Override
	public void saveStockAllocation(StockAllocation stockAllocation){
		logger.info("entering saveStockAllocation");
		Session session = sessionFactory.getCurrentSession();
		session.saveOrUpdate(stockAllocation);
		logger.info("exiting saveStockAllocation");
	}

	@Override
	public StockAllocation getStockById(Integer stockId) {
		logger.info("entering getStockById");
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery("from StockAllocation stock where stock=:stockId").setInteger("stockId", stockId);
		StockAllocation stock = (StockAllocation)query.uniqueResult();
		logger.info("entering getStockById");
		return stock;
	}
	
	
	@Override
	public String generateStockAllocationNo(String firmId) {
		logger.info("entering generateStockAllocationNo");
		logger.debug("param:firmId:" + firmId);
		Session session = sessionFactory.getCurrentSession();
		int month = 0;

		Calendar cal = Calendar.getInstance();
		month = cal.get(Calendar.MONTH);
		month = month + 1;
		int year = cal.get(Calendar.YEAR);
		if (month < 4) {
			year--;
		}

		String yyyy = "" + year;

		Query query = session
				.createQuery(" from  StockAllocation stockAllocation"
						+ "  where stockAllocation.order.firm.firmId=:firmId and stockAllocation.stockNo like:stockNo"
						+ " order by grpo.grpoId desc");

		query.setInteger("firmId", Integer.parseInt(firmId));
		query.setString("stockNo", "%" + yyyy);
		query.setMaxResults(1);

		StockAllocation stock = (StockAllocation) query.uniqueResult();
		
		String stockNo = null;
		if (stock != null) {
			logger.debug("stock:" + stock);
			String refCounter = stock.getStockNo().substring(stock.getStockNo().indexOf("/")+1,stock.getStockNo().lastIndexOf("/"));
			
			
			if (refCounter != null) {
				
				stockNo = "SA-"
						+ stock.getOrder().getFirm().getFirmCode()
								 + "/" + (Integer.parseInt(refCounter)+1) + "/"
						+ yyyy;
				}
				
			
			
		}else{
			logger.debug("Stock:" + stock);
			
			stockNo = "SA-"
						+ masterInfoService.getFirmById(firmId).getFirmCode() + "/1/"
						+ yyyy;
			
		}
		logger.debug("returnVal:" + stockNo.toString());
		logger.info("exiting generateStockAllocationNo");
		return stockNo;
	}
	
	
	@Override
	public String generateWarehouseRefNo(String firmId, String warehouseId) {
		logger.info("entering generateWarehouseRefNo");
		logger.debug("param:firmId:" + firmId);
		logger.debug("param:storeId:" + warehouseId);
		Session session = sessionFactory.getCurrentSession();
		
		int month = 0;

		Calendar cal = Calendar.getInstance();
		month = cal.get(Calendar.MONTH);
		month = month + 1;
		int year = cal.get(Calendar.YEAR);
		if (month < 4) {
			year--;
		}

		String yyyy = "" + year;

		Query query = session
				.createQuery(" from  WarehouseBorrow warehouserborrow"
						+ "  where warehouserborrow.fromFirm.firmId=:firmId and warehouserborrow.fromWarehouse.wareId =:wareId and warehouserborrow.warehouseRefNo like:refNo"
						+ " order by warehouserborrow.borrowId desc");

		query.setInteger("firmId", Integer.parseInt(firmId));
		query.setInteger("wareId", Integer.parseInt(warehouseId));
		query.setString("refNo", "%" + yyyy);
		query.setMaxResults(1);

		WarehouseBorrow warehouserborrow = (WarehouseBorrow) query.uniqueResult();
		
		String refNo = null;
		if (warehouserborrow != null) {
			logger.debug("warehouserborrow:" + warehouserborrow);
			String refCounter = warehouserborrow.getWarehouseRefNo().substring(warehouserborrow.getWarehouseRefNo().indexOf("/")+1,warehouserborrow.getWarehouseRefNo().lastIndexOf("/"));

			if (refCounter != null) {
				refNo = "WB-"
						+ warehouserborrow.getFromWarehouse()
								.getWarehouseCode() + "/" + (Integer.parseInt(refCounter)+1) + "/"
						+ yyyy;
			}
		}else{
			logger.debug("warehouserborrow:" + warehouserborrow);
			
			Warehouse warehouse = masterInfoService.getWareHouseById(warehouseId);
				
			refNo = "WB-"
						+ warehouse.getWarehouseCode() + "/1/"
						+ yyyy;
			
		}
		logger.debug("returnVal:" + refNo.toString());
		logger.info("exiting generateWarehouseRefNo");
		return refNo;
	}
	
}
