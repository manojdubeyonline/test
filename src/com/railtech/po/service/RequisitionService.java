/**
 * 
 */
package com.railtech.po.service;

import java.util.Set;

import com.railtech.po.entity.FlexiBean;
import com.railtech.po.entity.ItemIssue;
import com.railtech.po.entity.ItemStock;
import com.railtech.po.entity.Requisition;
import com.railtech.po.exeception.RailtechException;

/**
 * @author MANOJ
 *
 */
public interface RequisitionService {

	public Requisition getRequisitionById(Long requisitionId);

	public void delete(Requisition requisition);

	public Set<Requisition> getRequisitions(FlexiBean requestParams) throws RailtechException;
	
	void saveOrUpdate(Requisition requisition) throws RailtechException;

	public String generateRequisitionRefNo(String firmId, String storeId);

	public Requisition getRequisitionByRefNo(String refNo);

	public ItemStock getItemStock(String itemCode, String warehouseId);

	public void saveItemIssue(Requisition requisition);

	public ItemStock updateItemStock(ItemStock itemStock);

	public void saveItemIssue(ItemIssue itemIssue);


}
