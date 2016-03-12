package com.railtech.po.service;

import java.util.List;
import java.util.Set;

import com.railtech.po.entity.FlexiBean;
import com.railtech.po.entity.ItemIssue;
import com.railtech.po.entity.PurchaseOrder;
import com.railtech.po.entity.WarehouseBorrow;
import com.railtech.po.exeception.RailtechException;

public interface StockService {
	
	public Set<ItemIssue> getItemIssue(FlexiBean requestParams) throws RailtechException;

	public WarehouseBorrow getWarehouseBorrowById(Integer parseInt);
	
	public Double getIssuedQtyByReqItemId(Integer requisitionItemId);

	public void saveWarehouseBorrow(WarehouseBorrow borrow);
	
	public List<WarehouseBorrow> getBorrowList(FlexiBean requestParams);
	
}
