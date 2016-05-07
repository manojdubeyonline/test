package com.railtech.po.service;

import java.util.List;

import com.railtech.po.entity.FlexiBean;
import com.railtech.po.entity.GRPO;
import com.railtech.po.entity.GRPOReceiptEntry;
import com.railtech.po.entity.PurchaseOrder;

public interface GRPOService {


	public void saveGrpo(GRPO purchase);
	public GRPO getGRPOById(Integer grpoId);
	public List<GRPO> getGRPOList(FlexiBean requestParams);
	public void delete(GRPO grpo);
	//public String generateGoodsRecieptNo(String firmId);
	public GRPOReceiptEntry getGrpoRecieptById(Integer grpoRecieptId);
	public List<GRPOReceiptEntry> getOrderByOrderItemId(Integer OrderItemId);
	public String generateGoodsRecieptNo(String firmId, String wareId);
	

}
