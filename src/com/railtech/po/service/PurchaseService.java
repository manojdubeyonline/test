package com.railtech.po.service;

import java.util.List;

import com.railtech.po.entity.FlexiBean;
import com.railtech.po.entity.PurchaseOrder;


public interface PurchaseService {

	public PurchaseOrder getOrderById(Integer parseInt);

	public void savePurchaseOrder(PurchaseOrder purchase);

	public String generatePurchaseOrderNo(String firmId);

	public List<PurchaseOrder> getOrderList(FlexiBean requestParams);
	
	public void delete(PurchaseOrder purchase);

}
