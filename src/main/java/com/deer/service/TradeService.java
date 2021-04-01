package com.deer.service;

import com.deer.domain.Trade;
import com.deer.vo.QueryTradeCondition;
import com.deer.vo.TradeDisplayInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface TradeService {
    List<Trade> queryTradeInfoByUser_IDAndType(Integer user_ID, int type);
    Map<String,Object> queryTradeInfoByCondition(int ID, QueryTradeCondition queryTradeCondition, int page);
    Integer queryCountTrade(Integer user_ID);
    Map<String,Object> queryTradeDisplayInfoByUser_IDAndType(Integer user_ID, int type, int page);
    List<Integer> queryUnProfessTradeByUserAndServer(int user_ID, int type, int server);
    Integer queryCountProcessTradeByUser_ID(int user_ID);
}
