package com.deer.service;

import com.deer.domain.AccountTrade;
import com.deer.vo.QueryAccountTradeCondition;
import com.deer.vo.QueryTradeCondition;

import java.util.List;
import java.util.Map;

public interface AccountTradeService {
    int accountRechargeTradeRecord(AccountTrade accountTrade);
    int accountRecharge(int userID, float charge, int ID);
    Map<String,Object> queryAccountTradeAllInfo(Integer user_ID, int type, int page);
    AccountTrade queryTradeByID(int ID);
    Map<String,Object> queryAccountTradeInfoByCondition(QueryAccountTradeCondition queryAccountTradeCondition, int page);
    int queryTradeStatusByID(int ID);
}
