package com.deer.service;

import com.deer.dao.CardDao;
import com.deer.dao.TradeDao;
import com.deer.domain.Trade;
import com.deer.vo.QueryTradeCondition;
import com.deer.vo.TradeDisplayInfo;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class TradeServiceImpl implements TradeService {

    private final int rootID = 5;
    private final int pageMax = 5;

    @Resource
    TradeDao tradeDao;

    @Resource
    CardDao cardDao;

    //声明Date类接收的数据格式
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private Date addTime;

    /**
     * 通过用户和类型获取订单
     * @param user_ID 用户ID
     * @param type 订单类型
     * @return
     */
    @Override
    public List<Trade> queryTradeInfoByUser_IDAndType(Integer user_ID, int type) {
        List<Trade> tradeList = null;
        if (user_ID == rootID){
            tradeList = tradeDao.queryTradeInfoByUser_IDAndType(null,type);
        }else{
            tradeList = tradeDao.queryTradeInfoByUser_IDAndType(user_ID,type);
        }
        return tradeList;
    }

    /**
     * 通过查询条件获得订单
     * @param queryTradeCondition 查询条件的实体类
     * @return
     */
    @Override
    public Map<String,Object> queryTradeInfoByCondition(int ID, QueryTradeCondition queryTradeCondition, int page) {
        Map<String,Object> map = new HashMap<>();
        if (ID==rootID){
            queryTradeCondition.setUser_ID(-1);
        }else{
            queryTradeCondition.setUser_ID(ID);
        }
        Page<Object> pageObject = PageHelper.startPage(page, pageMax);
        List<TradeDisplayInfo> tradeDisplayInfoList = tradeDao.queryTradeInfoByCondition(queryTradeCondition);
        map.put("tradeDisplayInfoList",tradeDisplayInfoList);
        int num = pageObject.getPages();
        map.put("maxPage",num);
        return map;
    }

    /**
     * 根据用户获得订单数量
     * @param user_ID 用户ID
     * @return 数量
     */
    @Override
    public Integer queryCountTrade(Integer user_ID) {
        return tradeDao.queryCountTrade(user_ID);
    }

    /**
     * 根据用户ID和订单类型获取订单显示简易信息
     * @param user_ID 用户ID
     * @param type 订单类型
     * @param page 页数
     * @return 订单显示建议信息
     */
    @Override
    public Map<String,Object> queryTradeDisplayInfoByUser_IDAndType(Integer user_ID, int type, int page) {
        List<TradeDisplayInfo> tradeDisplayInfoList = null;
        Map<String,Object> map = new HashMap<>();
        Page<Object> pageObject = null;
        if (user_ID == rootID) {
            pageObject = PageHelper.startPage(page, pageMax);
            tradeDisplayInfoList = tradeDao.queryTradeDisplayInfoByUser_IDAndType(null, type);
        } else {
            pageObject = PageHelper.startPage(page, pageMax);
            tradeDisplayInfoList = tradeDao.queryTradeDisplayInfoByUser_IDAndType(user_ID, type);
        }
        map.put("tradeDisplayInfoList",tradeDisplayInfoList);
        int num = pageObject.getPages();
        map.put("maxPage",num);
        return map;
    }

    /**
     * 通过运营商和用户查询已受理订单
     * @param user_ID 用户ID
     * @param type 订单类型
     * @param server 运营商
     * @return 订单的IDList
     */
    @Override
    public List<Integer> queryUnProfessTradeByUserAndServer(int user_ID, int type, int server) {
        List<Integer> IDList = tradeDao.queryUnProcessIDByUser(user_ID, type, server);
        return IDList;
    }

    /**
     * 根据用户ID获取已处理订单的数量
     * @param user_ID 用户ID
     * @return 用户订单数量
     */
    @Override
    public Integer queryCountProcessTradeByUser_ID(int user_ID) {
        if (user_ID==rootID){
            return tradeDao.queryCountProcessTradeByUser_ID(null);
        }else{
            return tradeDao.queryCountProcessTradeByUser_ID(user_ID);
        }
    }
}

