package com.railtech.po.service;

import java.util.Set;

import com.railtech.po.entity.FlexiBean;
import com.railtech.po.entity.ItemIssue;
import com.railtech.po.exeception.RailtechException;

public interface StockService {
	
	public Set<ItemIssue> getItemIssue(FlexiBean requestParams) throws RailtechException;

	
}
