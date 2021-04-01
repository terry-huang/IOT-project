package com.deer.dao;

import org.apache.ibatis.annotations.Param;

public interface Trade_CardDao {
    int insertTrade_Card(@Param("trade_ID") Integer trade_ID, @Param("card_ID") Integer card_ID);
}
