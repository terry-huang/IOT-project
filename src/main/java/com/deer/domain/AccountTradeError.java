package com.deer.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AccountTradeError {
    private int ID;                     // 错误ID
    private int trade_ID;               // 账户充值订单ID
    private int status;                 // 状态 0 为解决 1 已解决
    private String time;                // 错误发生时间
    private String processing_time;     // 解决时间
}
