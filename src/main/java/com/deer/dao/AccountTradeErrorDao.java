package com.deer.dao;

import com.deer.domain.AccountTradeError;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AccountTradeErrorDao {
    List<AccountTradeError> queryAllError();
    int insertErrorLog(int trade_ID, String time);
    int updateErrorStatus(@Param("ID") int ID, @Param("processing_time") String processing_time);
    List<AccountTradeError> queryAllDisplayInfo();
}
