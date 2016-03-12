/**
 * 
 */
package com.railtech.po.service;

import java.util.List;
import java.util.Set;

import com.railtech.po.entity.FlexiBean;
import com.railtech.po.entity.ItemIssue;
import com.railtech.po.entity.ItemStock;
import com.railtech.po.entity.Requisition;
import com.railtech.po.entity.RequisitionItem;
import com.railtech.po.exeception.RailtechException;

/**
 * @author MANOJ
 *
 */
public interface RequisitionService {

	public Requisition getRequisitionById(Long requisitionId);

	public void delete(Requisition requisition);

	public List<Requisition> getRequisitions(FlexiBean requestParams) throws RailtechException;
	
	void saveOrUpdate(Requisition requisition) throws RailtechException;

	public String generateRequisitionRefNo(String firmId, String storeId);

	public Requisition getRequisitionByRefNo(String refNo);

	public ItemStock getItemStock(String itemCode, String warehouseId);

	//public void saveItemIssue(Requisition requisition);

	public void updateItemStock(ItemStock itemStock);

	public void saveItemIssued(ItemIssue itemIssue);

	public RequisitionItem getRequisitionItemById(Long requisitionItemId);

	


}
