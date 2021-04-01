package com.deer.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CardDisplayInfo {
    private int ID;                 // 数据库中的ID
    private int server;             // 运营商：0是移动，1是电信，2是联通
    private String ICCID;           // ICCID
    private String user_storeName;  // 所属商家
    private String set_name;        // 套餐名
    private String start_time;      // 有效起始时间
    private String end_time;        // 有效截止时间
    private float charge_used;      // 使用金额
    private float charge_current;   // 剩余金额
    private float cost;             // 卡片成本
    private float price;            // 卡片售价
    private String status;          // 卡片状态：未知
    private long IMEInumber;        // IMEI号码
    private String remark;          // 备注
    private long business_number;   // 业务号码
    private String silent_time;     // 沉默期限
    private String setStatus;       // 套餐状态
    private double flow_used;       // 使用的流量
    private double flow;            // 总流量
}
