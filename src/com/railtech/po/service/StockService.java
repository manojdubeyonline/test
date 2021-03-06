package com.railtech.po.service;

import java.util.List;
import java.util.Set;

import com.railtech.po.entity.FlexiBean;
import com.railtech.po.entity.ItemIssue;
import com.railtech.po.entity.ItemStock;
import com.railtech.po.entity.PurchaseOrder;
import com.railtech.po.entity.StockAllocation;
import com.railtech.po.entity.WarehouseBorrow;
import com.railtech.po.exeception.RailtechException;

public interface StockService {
	
	public Set<ItemIssue> getItemIssue(FlexiBean requestParams) throws RailtechException;

	public WarehouseBorrow getWarehouseBorrowById(Integer parseInt);
	
	public List<ItemIssue> getIssuedQtyByReqItemId(Integer requisitionItemId);

	public void saveWarehouseBorrow(WarehouseBorrow borrow);
	
	public List<WarehouseBorrow> getBorrowList(FlexiBean requestParams);

	public String generateStockAllocationNo(String firmId);

	public StockAllocation getStockById(Integer stockId);

	public void saveStockAllocation(StockAllocation stockAllocation);

	public List<StockAllocation> getAllocationList(FlexiBean requestParams);

	public String generateWarehouseRefNo(String firmId, String warehouseId);

}
