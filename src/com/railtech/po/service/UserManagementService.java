package com.railtech.po.service;

import java.util.Set;

import com.railtech.po.entity.User;
import com.railtech.po.exeception.RailtechException;

public interface UserManagementService {
	public void addUser(User user) throws RailtechException;
	public Set<User> getUserList() throws RailtechException;
	public User modifyUser(User user);
	public void delete(User user);
	public User getUserByUserId(Long userId);
	public User getUserByUserName(String userName);

}
