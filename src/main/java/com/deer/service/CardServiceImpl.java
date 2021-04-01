package com.deer.service;

import com.deer.dao.CardDao;
import com.deer.dao.TradeDao;
import com.deer.dao.Trade_CardDao;
import com.deer.dao.UserDao;
import com.deer.domain.Card;
import com.deer.domain.Trade;
import com.deer.domain.User;
import com.deer.vo.CardDisplayInfo;
import com.deer.vo.QueryCardCondition;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import javax.annotation.Resource;
import java.util.*;

@Service
public class CardServiceImpl implements CardService {

    private final int rootID = 5;
    private final int pageMax = 5;

    @Resource
    private CardDao cardDao;

    @Resource
    private UserDao userDao;

    @Resource
    private TradeDao tradeDao;

    @Resource
    private Trade_CardDao trade_cardDao;

    //声明Date类接收的数据格式
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private Date addTime;

    /**
     * 根据运营商查询卡片信息
     * @param server 运营商名
     * @return 所有卡片的所有信息
     */
    @Transactional
    @Override
    public List<Card> queryAllInfoByServer(int server, Integer ID) {
        PageHelper.startPage(1,2);
        List<Card> cardList = cardDao.queryAllInfoByServer(server, ID);
        return cardList;
    }

    /**
     * 根据条件（包括高级查询条件）查询信息
     * @param queryCardCondition 查询条件
     * @param ID 用户ID
     * @return 符合条件的所有卡片的所有信息
     */
    @Transactional
    @Override
    public List<Card> queryAllInfoByCondition(QueryCardCondition queryCardCondition, Integer ID) {
        if (ID!=null){
            queryCardCondition.setUserID(ID);
        }
        List<Card> cardList = cardDao.queryAllInfoByCondition(queryCardCondition, ID);
        return cardList;
    }

    /** 划拨功能
     * @param arrayICCID 卡片的ICCID
     * @param ID 用户的ID
     * @return  >0   用户余额不足
     *          -1   数据库表信息更新成功，功能完成
     *          -2   数据库表更新出现异常
     */
    @Transactional
    @Override
    public double transferCardToCustomer(String[] arrayICCID, int ID, int trade_ID) {
        int a = 0, b = 0, c = 0;
        User user = userDao.queryOneUserAllInfoByID(ID);
        User rootUser = userDao.queryOneUserAllInfoByID(rootID);
        Trade trade = tradeDao.queryTradeByID(trade_ID);
        if (arrayICCID.length!=trade.getNumber()){
            return -5;
        }
        double sumPrice = trade.getCharge_trade();
        if (sumPrice>user.getCharge()){
            return sumPrice;
        }else{
            user.setCharge((float)(user.getCharge()-sumPrice));
            rootUser.setCharge((float)(rootUser.getCharge()+sumPrice));
            a = userDao.updateOneUserCharge(user.getID(),user.getCharge());
            c = userDao.updateOneUserCharge(rootUser.getID(),rootUser.getCharge());
            Map map = new HashMap();
            map.put("arrayICCID",arrayICCID);
            map.put("User_ID",user.getID());
            b = cardDao.updateCardUser(map);
        }
        if (b==arrayICCID.length && c==1 && a==1) {
            addTime = new Date();
            a = tradeDao.updateOneTradeStatusAndProcessingTimeByID(addTime, 1, trade_ID);
            if (a!=1){
                return -3;
            }
            List<Integer> IDList = cardDao.queryIDByICCIDArray(arrayICCID);
            for (Integer cardID:IDList){
                a = trade_cardDao.insertTrade_Card(trade_ID, cardID);
                if (a!=1){
                    return -4;
                }
            }
            return -1;
        }else{
            return -2;
        }
    }

    /**
     * 判断卡片是否不是ID持有的
     * @param arrayICCID 选中卡片的ICCID
     * @param judge 判断需要的是什么卡片
     *              0 代表公司持有的卡片
     *              1 代表非公司持有即用户持有的卡片
     * @return map
     *         返回持有的卡片
     */
    @Transactional
    @Override
    public List<String> judgeIdIsAlone(String[] arrayICCID, int judge) {
        List<Card> cardList = cardDao.queryUser_IDByICCIDArray(arrayICCID);
        List<String> ICCIDList1 = new ArrayList<>();
        List<String> ICCIDList2 = new ArrayList<>();
        Map<String, Object> map = new HashMap();
        for (Card card : cardList) {
            if (rootID == card.getUser_ID()) {
                ICCIDList1.add(card.getICCID());
            } else {
                ICCIDList2.add(card.getICCID());
            }
        }
        if (judge == 0){
            return ICCIDList1;
        }else{
            return ICCIDList2;
        }
    }

    /**
     * 将所有的ICCID号码转换为ID，包括（#）连接的连续的ICCID
     * @param strICCID 所有的ICCID
     * @param type 是否需要检测ICCID在仓库中 true为需要
     * @return 所有的ICCID对应的ID
     */
    @Transactional
    @Override
    public List<String> queryContinuousICCID(String strICCID, boolean type) {
        List<String> ICCIDList = new ArrayList<>();
        System.out.println(strICCID);
        String[] splitICCID = strICCID.split("\n");
        String[] twoICCID = new String[2];
        for (String str:splitICCID){
            if (str.contains("#")){
                twoICCID = str.split("#");
                List<String> list = cardDao.queryContinuousICCIDByICCID(twoICCID[0],twoICCID[1]);
                ICCIDList.addAll(list);
            }else{
                if (type) {
                    str = cardDao.judgeICCIDIsTrue(str);
                }
                ICCIDList.add(str);
            }
        }
        return ICCIDList;
    }

    /**
     * 为卡片续费
     * @param ICCIDList 卡片的ICCID号码
     * @param ID 用户的ID
     * @param charge_trade 续费的金额
     * @return 0 用于余额不足
     *         1 更新user余额失败
     *         2 更新卡片余额失败
     *         3 操作成功
     */
    @Transactional
    @Override
    public int rechargeCard(List<String> ICCIDList, Integer ID, float charge_trade) {
        int num = 0;
        float charge_server = 0;
        User user = userDao.queryOneUserAllInfoByID(ID);
        double sumPrice = charge_trade*ICCIDList.size();
        if (sumPrice > user.getCharge()){
            return 0;
        }
        user.setCharge((float)(user.getCharge()-sumPrice));
        num = userDao.updateOneUserCharge(user.getID(),user.getCharge());
        if (num != 1){
            return 1;
        }
        Map<String,Object> map = new HashMap<>();
        map.put("ICCIDList",ICCIDList);
        map.put("charge_trade",charge_trade);
        num = cardDao.updateCardCurrentCharge(map);
        if (num != ICCIDList.size()){
            return 2;
        }
        // 更新订单表
        addTime = new Date();
        Trade trade = new Trade();
        trade.setType(1);
        trade.setUser_ID(ID);
        trade.setCharge_trade((float)sumPrice);
        trade.setCharge_server(charge_server);
        trade.setNumber(ICCIDList.size());
        trade.setStatus(1);
        trade.setCharge_time(addTime);
        num = tradeDao.insertTrade(trade);
        if (num!=1){
            return 3;
        }
        List<Integer> IDList = cardDao.queryIDByICCIDList(ICCIDList);
        Integer trade_ID = trade.getID();
        for (int ID1:IDList){
            num = trade_cardDao.insertTrade_Card(trade_ID, ID1);
            if (num!=1){
                return 4;
            }
        }
        return 5;
    }

    /**
     * 回收卡片
     * @param ICCID 卡片ICCID
     * @return 0 数据更新错误
     *         1 执行成功
     */
    @Override
    @Transactional
    public int recoverCard(String ICCID[]) {
        Map<String,Object> map = new HashMap();
        map.put("arrayICCID",ICCID);
        map.put("User_ID",rootID);
        int num = cardDao.updateCardUser(map);
        //成功
        if (num==ICCID.length){
            return 1;
        }
        return 0;
    }

    /**
     * 筛选卡片余额小于0
     * @param ICCIDList 卡片的ICCID
     * @return 欠费卡片
     */
    @Override
    public List<Card> checkCurrentChargeLessThan0(List<String> ICCIDList) {
        List<Card> cardList = cardDao.checkCurrentChargeLessThan0(ICCIDList);
        return cardList;
    }

    /**
     * 筛选卡片余额大于0
     * @param ICCIDList 卡片的ICCID
     * @return 不欠费卡片的ICCID
     */
    @Override
    public List<String> checkCurrentChargeHighThan0(List<String> ICCIDList) {
        List<String> ICCIDList1 = cardDao.checkCurrentChargeHighThan0(ICCIDList);
        return ICCIDList1;
    }

     /**
     * 购买卡片，记录订单
     * @param amount 购买数量
     * @param ID 购买用户的ID
     * @return 1 用户余额不足
     *         4 订单更新错误
     *         6 执行成功
     */
    @Transactional
    @Override
    public int purchaseCard(int amount, int ID, int server) {
        int num = 0;
        double sumPrice = 0;
        List<Integer> IDList = cardDao.queryCardByAmountAndUser_IDAndServer(amount, rootID, server);
        sumPrice = 10*amount;
        User user = userDao.queryOneUserAllInfoByID(ID);
        if (sumPrice > user.getCharge()) {
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            return 1;
        }
        // 增加订单记录
        addTime = new Date();
        Trade trade = new Trade();
        trade.setType(0);
        trade.setNumber(amount);
        trade.setUser_ID(ID);
        trade.setCharge_trade((float)sumPrice);
        trade.setCharge_server(0);
        trade.setCharge_time(addTime);
        trade.setStatus(0);
        trade.setServer(server);
        num = tradeDao.insertTrade(trade);
        if (num!=1){
            TransactionAspectSupport.currentTransactionStatus()
                    .setRollbackOnly();
            return 4;
        }
        return 6;
    }

    /**
     * 根据订单数据表的ID返回对应的卡片信息
     * @param trade_ID 订单表的ID
     * @return 卡片
     */
    @Override
    public List<Card> queryCardByTrade(int trade_ID) {
        List<Card> cardList = cardDao.queryCardByTrade(trade_ID);
        return cardList;
    }

    /**
     * 根据运营商和ID返回卡片数量
     * @param server 运营商
     * @return 卡片数量
     */
    @Override
    public int queryCountCardByServer(int server, int user_ID) {
        if (user_ID==rootID){
            return cardDao.queryCountCardByServer(server, null);
        }else{
            return cardDao.queryCountCardByServer(server, user_ID);
        }
    }

    /**
     * 根据运营商和ID返回显示信息
     * @param server 运营商
     * @param ID 用户ID
     * @return 显示的卡片信息
     */
    @Override
    public Map<String,Object> queryAllDisplayInfoByServer(int server, Integer ID, int page) {
        Map<String,Object> map = new HashMap<>();
        Page<Object> pageObject = PageHelper.startPage(page, pageMax);
        map.put("cardDisplayInfoList",cardDao.queryAllDisplayInfoByServer(server, ID));
        int num = pageObject.getPages();
        map.put("num",num);
        return map;
    }

    /**
     * 根据条件（包括高级查询条件）查询显示信息
     * @param queryCardCondition 查询条件
     * @return 符合条件的所有卡片的所有信息
     */
    @Override
    public Map<String,Object> queryAllDisplayInfoByCondition(QueryCardCondition queryCardCondition, int page) {
        Page<Object> pageObject = PageHelper.startPage(page, pageMax);
        Map<String,Object> map = new HashMap<>();
        map.put("cardDisplayInfoList",cardDao.queryAllDisplayInfoByCondition(queryCardCondition));
        int num = pageObject.getPages();
        map.put("num",num);
        return map;
    }

    /**
     * 根据卡片ID获得卡片的所有信息
     * @param ID 卡片ID
     * @return 卡片的所有信息
     */
    @Override
    public CardDisplayInfo queryAllDisplayAllInfoByID(Integer ID) {
        return cardDao.queryAllDisplayAllInfoByID(ID);
    }

    /**
     * 根据ICCID获得ID
     * @param ICCID ICCID
     * @return IDList
     */
    @Override
    public Integer queryIDByICCID(String ICCID) {
        List<String> ICCIDList = new ArrayList<>();
        ICCIDList.add(ICCID);
        return cardDao.queryIDByICCIDList(ICCIDList).get(0);
    }

    /**
     * 登记卡片（插入卡片）
     * @param card 卡片的除了ICCID的信息
     * @param ICCIDList 卡片对应的ICCID
     * @return 插入结果
     */
    @Override
    @Transactional
    public List<String> insertCard(Card card, List<String> ICCIDList) {
        int num = 0;
        for (String ICCID:ICCIDList){
            card.setICCID(ICCID);
            num = cardDao.insertCard(card);
            if (num!=1){
                TransactionAspectSupport.currentTransactionStatus()
                        .setRollbackOnly();
                return null;
            }
            card.setBusiness_number(card.getBusiness_number()+1);
        }
        return ICCIDList;
    }

    /**
     * 获取两个字符串之间的连续字符串
     * @param strICCID 用户输入的字符串
     * @return 字符串List
     */
    @Override
    public List<String> queryContinuousICCIDFromNull(String strICCID) {
        List<String> ICCIDList = new ArrayList<>();
        System.out.println(strICCID);
        int i = 0;
        String[] splitICCID = strICCID.split("\n");
        String[] twoICCID = new String[2];
        for (String str:splitICCID){
            if (str.contains("#")){
                twoICCID = str.split("#");
                for (i = 0; i<twoICCID[0].length(); i++){
                    if (!(twoICCID[0].charAt(i) == (twoICCID[1].charAt(i)))){
                        break;
                    }
                }
                String tag = twoICCID[0].substring(0,i);
                int front = Integer.parseInt(twoICCID[0].substring(i, twoICCID[0].length()));
                int back = Integer.parseInt(twoICCID[1].substring(i, twoICCID[0].length()));
                List<String> list = new ArrayList<>();
                while(front!=(back+1)){
                    list.add(tag+front);
                    front++;
                }
                ICCIDList.addAll(list);
            }else{
                ICCIDList.add(str);
            }
        }
        return ICCIDList;
    }

    /**
     * 通过ICCID获得Server运营商
     * @param ICCID ICCID
     * @return 运营商
     */
    @Override
    public int queryServerByICCID(String ICCID) {
        return cardDao.queryServerByICCID(ICCID);
    }

    /**
     * 判断ICCID在表中是否存在
     * @param ICCIDList 需要判断的ICCID
     * @return 结果 如果list的一个元素是null，那么ICCID均不存在
     *              如果不是，则ICCID有存在的，并返回
     */
    @Override
    public List<String> judgeICCIDListIsExist(List<String> ICCIDList) {
        List<String> ICCIDList1 = new ArrayList<>();
        ICCIDList1 = cardDao.judgeICCIDListIsExist(ICCIDList);
        if (ICCIDList1.isEmpty()){
            ICCIDList1.add("null");
        }
        return ICCIDList1;
    }

    /**
     * 修改卡片的备注
     * @param ICCIDList 卡片的ICCID
     * @param remark 备注内容
     * @return 0 修改成功
     *         1 修改失败，请稍后尝试
     */
    @Override
    public int updateRemark(List<String> ICCIDList, String remark) {
        Map<String,Object> map = new HashMap<>();
        map.put("ICCIDList", ICCIDList);
        map.put("remark", remark);
        int num = cardDao.updateRemark(map);
        if (num!=ICCIDList.size()){
            return 1;
        }
        return 0;
    }

    /**
     * 根据server返回指定页的ICCID
     * @param server 服务商
     * @param page 页数
     * @return ICCIDList
     */
    @Override
    public List<String> queryICCIDByServerAndPage(int server, Integer user_ID, int page) {
        PageHelper.startPage(page, pageMax);
        List<String> ICCIDList = cardDao.queryICCIDByServer(server,user_ID);
        return ICCIDList;
    }
}
