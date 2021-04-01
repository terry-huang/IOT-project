package com.deer.service;

import com.deer.dao.AccountTradeDao;
import com.deer.dao.AccountTradeErrorDao;
import com.deer.dao.UserDao;
import com.deer.domain.AccountTrade;
import com.deer.domain.AccountTradeError;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AccountTradeErrorServiceImpl implements AccountTradeErrorService {

    private final int rootID = 5;
    private final int pageMax = 5;

    @Resource
    AccountTradeDao accountTradeDao;

    @Resource
    UserDao userDao;

    @Resource
    AccountTradeErrorDao accountTradeErrorDao;

    /**
     * 获取所有status为0的错误订单
     * @return 所有status为0的错误订单
     */
    @Override
    public List<AccountTradeError> queryAllError() {
        return accountTradeErrorDao.queryAllError();
    }

    /**
     * 插入错误日志
     * @param trade_ID 账户充值订单
     * @return 插入结果
     */
    @Override
    @Transactional
    public int insertErrorLog(int trade_ID) {
        Date time = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String addtime = sdf.format(time);
        return accountTradeErrorDao.insertErrorLog(trade_ID, addtime);
    }

    /**
     * 更新错误日志
     * @param ID 订单ID
     * @return 更新结果
     */
    @Override
    @Transactional
    public int updateErrorStatus(int ID) {
        Date time = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String addtime = sdf.format(time);
        return accountTradeErrorDao.updateErrorStatus(ID, addtime);
    }

    /**
     * 返回错误日志显示信息
     * @return 错误日志显示信息
     */
    @Override
    public Map<String,Object> queryAllDisplayInfo(int page) {
        Map<String,Object> map = new HashMap<>();
        Page<Object> pageObject = PageHelper.startPage(page, pageMax);
        List<AccountTradeError> accountTradeErrorList = accountTradeErrorDao.queryAllDisplayInfo();
        map.put("accountTradeErrorList",accountTradeErrorList);
        int num = pageObject.getPages();
        map.put("maxPage",num);
        return map;
    }

    /**
     * 定时解决Error
     */
    @Override
    @Transactional
    public void dealError() {
        List<AccountTradeError> accountTradeErrorList = accountTradeErrorDao.queryAllError();
        if (!accountTradeErrorList.isEmpty()){
            int trade_ID = 0;
            int ID = 0;
            int num = 0;
            for (AccountTradeError accountTradeError:accountTradeErrorList){
                ID = accountTradeError.getID();
                trade_ID = accountTradeError.getTrade_ID();
                AccountTrade accountTrade = accountTradeDao.queryTradeByID(trade_ID);
                int user_ID = accountTrade.getUser_ID();
                float chargeCurrent = userDao.queryOneUserCharge(user_ID);
                chargeCurrent+=accountTrade.getCharge_trade();
                num = userDao.updateOneUserCharge(user_ID, chargeCurrent);
                if (num!=1){
                    TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                    continue;
                }
                Date addTime = new Date();
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                num = accountTradeDao.updateStatusProcessingTimeByID(trade_ID, 1, sdf.format(addTime));
                if (num!=1){
                    TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                    continue;
                }
                Date time = new Date();
                String addtime = sdf.format(time);
                accountTradeErrorDao.updateErrorStatus(ID, addtime);
            }
        }
    }
}
