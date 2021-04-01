package com.deer.dao;

import com.deer.domain.User;
import com.deer.vo.QueryUserCondition;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserDao {
    Integer insertAllUser(User user);
    Integer queryOneUserId(@Param("name") String name, @Param("password") String password);
    Integer deleteOneUser(@Param("ID") int ID);
    float queryOneUserCharge(@Param("ID") int ID);
    User queryOneUserAllInfoByID(@Param("ID") int ID);
    User queryOneUserByName(@Param("name") String name);
    Integer updateOneUserCharge(@Param("ID") int ID, @Param("Charge") double charge);
    Integer updateOneUserPassword(@Param("ID") int ID, @Param("Password") String password);
    Integer queryOneUserPriorityByID(@Param("ID") int ID);
    List<User> queryAllUserWithoutRoot(int ID);
    String judgeNameIsExist(@Param("Name") String name);
    List<User> queryAllUserInfo();
    List<User> queryAllUserInfoByCondition(QueryUserCondition queryUserCondition);
    int updateOneUserAllInfo(User user);
    List<User> queryUserWithNoProcessingTrade(List<User> userList);
    Integer queryOneUserIdByName(@Param("name") String name);
}