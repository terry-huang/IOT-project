package com.deer.dao;

import com.deer.domain.Card;
import com.deer.vo.CardDisplayInfo;
import com.deer.vo.QueryCardCondition;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface CardDao {
    Integer queryCountCardByServer(@Param("Server") int server, @Param("User_ID") Integer user_ID);
    Integer queryCountCardByStatus(@Param("status") String status);
    List<Card> queryAllInfoByServer(@Param("Server") int server, @Param("User_ID") Integer ID);
    List<CardDisplayInfo> queryAllDisplayInfoByServer(@Param("Server") int server, @Param("User_ID") Integer ID);
    List<Card> queryAllInfoByCondition(QueryCardCondition queryCardCondition, @Param("User_ID") Integer ID);
    List<CardDisplayInfo> queryAllDisplayInfoByCondition(QueryCardCondition queryCardCondition);
    int insertCard(Card card);
    double queryCardPriceByArray(String[] arrayICCID);
    double queryCardPriceByID(List<Integer> IDList);
    int updateCardUser(Map<String, Object> map);
    List<Card> queryUser_IDByICCIDArray(String[] arrayICCID);
    List<Integer> queryIDByICCIDList(List<String> ICCIDList);
    List<Integer> queryIDByICCIDArray(String[] arrayICCID);
    List<String> queryContinuousICCIDByICCID(@Param("frontICCID") String frontICCID, @Param("backICCID") String backICCID);
    int updateCardCurrentCharge(Map<String, Object> map);
    List<Card> checkCurrentChargeLessThan0(List<String> ICCIDList);
    List<String> checkCurrentChargeHighThan0(List<String> ICCIDList);
    int updateOneCardUserID(String ICCID, @Param("User_ID") int user_ID);
    List<Integer> queryCardByAmountAndUser_IDAndServer(@Param("amount") Integer amount, @Param("User_ID") Integer ID, @Param("Server") int server);
    int updateCardUser_IDByID(Map<String, Object> map);
    float queryCostByID(List<Integer> IDList);
    float queryPriceByID(List<Integer> IDList);
    List<Card> queryCardByTrade(@Param("Trade_ID") int trade_ID);
    CardDisplayInfo queryAllDisplayAllInfoByID(@Param("ID") Integer ID);
    String judgeICCIDIsTrue(String ICCID);
    List<Card> queryCardByServerOrderByPrice(@Param("Server") int server, @Param("User_ID") int user_ID);
    int queryServerByICCID(String ICCID);
    List<String> judgeICCIDListIsExist(List<String> ICCIDList);
    int updateRemark(Map<String, Object> map);
    int queryOneUserCard(@Param("User_ID") int user_ID);
    List<String> queryICCIDByServer(@Param("Server") int server, @Param("User_ID") Integer user_ID);
}
