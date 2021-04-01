package com.deer.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AccountTrade {
    private int ID;                     // 账户订单ID
    private float charge_trade;         // 充值/提现金额
    private float charge_server;        // 手续费
    private String charge_time;         // 交易时间
    private String processing_time;     // 受理时间
    private Integer payment_method;     // 支付方式（type为0时才有）
    private int status;                 // 交易状态
    private int type;                   // 交易类型（0为充值，1为提现）
    private String cash_account;        // 提现账号（type为1时才有）
    private int user_ID;                // 对应user表的ID
}
