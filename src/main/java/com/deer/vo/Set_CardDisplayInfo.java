package com.deer.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Set_CardDisplayInfo {
    private int ID;             // ID
    private int card_ID;        // 对应的卡片ID
    private String set_name;    // 对应的套餐名
    private String start_time;    // 套餐开始时间
    private String end_time;      // 套餐结束时间
}
