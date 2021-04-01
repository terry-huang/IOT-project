package com.deer.dao;

import com.deer.domain.AccountTrade;
import com.deer.vo.QueryAccountTradeCondition;
import com.deer.vo.QueryTradeCondition;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AccountTradeDao {
    int insertAccountRechargeTrade(AccountTrade accountTrade);
    List<AccountTrade> queryAccountTradeAllInfoByUser_IDAndType(@Param("User_ID") Integer user_ID, @Param("type") int type);
    int updateStatusProcessingTimeByID(@Param("ID") int ID, @Param("status") int status, @Param("processing_time") String processing_time);
    AccountTrade queryTradeByID(int ID);
    List<AccountTrade> queryAccountTradeInfoByCondition(QueryAccountTradeCondition queryAccountTradeCondition);
    int queryTradeStatusByID(int ID);
}
