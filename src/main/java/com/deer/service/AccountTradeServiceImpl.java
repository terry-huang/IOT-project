package com.deer.service;

import com.deer.dao.AccountTradeDao;
import com.deer.dao.UserDao;
import com.deer.domain.AccountTrade;
import com.deer.vo.QueryAccountTradeCondition;
import com.deer.vo.QueryTradeCondition;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import javax.annotation.Resource;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AccountTradeServiceImpl implements AccountTradeService {

    private final int pageMax = 5;
    private final int rootID = 5;

    @Resource
    AccountTradeDao accountTradeDao;

    @Resource
    UserDao userDao;

    /**
     * 账户充值订单记录
     * @param accountTrade 账户充值实体类（含有账户充值的相关属性）
     * @return 执行结果
     */
    @Override
    @Transactional
    public int accountRechargeTradeRecord(AccountTrade accountTrade) {
        DecimalFormat df = new DecimalFormat("#.00");
        accountTrade.setCharge_server(Float.parseFloat(df.format(accountTrade.getCharge_trade()/1000)));
        Date addTime = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        accountTrade.setType(0);
        accountTrade.setCharge_time(sdf.format(addTime));
        accountTrade.setStatus(0);
        int num = 0;
        num = accountTradeDao.insertAccountRechargeTrade(accountTrade);
        if (num!=1){
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return -1;
        }

        return accountTrade.getID();
    }

    /**
     * 完成订单状态
     * @param userID 用户ID
     * @param charge 充值费用
     * @param ID 订单ID
     * @return 表格更新结果
     */
    @Override
    @Transactional
    public int accountRecharge(int userID, float charge, int ID) {
        int num = 0;
        float chargeCurrent = userDao.queryOneUserCharge(userID);
        chargeCurrent+=charge;
        if (chargeCurrent > 9999999){
            return 3;
        }
        num = userDao.updateOneUserCharge(userID, chargeCurrent);
        if (num!=1){
            return 0;
        }
        if (userID!=rootID) {
            chargeCurrent = userDao.queryOneUserCharge(rootID);
            chargeCurrent -= charge;
            num = userDao.updateOneUserCharge(rootID, chargeCurrent);
            if (num != 1) {
                return 0;
            }
        }
        Date addTime = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        num = accountTradeDao.updateStatusProcessingTimeByID(ID, 1, sdf.format(addTime));
        if (num!=1){
            return 1;
        }
        return 2;
    }

    /**
     * 根据用户和类型查询账户订单信息
     * @param user_ID 用户ID
     * @param type 订单类型
     * @return 订单列表
     */
    @Override
    public Map<String,Object> queryAccountTradeAllInfo(Integer user_ID, int type, int page) {
        Map<String,Object> map = new HashMap<>();
        Page<Object> pageObject = PageHelper.startPage(page, pageMax);
        List<AccountTrade> accountTradeList = accountTradeDao.queryAccountTradeAllInfoByUser_IDAndType(user_ID, type);
        map.put("accountTradeList",accountTradeList);
        int num = pageObject.getPages();
        map.put("num",num);
        return map;
    }

    /**
     * 根据ID获取订单
     * @param ID 订单ID
     * @return 订单
     */
    @Override
    public AccountTrade queryTradeByID(int ID){
        return accountTradeDao.queryTradeByID(ID);
    }

    /**
     * 根据查询条件获取订单
     * @param queryAccountTradeCondition 查询条件
     * @return 订单List
     */
    @Override
    public Map<String,Object> queryAccountTradeInfoByCondition(QueryAccountTradeCondition queryAccountTradeCondition, int page) {
        Map<String,Object> map = new HashMap<>();
        Page<Object> pageObject = PageHelper.startPage(page, pageMax);
        List<AccountTrade> accountTradeList = accountTradeDao.queryAccountTradeInfoByCondition(queryAccountTradeCondition);
        map.put("accountTradeList",accountTradeList);
        int num = pageObject.getPages();
        map.put("num",num);
        return map;
    }

    @Override
    public int queryTradeStatusByID(int ID) {
        return accountTradeDao.queryTradeStatusByID(ID);
    }
}
