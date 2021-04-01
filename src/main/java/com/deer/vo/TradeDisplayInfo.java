package com.deer.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class TradeDisplayInfo {
    private int trade_ID;           // 订单号码
    private String user_name;       // 商家名
    private float charge_trade;     // 订单金额
    private int number;             // 数量
    private String charge_time;     // 订单时间
    private String processing_time; // 受理时间
    private int status;             // 订单状态
    private int server;             // 订单所属运营商
}
