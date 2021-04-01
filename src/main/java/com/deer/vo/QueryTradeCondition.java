package com.deer.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class QueryTradeCondition {
    private String startID;                 // 开始的订单号
    private String endID;                   // 结束的订单号
    private int status;                     // 状态 0未受理 1已受理
    private int select0;                    // 0-storeName(商家名) 1-ICCID(卡片ICCID)
                                            // 2-businessNumber(业务号码) 3-setName(套餐名称)
    private String input0;                  // select0对应输入内容
    private int server;                     // 运营商
    private String startCharge_time;        // 开始的购买时间
    private String endCharge_time;          // 结束的购买时间
    private int user_ID;                    // 用户ID
    private int type;                       // 订单类型
}
