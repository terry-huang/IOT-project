package com.deer.service;

import com.deer.domain.AccountTradeError;

import java.util.List;
import java.util.Map;

public interface AccountTradeErrorService {
    List<AccountTradeError> queryAllError();
    int insertErrorLog(int trade_ID);
    int updateErrorStatus(int ID);
    Map<String,Object> queryAllDisplayInfo(int page);
    void dealError();
}
