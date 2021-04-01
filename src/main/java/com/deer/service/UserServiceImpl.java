package com.deer.service;

import com.deer.dao.CardDao;
import com.deer.dao.UserDao;
import com.deer.domain.User;
import com.deer.vo.QueryUserCondition;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@Service
public class UserServiceImpl implements UserService {

    private final int rootID = 5;
    private final int pageMax = 5;

    @Resource
    private UserDao userDao;

    @Resource
    private CardDao cardDao;

    /**
     * 用户注册
     * @param user 用户所有信息
     *             用户名 密码 真实姓名 身份证号 QQ 电话 商店名称
     * @return 注册结果
     */
    @Transactional
    @Override
    public int registerUser(User user) {
        String name = userDao.judgeNameIsExist(user.getName());
        if (user.getName().equals(name)){
            return 0;
        }
        user.setPriority(1);
        user.setStatus(1);
        user.setCharge(0);
        if (userDao.insertAllUser(user)==1){
            return 1;
        }else{
            return 2;
        }
    }

    /**
     * 用户登录验证
     * @param name 用户名
     * @param password 密码
     * @return 验证结果
     */
    @Transactional
    @Override
    public Boolean loginUser(String name, String password) {
        Integer ID = userDao.queryOneUserId(name,password);
        if (ID != null){
            return true;
        }
        return false;
    }

    /**
     * 用户删除
     * @param ID 删除用户ID
     * @return 删除结果
     */
    @Transactional
    @Override
    public int deleteUser(int ID) {
        if (cardDao.queryOneUserCard(ID)!=0){
            return 2;
        }
        if (userDao.deleteOneUser(ID)==1){
            return 1;
        }else{
            return 0;
        }
    }

    /**
     * 根据用户名获取信息
     * @param name 用户名
     * @return 用户所有信息
     */
    @Override
    public User queryOneUserByName(String name) {
        return userDao.queryOneUserByName(name);
    }

    /**
     * 根据ID获取信息
     * @param ID 用户在数据库中的ID
     * @return 用户所有信息
     */
    @Override
    public User queryOneUserByID(Integer ID) {
        return userDao.queryOneUserAllInfoByID(ID);
    }

    /**
     * 根据用户名和密码获取ID
     * @param name 用户名
     * @param password 密码
     * @return ID
     */
    @Override
    public Integer queryOneUserIDByNamePassword(String name, String password) {
        return userDao.queryOneUserId(name,password);
    }

    /**
     * 根据用户ID更改密码
     * @param ID 用户ID
     * @param password 密码
     * @return 更改结果
     */
    @Override
    @Transactional
    public int updateUserPassword(int ID, String password) {
        int num = userDao.updateOneUserPassword(ID,password);
        return num;
    }

    /**
     * 根据ID获取用户余额
     * @param ID 用户ID
     * @return 余额
     */
    @Override
    public float queryOneUserCharge(int ID) {
        return userDao.queryOneUserCharge(ID);
    }

    /**
     * 根据ID获取用户权限
     * @param ID 用户ID
     * @return 权限
     */
    @Override
    public Integer queryOneUserPriorityByID(int ID) {
        return userDao.queryOneUserPriorityByID(ID);
    }

    /**
     * 获取非管理员的用户
     * @param ID 管理员ID
     * @return userList
     */
    @Override
    public List<User> queryAllUserWithoutRoot(int ID) {
        return userDao.queryAllUserWithoutRoot(ID);
    }

    /**
     * 按页数查询userList和总页数
     * @param page 当前页的页数
     * @return userList maxPage
     */
    @Override
    public Map<String,Object> queryAllUserInfo(int page) {
        Map<String,Object> map = new HashMap<>();
        Page<Object> pageObject = PageHelper.startPage(page, pageMax);
        List<User> userList = userDao.queryAllUserInfo();
        map.put("userList",userList);
        int num = pageObject.getPages();
        map.put("maxPage",num);
        return map;
    }

    /**
     * 根据条件和页数查询
     * @param queryUserCondition 查询条件
     * @param page 页数
     * @return userList page
     */
    @Override
    public Map<String, Object> queryAllUserInfoByCondition(QueryUserCondition queryUserCondition, int page) {
        Map<String,Object> map = new HashMap<>();
        Page<Object> pageObject = PageHelper.startPage(page, pageMax);
        List<User> userList = userDao.queryAllUserInfoByCondition(queryUserCondition);
        map.put("userList",userList);
        int num = pageObject.getPages();
        map.put("maxPage",num);
        return map;
    }

    /**
     * 更新一个用户所有的信息
     * @param user 用户信息
     * @return 更新结果
     */
    @Override
    @Transactional
    public int updateOneUserAllInfo(User user) {
        return userDao.updateOneUserAllInfo(user);
    }

    /**
     * 查询拥有未处理订单的用户
     * @param userList 用户的user
     * @return userList
     */
    @Override
    public List<User> queryUserWithNoProcessingTrade(List<User> userList) {
        return userDao.queryUserWithNoProcessingTrade(userList);
    }

    @Override
    public Integer queryOneUserIdByName(String name) {
        return userDao.queryOneUserIdByName(name);
    }
}
