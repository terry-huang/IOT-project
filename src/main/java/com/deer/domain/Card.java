package com.deer.domain;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Card {
    private int ID;             // 数据库中的ID
    private String server;      // 运营商
    private String ICCID;       // ICCID
    private int user_ID;        // 所属商家
    private int set_ID;         // 套餐ID
    private String start_time;  // 有效起始时间
    private String end_time;    // 有效截止时间
    private float charge_used;  // 使用金额
    private float charge_current;   // 剩余金额
    private float cost;         // 卡片成本
    private float price;        // 卡片售价
    private Integer status;     // 卡片状态
    private long IMEInumber;    // IMEI号码
    private String remark;      // 备注
    private long business_number;   // 业务号码
    private String silent_time; // 沉默期限
    private long trade_ID;      // 购买卡片时的订单号
    private String setStatus;   // 套餐状态

}
