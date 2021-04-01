package com.deer.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class QueryAccountTradeCondition {
    private String startID;                 // 开始的订单号
    private String endID;                   // 结束的订单号
    private int status;                     // 状态 0未受理 1已受理
    private String startCharge_time;        // 开始的购买时间
    private String endCharge_time;          // 结束的购买时间
    private int user_ID;                    // 用户ID
    private int type;                       // 订单类型
    private int payment_method;             // 支付方式
    private Float startCharge_trade;        // 起始充值金额
    private Float endCharge_trade;          // 结束充值金额
}
