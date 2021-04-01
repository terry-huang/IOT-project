package com.deer.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Trade {
    private int ID;                 // 订单ID
    private int type;               // 订单类型（0为买卡，1为充值）
    private Integer number;         // 购卡数量
    private int user_ID;            // 用户ID
    private float charge_trade;     // 交易金额
    private float charge_server;    // 此处是给运营商的费用，对普通用户不展示
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private Date charge_time;       // 交易时间
    private int status;             // 交易状态
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private Date processing_time;   // 受理时间
    private int server;             // 订单所属运营商
}
