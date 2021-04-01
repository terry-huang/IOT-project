package com.deer.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class QueryCardCondition {
    private String startICCID;              // 开始的ICCID
    private String endICCID;                // 结束的ICCID
    private int select0;                    // 0为tradeID(订单ID) 1为storeName(商家名) 2为IMEInumber(IMEI号码) 3为remark(备注)
    private String input0;                  // 对应select0 用户输入的内容
    private int select1;                    // 0为start_time(激活时间) 1为setStartTime(套餐开始时间) 2为setEndTime(套餐结束时间)
    private String input1;                  // 对应select1 用户输入的内容
    private int server;                     // 运营商
    private String status;                  // 静默期，已激活等状态
    private Integer setStatus;                  // 套餐状态 0未到期，1即将到期，2已到期
    private float flow;                     // 流量 0未超出，1即将超出，2已超出
    private String silentTime;              // 沉默期限 0未到，1即将，2已超
    private Integer userID;                     // 用户ID
    private int  page;
}
