package com.railtech.po.service;

import java.util.List;
import java.util.Set;

import com.railtech.po.entity.FlexiBean;
import com.railtech.po.entity.ItemStock;
import com.railtech.po.entity.Procurement;
import com.railtech.po.exeception.RailtechException;

public interface ProcurementService {
	public Set<ItemStock> getStockList(FlexiBean requestParams) throws RailtechException;
	public Procurement getProcurementById(Integer procurementId);
	public List<Procurement> getProcurements(FlexiBean requestParams);
	public List<Procurement> getProcurementByMultipleId(String procurementId);
	public void saveProcurementMarking(Procurement procurement);
	public Double getProcureQtyByReqItemId(Integer requisitionItemId);
}
