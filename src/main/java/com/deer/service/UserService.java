package com.deer.service;

import com.deer.domain.User;
import com.deer.vo.QueryUserCondition;

import java.util.List;
import java.util.Map;

public interface UserService {
    int registerUser(User user);
    Boolean loginUser(String name, String password);
    int deleteUser(int ID);
    User queryOneUserByName(String name);
    User queryOneUserByID(Integer ID);
    Integer queryOneUserIDByNamePassword(String name, String password);
    int updateUserPassword(int ID, String password);
    float queryOneUserCharge(int ID);
    Integer queryOneUserPriorityByID(int ID);
    List<User> queryAllUserWithoutRoot(int ID);
    Map<String, Object> queryAllUserInfo(int page);
    Map<String, Object> queryAllUserInfoByCondition(QueryUserCondition queryUserCondition, int page);
    int updateOneUserAllInfo(User user);
    List<User> queryUserWithNoProcessingTrade(List<User> userList);
    Integer queryOneUserIdByName(String name);
}
