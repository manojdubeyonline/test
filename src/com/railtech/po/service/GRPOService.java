package com.railtech.po.service;

import java.util.List;

import com.railtech.po.entity.FlexiBean;
import com.railtech.po.entity.GRPO;

public interface GRPOService {


	public void saveGRPO(GRPO purchase);
	public GRPO getGRPOById(Integer grpoId);
	public List<GRPO> getGRPOList(FlexiBean requestParams);

}
