package com.deer.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Set {
    private int ID;             // 套餐ID
    private int server;         // 运营商：0是移动，1是电信，2是联通
    private String name;        // 套餐名
    private float cost;         // 套餐成本（支付给运营商的）
    private float profit;       // 套餐利润
    private int flow;           // 流量
    private int time_month;     // 套餐持续时间，以月为单位
}
