package com.railtech.po.service;

import java.util.List;

import com.railtech.po.entity.FlexiBean;
import com.railtech.po.entity.JobWork;
import com.railtech.po.entity.PurchaseOrder;
import com.railtech.po.entity.PurchaseOrderItem;
import com.railtech.po.entity.Rate;
import com.railtech.po.entity.RateApplied;


public interface PurchaseService {

	public PurchaseOrder getOrderById(Integer parseInt);

	public void savePurchaseOrder(PurchaseOrder purchase);

	public String generatePurchaseOrderNo(String firmId);

	public List<PurchaseOrder> getOrderList(FlexiBean requestParams);
	
	public void delete(PurchaseOrder purchase);

	public PurchaseOrderItem getOrderItemById(Integer orderItemId);

	public String generateJobWorkOrderNo(String firmId);

	public JobWork getJobWorkOrderById(Integer jobWorkId);

	public void saveJobWorkOrder(JobWork jobWork);

	public List<JobWork> getJobWorkList(FlexiBean requestParams);

	public JobWork getJobWorkById(Integer jobId);

	public void deleteJob(JobWork jobWork);

	public Rate getrateById(Integer rateId);

	public void saveRate(Rate rate);

	public List<PurchaseOrderItem> getOrderByProcurementId(Integer markingId);

	public PurchaseOrder getOrderByIdForGRPO(Integer orderId);

	public RateApplied getRateAppliedById(Integer rateAppliedId);

}
