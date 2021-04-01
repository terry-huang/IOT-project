package com.deer.dao;

import com.deer.domain.Trade;
import com.deer.vo.QueryTradeCondition;
import com.deer.vo.TradeDisplayInfo;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface TradeDao {
    Integer queryCountTrade(@Param("User_ID") Integer user_ID);
    int insertTrade(Trade trade);
    List<Trade> queryTradeInfoByUser_IDAndType(@Param("User_ID") Integer user_ID, @Param("type") int type);
    List<TradeDisplayInfo> queryTradeDisplayInfoByUser_IDAndType(@Param("User_ID") Integer user_ID, @Param("type") int type);
    List<TradeDisplayInfo> queryTradeInfoByCondition(QueryTradeCondition queryTradeCondition);
    Trade queryTradeByID(int ID);
    List<Integer> queryUnProcessIDByUser(@Param("User_ID") int user_ID, @Param("Type") int type, @Param("Server") int server);
    int updateOneTradeStatusAndProcessingTimeByID(@Param("Processing_time") Date processing_time, @Param("status") int status, @Param("ID") int ID);
    Integer queryCountProcessTradeByUser_ID(@Param("User_ID") Integer user_ID);
}
