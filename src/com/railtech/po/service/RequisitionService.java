/**
 * 
 */
package com.railtech.po.service;

import java.util.Set;

import com.railtech.po.entity.FlexiBean;
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


}
