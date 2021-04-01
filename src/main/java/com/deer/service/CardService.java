package com.deer.service;

import com.deer.domain.Card;
import com.deer.vo.CardDisplayInfo;
import com.deer.vo.QueryCardCondition;

import java.util.List;
import java.util.Map;

public interface CardService {
    List<Card> queryAllInfoByServer(int server, Integer ID);
    List<Card> queryAllInfoByCondition(QueryCardCondition queryCardCondition, Integer ID);
    double transferCardToCustomer(String[] arrayICCID, int ID, int trade_ID);
    List<String> judgeIdIsAlone(String[] arrayICCID, int judge);
    List<String> queryContinuousICCID(String strICCID, boolean type);
    int rechargeCard(List<String> ICCIDList, Integer ID, float money);
    int recoverCard(String ICCID[]);
    List<Card> checkCurrentChargeLessThan0(List<String> ICCIDList);
    List<String> checkCurrentChargeHighThan0(List<String> ICCIDList);
    int purchaseCard(int amount, int ID, int server);
    List<Card> queryCardByTrade(int trade_ID);
    int queryCountCardByServer(int server, int user_ID);
    Map<String,Object> queryAllDisplayInfoByServer(int server, Integer ID, int page);
    Map<String,Object> queryAllDisplayInfoByCondition(QueryCardCondition queryCardCondition, int page);
    CardDisplayInfo queryAllDisplayAllInfoByID(Integer ID);
    Integer queryIDByICCID(String ICCID);
    List<String> insertCard(Card card, List<String> ICCIDList);
    List<String> queryContinuousICCIDFromNull(String strICCID);
    int queryServerByICCID(String ICCID);
    List<String> judgeICCIDListIsExist(List<String> ICCIDList);
    int updateRemark(List<String> ICCIDList, String remark);
    List<String> queryICCIDByServerAndPage(int server, Integer user_ID, int page);
}
